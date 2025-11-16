// iam_fs будет использовать так:
#include "disk.h"
#include "../../../../libs/string.h"

// Чтение заголовка программы
int read_program_header(unsigned int disk_id, unsigned int lba) {
    unsigned char buffer[512];
    
    if (disk_read_sectors(disk_id, lba, 1, buffer) != DISK_STATUS_OK) {
        return -1;
    }
    
    // Проверяем сигнатуру "__iamprogramm__"
    if (strcmp(buffer, "__iamprogramm__") == 0) {
        // Нашли программу
        return 1;
    }
    
    return 0;
}

// Поиск всех программ на диске
void find_all_programs(unsigned int disk_id) {
    unsigned int total_sectors = disk_get_total_sectors(disk_id);
    
    for (unsigned int lba = 0; lba < total_sectors; lba++) {
        if (read_program_header(disk_id, lba)) {
            // Найдена программа, обрабатываем...
        }
    }
}