include Make.properties

link = $(linker) $(linker_flags) $(if $(strip $(linker_script_name)),-T rsrc/$(linker_script_name),)
cppcomp = $(cppc) $(cpp_flags) $(if $(strip $(include_directory_name)),-Irsrc/$(include_directory_name),)
asmcomp = $(asmc) $(asm_flags)

OUTDIR := rsrc/build_rsrc/output
SRCDIR := src
OBJDIR := rsrc/build_rsrc/tmp

output := $(OUTDIR)/bin/kernel.elf

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

all: info link

link: compile
	@mkdir -p $(dir $(output))
	$(link)  -o $(output) $(OBJECTS)
	@echo "✓ Linked $(TOTAL_OBJECTS) files into $(output)"


compile: clean $(OBJECTS)
	@echo "✓ Compiled $(TOTAL_SOURCES) files"

info:
	@echo "=== Build Information ==="
	@echo "Compiler: $(cppc)"
	@echo "Total Sources: $(TOTAL_SOURCES)"
	@echo "Source files: $(SOURCES)"
	@echo ""

clean:
	@echo "Cleaning build directory..."
	rm -rf $(OBJDIR)/*
	@echo ""

.PHONY: all info clean compile