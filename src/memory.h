#ifndef INCL_MEMORY
#define INCL_MEMORY

#define KEYBOARD_BUFFER_SIZE 16

// Структура элемента multiboot memory map
struct multiboot_mmap_entry {
    unsigned int size;
    unsigned long long addr;
    unsigned long long len;
    unsigned int type;
} __attribute__((packed));

/**
 * Инициализация менеджера памяти
 * @param mmap Указатель на начало доступной памяти
 * @param total_size Общий размер доступной памяти в байтах
 * @param max_procs Максимальное количество процессов для отслеживания
 */
void memory_init(unsigned char* mmap, unsigned int total_size, unsigned int max_procs);

/**
 * Выделение памяти для ядра
 * @param size Запрашиваемый размер в байтах
 * @return Указатель на выделенную память или NULL при ошибке
 */
void* kmalloc(unsigned int size);

/**
 * Выделение памяти для пользовательского процесса
 * @param size Запрашиваемый размер в байтах
 * @param process ID процесса (должен быть > 1)
 * @return Указатель на выделенную память или NULL при ошибке
 */
void* ualloc(unsigned int size, unsigned int process);

/**
 * Освобождение памяти, выделенной ядром
 * @param ptr Указатель на память, которую нужно освободить
 */
void kfree(void* ptr);

/**
 * Освобождение памяти, выделенной процессом
 * @param ptr Указатель на память, которую нужно освободить
 */
void ufree(void* ptr);

// Функции для получения статистики памяти

/**
 * @return Общий объем управляемой памяти в байтах
 */
unsigned int get_total_memory();

/**
 * @return Объем используемой памяти (включая служебные данные) в байтах
 */
unsigned int get_used_memory();

/**
 * @return Объем свободной памяти в байтах
 */
unsigned int get_free_memory();

/**
 * @return Объем памяти, используемой ядром (без служебных данных) в байтах
 */
unsigned int get_kernel_memory();

/**
 * Получение объема памяти, используемого процессом
 * @param process ID процесса
 * @return Объем памяти процесса в байтах или 0 если ID невалиден
 */
unsigned int get_process_memory(unsigned int process);

/**
 * Дефрагментация памяти - объединение соседних свободных блоков
 */
void memory_defragment();

// Информация о фрагментации

/**
 * @return Количество свободных блоков памяти (показатель фрагментации)
 */
unsigned int get_free_block_count();

/**
 * @return Размер самого большого доступного свободного блока в байтах
 */
unsigned int get_largest_free_block();

/**
 * Преобразование multiboot memory map в массив структур
 * @param mbi_addr Адрес начала memory map из multiboot info
 * @param mbi_len Длина memory map данных
 * @param count Указатель для возврата количества записей
 * @return Динамический массив записей memory map
 */
struct multiboot_mmap_entry* make_mmap_array(unsigned int mbi_addr, unsigned int mbi_len, unsigned int* count);

/**
 * Создание безопасной memory map из multiboot записей
 * @param entries Массив записей memory map
 * @param entry_count Количество записей в массиве
 * @param total_size Указатель для возврата общего размера найденной памяти
 * @return Указатель на начало доступной памяти или NULL при ошибке
 */
unsigned char* create_safe_mmap(struct multiboot_mmap_entry* entries,
                              unsigned int entry_count,
                              unsigned int* total_size);

/**
 * Инициализация всей системы памяти с использованием multiboot data
 * @param mmap_entries Массив записей memory map
 * @param mmap_count Количество записей в массиве
 */
void init_memory_system(struct multiboot_mmap_entry* mmap_entries, 
                       unsigned int mmap_count);

/**
 * Объединение соседних свободных блоков памяти (внутренняя функция)
 */
void merge_free_blocks();



#endif