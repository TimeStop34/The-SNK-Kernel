#[derive(Debug, Clone, Copy)]
pub struct CStr {
    data: [u16; 256],
    len: usize,
}

const VGA_WIDTH: usize = 80;
const VGA_HEIGHT: usize = 30;

impl CStr {
    // Создает colored string из обычной строки с одним цветом
    pub const fn new(text: &'static str, color: u8) -> Self {
        let bytes = text.as_bytes();
        let mut colored_data = [0u16; 256];
        let mut i = 0;
        
        while i < bytes.len() && i < 256 {
            colored_data[i] = (color as u16) << 8 | bytes[i] as u16;
            i += 1;
        }
        
        Self {
            data: colored_data,
            len: i,
        }
    }
    
    // Создает colored string с разными цветами для каждого символа
    pub const fn from_colored(chars: &[(u8, u8)]) -> Self { // (char, color)
        let mut colored_data = [0u16; 256];
        let mut i = 0;
        
        while i < chars.len() && i < 256 {
            let (ch, color) = chars[i];
            colored_data[i] = (color as u16) << 8 | ch as u16;
            i += 1;
        }
        
        Self {
            data: colored_data,
            len: i,
        }
    }
    
    // Возвращает данные для копирования в VGA буфер
    pub fn get_data(&self) -> &[u16] {
        &self.data[..self.len]
    }
    
    pub const fn len(&self) -> usize {
        self.len
    }
    
    // Специальная функция для создания panic сообщения
    pub const fn panic_message(code: u32, msg: &'static str) -> Self {
        let code_hex = Self::u32_to_hex(code);
        let mut data = [0u16; 256];
        let red = 0x4F; // белый на красном
        let mut i = 0;
        
        // "PANIC! Code: "
        let prefix = b"PANIC! Code: ";
        while i < prefix.len() {
            data[i] = (red as u16) << 8 | prefix[i] as u16;
            i += 1;
        }
        
        // hex код
        let mut j = 0;
        while j < 8 {
            data[i] = (red as u16) << 8 | code_hex[j] as u16;
            i += 1;
            j += 1;
        }
        
        // ", Message: "
        let middle = b", Message: ";
        j = 0;
        while j < middle.len() {
            data[i] = (red as u16) << 8 | middle[j] as u16;
            i += 1;
            j += 1;
        }
        
        // сообщение
        let msg_bytes = msg.as_bytes();
        j = 0;
        while j < msg_bytes.len() && i < 256 {
            data[i] = (red as u16) << 8 | msg_bytes[j] as u16;
            i += 1;
            j += 1;
        }
        
        Self { 
            data, 
            len: i 
        }
    }
    
    const fn u32_to_hex(num: u32) -> [u8; 8] {
        let hex_digits = b"0123456789ABCDEF";
        let mut result = [0u8; 8];
        let mut i = 0;
        
        while i < 8 {
            let shift = (7 - i) * 4;
            let nibble = ((num >> shift) & 0xF) as usize;
            result[i] = hex_digits[nibble];
            i += 1;
        }
        
        result
    }
}

// Отдельные функции для вывода
pub fn print_cstr(cstr: &CStr, start_pos: usize) {
    let vga_buffer = 0xB8000 as *mut u16;
    let data = cstr.get_data();
    
    unsafe {
        for (i, &char_data) in data.iter().enumerate() {
            if start_pos + i < VGA_WIDTH * VGA_HEIGHT {
                *vga_buffer.offset((start_pos + i) as isize) = char_data;
            }
        }
    }
}

pub fn print_cstr_centered(cstr: &CStr, row: usize) {
    if row >= VGA_HEIGHT { return; }
    
    let start_pos = row * VGA_WIDTH + (VGA_WIDTH - cstr.len()) / 2;
    print_cstr(cstr, start_pos);
}

pub fn print_cstr_at_line(cstr: &CStr, row: usize) {
    if row >= VGA_HEIGHT { return; }
    
    let start_pos = row * VGA_WIDTH;
    print_cstr(cstr, start_pos);
}