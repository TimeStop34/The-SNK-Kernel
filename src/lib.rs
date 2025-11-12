#![no_std]
#![no_main]

mod scheduler;
mod cstr;

use scheduler::*;
use cstr::*;

use core::panic::PanicInfo;
#[panic_handler]
fn _panic(_info: &PanicInfo) -> ! {
    loop {}
}

pub fn panic(code: u32, message: &str) {
    let vga_buffer = 0xB8000 as *mut u16;
    let color = 0x4F; // белый на красном
    
    let prefix = b"PANIC! Code: ";
    let middle = b", Message: ";
    
    unsafe {
        // "PANIC! Code: "
        for (i, &byte) in prefix.iter().enumerate() {
            *vga_buffer.offset(i as isize) = (color as u16) << 8 | byte as u16;
        }
        
        // код как hex
        let mut pos = prefix.len();
        for i in 0..8 {
            let shift = (7 - i) * 4;
            let nibble = (code >> shift) & 0xF;
            let char_byte = if nibble < 10 { 
                b'0' + nibble as u8 
            } else { 
                b'A' + (nibble - 10) as u8 
            };
            *vga_buffer.offset((pos + i) as isize) = (color as u16) << 8 | char_byte as u16;
        }
        
        // ", Message: "
        pos += 8;
        for (i, &byte) in middle.iter().enumerate() {
            *vga_buffer.offset((pos + i) as isize) = (color as u16) << 8 | byte as u16;
        }
        
        // само сообщение
        pos += middle.len();
        for (i, &byte) in message.as_bytes().iter().enumerate() {
            *vga_buffer.offset((pos + i) as isize) = (color as u16) << 8 | byte as u16;
        }
    }
    loop {}
}

#[no_mangle]
pub extern "C" fn start(magic: u32, mb_info_addr: u32) -> ! {
    // Проверяем Multiboot2 magic number
    if magic == 0x77846651 {
        panic(0x2, "LMAO! \n The standard that sets this magic is under PRIVATE development!\n  How did you even come up with the idea to launch a system with this number,\n or how did you launch SNK like that?");
    } else if magic != 0x36d76289 { 
        panic(0x1, "Not a Multiboot2-compliant bootloader");
    }
    
    unsafe { *(0xB8000 as *mut u64) = 0x3F4B3F4F; }
    unsafe {
        let buffer_size = 80 * 30;
        let vga_buffer = 0xB8000 as *mut u16;
        
        for i in 0..buffer_size {
            vga_buffer.add(i).write_volatile(' ' as u16 | 0x00Bf);
        }
    }

    print_cstr_centered(&CStr::new("SNK Kernel. Build 1", 0xBf), 0);
    print_cstr_centered(&CStr::new("Initializing...", 0xBf), 1);

    print_cstr(&CStr::new("Memory initializing...", 0xBf), 80*2);
    print_cstr(&CStr::new("Memory not initialized: Memory not realizated!", 0xBf), 80*2);

    let _scheduler = RRScheduler::new();

    loop {}
}
