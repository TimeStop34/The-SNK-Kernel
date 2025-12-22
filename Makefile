include Make.properties

link = $(linker) $(linker_flags) $(if $(strip $(linker_script_name)),-T "rsrc/$(linker_script_name)",)
cppcomp = $(cppc) $(cpp_flags) $(if $(strip $(include_directory_name)),-I"rsrc/$(include_directory_name)",)
asmcomp = $(asmc) $(asm_flags)

vm = qemu-system-$(vm_arch) $(vm_flags)

RSRC = rsrc/build_rsrc

OUTDIR := $(RSRC)/output
SRCDIR := src
OBJDIR := $(RSRC)/tmp

output := $(OUTDIR)/bin/kernel.elf
output-iso := $(OUTDIR)/iso/snk-kernel-$(version)

CPP_SOURCES := $(shell find $(SRCDIR) -name "*.cpp")
CPP_OBJECTS := $(CPP_SOURCES:$(SRCDIR)/%.cpp=$(OBJDIR)/cpp/%.o)

ASM_SOURCES := $(shell find $(SRCDIR) -name "*.asm")
ASM_OBJECTS := $(ASM_SOURCES:$(SRCDIR)/%.asm=$(OBJDIR)/asm/%.o)

SOURCES := $(CPP_SOURCES) $(ASM_SOURCES)
OBJECTS := $(CPP_OBJECTS) $(ASM_OBJECTS)

# Счетчик для прогресса
COUNT := 0
TOTAL_SOURCES := $(words $(SOURCES))
TOTAL_OBJECTS := $(words $(OBJECTS))

$(OBJDIR)/cpp/%.o: $(SRCDIR)/%.cpp | $(OBJDIR)
	@mkdir -p $(dir $@)
	@$(eval COUNT = $(shell echo $$(($(COUNT)+1))))
	@echo "[$(COUNT)/$(TOTAL_SOURCES)] [CPPC] $(patsubst $(SRCDIR)/%,%,$<)"
	@$(cppcomp) -c $< -o $@

$(OBJDIR)/asm/%.o: $(SRCDIR)/%.asm | $(OBJDIR)
	@mkdir -p $(dir $@)
	@$(eval COUNT = $(shell echo $$(($(COUNT)+1))))
	@echo "[$(COUNT)/$(TOTAL_SOURCES)] [ASM] $(patsubst $(SRCDIR)/%,%,$<)"
	@$(asmcomp) $< -o $@

all: info test

prepare_iso: link
	@cp $(output) "$(RSRC)/iso/boot/snk-kernel-$(version)"
	@mkdir -p $(OUTDIR)/iso
	@echo -e 'set default=0\nset timeout=0\n\nmenuentry "SNK Kernel" { \n	multiboot /boot/snk-kernel-$(version) \n	boot \n}' > "$(RSRC)/iso/boot/grub/grub.cfg"


iso: prepare_iso
	$(grub-mkrescue) -o "$(output-iso)" $(RSRC)/iso/

link: compile
	@mkdir -p "$(dir $(output))"
	$(link)  -o "$(output)" $(OBJECTS)
	@echo "✓ Linked $(TOTAL_OBJECTS) files into $(output)"


compile: clean $(OBJECTS)

	@echo "✓ Compiled $(TOTAL_SOURCES) files"

info:
	@echo "!=== SNK Info ===!"
	@echo "SNK Version: $(version)"
	@echo "Make Properties: Make.properties"
	@echo "Config file: Config.properties"
	@echo ""

	@echo "=== Build Information ==="
	@echo "Compilers: "
	@echo -e "\tC: $(cc) (Not supporting C compilation)"
	@echo -e "\tCPP: $(cppc)"
	@echo -e "\tASM: $(asmc)"
	@echo ""

	@echo "Builders:"
	@echo -e "\tLinker: $(linker)"
	@echo -e "\tGrub-MKRescue: $(grub-mkrescue)"
	@echo ""

	@echo "Total Sources: $(TOTAL_SOURCES)"
	@echo -e "Source files: \n\t$(SOURCES)"
	@echo ""

	@echo "=== Tester Information ==="
	@echo -e "\tVM: qemu-system-$(vm_arch)"
	@echo -e "\tVM Flags: $(vm_flags)"
	@echo ""

clean:
	@echo "Cleaning build directory..."
	rm -rf $(OBJDIR)/*
	@echo "" 

test: iso
	$(vm) -cdrom "$(output-iso)"

.PHONY: all info clean compile