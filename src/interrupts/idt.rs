// src/interrupts/idt.rs
use core::arch::asm;

#[repr(C, packed)]
pub struct IdtEntry {
    pub offset_low: u16,      // Младшие 16 бит смещения обработчика
    pub selector: u16,        // Селектор сегмента кода в GDT
    pub ist: u8,              // Номер стека в IST (0 = использовать текущий)
    pub type_attributes: u8,  // Флаги типа и доступа
    pub offset_mid: u16,      // Средние 16 бит смещения
    pub offset_high: u32,     // Старшие 32 бита смещения
    pub reserved: u32,        // Должно быть 0
}

impl IdtEntry {
    pub const fn new() -> Self {
        Self {
            offset_low: 0,
            selector: 0,
            ist: 0,
            type_attributes: 0,
            offset_mid: 0,
            offset_high: 0,
            reserved: 0,
        }
    }
}

#[repr(C, packed)]
pub struct IdtPointer {
    pub limit: u16,    // Размер IDT - 1
    pub base: u64,     // Адрес IDT
}

pub struct Idt {
    pub entries: [IdtEntry; 256],
    pub pointer: IdtPointer,
}

impl Idt {
    pub fn new() -> Self {
        let mut idt = Self {
            entries: [IdtEntry::new(); 256],
            pointer: IdtPointer {
                limit: 0,
                base: 0,
            },
        };
        
        // Рассчитываем лимит (размер таблицы - 1)
        idt.pointer.limit = (core::mem::size_of::<[IdtEntry; 256]>() - 1) as u16;
        idt.pointer.base = &idt.entries as *const _ as u64;
        
        idt
    }
    
    pub fn load(&self) {
        unsafe {
            asm!("lidt [{}]", in(reg) &self.pointer);
        }
    }
}

// Константы для флагов type_attributes
pub const IDT_FLAG_PRESENT: u8 = 0x80;
pub const IDT_FLAG_RING0: u8 = 0x00;
pub const IDT_FLAG_RING3: u8 = 0x60;
pub const IDT_FLAG_32BIT_INT: u8 = 0x0E;
pub const IDT_FLAG_32BIT_TRAP: u8 = 0x0F;