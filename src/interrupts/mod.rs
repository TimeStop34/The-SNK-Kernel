pub mod idt;

use idt::{Idt, IdtEntry, IDT_FLAG_PRESENT, IDT_FLAG_32BIT_INT, IDT_FLAG_RING0};

pub fn init_idt() {
    let mut idt = Idt::new();
    
    // Настройка прерывания таймера (IRQ0 = вектор 0x20)
    setup_timer_interrupt(&mut idt.entries[0x20]);
    
    // Загружаем IDT
    idt.load();
}

fn setup_timer_interrupt(entry: &mut IdtEntry) {
    // Устанавливаем адрес обработчика (extern функция из ассемблера)
    let handler_addr = timer_handler as u64;
    
    entry.offset_low = (handler_addr & 0xFFFF) as u16;
    entry.offset_mid = ((handler_addr >> 16) & 0xFFFF) as u16;
    entry.offset_high = ((handler_addr >> 32) & 0xFFFFFFFF) as u32;
    
    entry.selector = 0x08;  // Селектор кодового сегмента ядра
    entry.ist = 0;          // Использовать текущий стек
    entry.type_attributes = IDT_FLAG_PRESENT | IDT_FLAG_RING0 | IDT_FLAG_32BIT_INT;
}

// Объявляем внешнюю функцию обработчика из ассемблера
extern "C" {
    fn timer_handler();
}