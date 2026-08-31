use std::process::Command;
use std::env;
use std::path::PathBuf;
use std::fs;

fn main() {
    let manifest_dir = env::var("CARGO_MANIFEST_DIR").unwrap();
    let src_dir = PathBuf::from(&manifest_dir).join("src");
    let tmp_dir = PathBuf::from(&manifest_dir).join("tmp");

    fs::create_dir_all(&tmp_dir).expect("failed to create tmp directory");

    let asm_files = [
        ("i386/asm/boot.asm", "boot_asm.o"),
        ("i386/asm/early_gdt.asm", "early_gdt.o"),
    ];

    for (input, _output) in &asm_files {
        let full_path = src_dir.join(input);
        println!("cargo:rerun-if-changed={}", full_path.display());
    }

    for (input, output) in &asm_files {
        let input_path = src_dir.join(input);
        let output_path = tmp_dir.join(output);
        let status = Command::new("nasm")
            .args(&["-f", "elf32", "-o", output_path.to_str().unwrap(), input_path.to_str().unwrap()])
            .status()
            .expect(&format!("failed to execute nasm on {}", input));
        if !status.success() {
            panic!("NASM assembly failed for {}", input);
        }
    }

    let object_files: Vec<String> = asm_files.iter()
        .map(|(_, output)| output.to_string())
        .collect();

    let ar_status = Command::new("ar")
        .args(&["crus", "libbootloader.a"])
        .args(&object_files)
        .current_dir(&tmp_dir)   // работаем внутри tmp
        .status()
        .expect("failed to execute ar");
    if !ar_status.success() {
        panic!("ar failed");
    }

    // Указываем линковщику искать библиотеку в tmp
    println!("cargo:rustc-link-search=native={}", tmp_dir.display());
    println!("cargo:rustc-link-lib=static=bootloader");
}