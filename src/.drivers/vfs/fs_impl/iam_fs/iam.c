#include "iam.h"
#include "../../../disks/disk.h"
#include "../../../../libs/string.h"

// Структура заголовка iam файла
struct iam_file_header {
    char signature[12];
    char filename[256];
    unsigned char file_type;
};

// Операции iam_fs
static struct fs_operations iam_ops;

// БУФЕРЫ И ПЕРЕМЕННЫЕ
static unsigned char sector_buffer[512];
static struct file iam_files[32];
static unsigned int file_count = 0;

// ==================== ВСПОМОГАТЕЛЬНЫЕ ФУНКЦИИ ====================

static int find_signature(unsigned char* sector, const char* signature, int sig_len) {
    for (int i = 0; i <= 512 - sig_len; i++) {
        if (strncmp((char*)&sector[i], signature, sig_len) == 0) {
            return i;
        }
    }
    return -1;
}

static int read_filename(unsigned char* data, char* filename_buffer) {
    int i = 0;
    while (data[i] != '\0' && i < 255) {
        filename_buffer[i] = data[i];
        i++;
    }
    filename_buffer[i] = '\0';
    return i + 1;
}

static unsigned int find_file_end(unsigned int disk_id, unsigned int start_lba) {
    unsigned int current_lba = start_lba;
    
    while (1) {
        if (disk_read_sectors(disk_id, current_lba, 1, sector_buffer) != DISK_STATUS_OK) {
            return 0;
        }
        
        int pos = find_signature(sector_buffer, IAM_END_SIGNATURE, IAM_SIGNATURE_SIZE);
        if (pos >= 0) {
            return current_lba;
        }
        
        current_lba++;
    }
}

static int scan_disk_for_files(unsigned int disk_id) {
    file_count = 0;
    unsigned int total_sectors = disk_get_total_sectors(disk_id);
    
    for (unsigned int lba = 0; lba < total_sectors && file_count < 32; lba++) {
        if (disk_read_sectors(disk_id, lba, 1, sector_buffer) != DISK_STATUS_OK) {
            continue;
        }
        
        int pos = find_signature(sector_buffer, IAM_FILE_SIGNATURE, IAM_SIGNATURE_SIZE);
        if (pos >= 0) {
            unsigned char* file_data = &sector_buffer[pos + IAM_SIGNATURE_SIZE];
            
            // Временное имя файла
            char temp_name[256];
            int name_len = read_filename(file_data, temp_name);
            
            // Копируем имя (нужно выделить память!)
            iam_files[file_count].name = "file"; // Заглушка
            
            unsigned char file_type = file_data[name_len];
            unsigned int end_lba = find_file_end(disk_id, lba);
            
            if (end_lba == 0) continue;
            
            iam_files[file_count].size = (end_lba - lba) * 512;
            iam_files[file_count].flags = file_type;
            iam_files[file_count].fs_specific = (void*)lba;
            iam_files[file_count].parent_dir = 0;
            
            kernel_log("Found iam file at LBA ");
            kernel_log("\n");
            
            file_count++;
            lba = end_lba;
        }
    }
    
    return file_count;
}

// ==================== ОСНОВНЫЕ ФУНКЦИИ ФС ====================

static int iam_mount(unsigned int disk_id, struct directory** root) {
    kernel_log("Mounting iam_fs\n");
    
    int files_found = scan_disk_for_files(disk_id);
    if (files_found == 0) {
        return VFS_ERROR;
    }
    
    static struct directory iam_root;
    static struct file* file_pointers[32];
    
    for (int i = 0; i < file_count; i++) {
        file_pointers[i] = &iam_files[i];
    }
    
    iam_root.name = "/";
    iam_root.files = file_pointers;
    iam_root.file_count = file_count;
    iam_root.subdirs = 0;
    iam_root.subdir_count = 0;
    iam_root.parent_dir = &iam_root;
    iam_root.fs_specific = (void*)disk_id;
    
    *root = &iam_root;
    return VFS_SUCCESS;
}

static int iam_read_file(struct file* file, void* buffer, unsigned int size) {
    if (!file || !file->fs_specific) return VFS_ERROR;
    
    unsigned int start_lba = (unsigned int)file->fs_specific;
    unsigned int disk_id = (unsigned int)file->parent_dir->fs_specific;
    
    if (disk_read_sectors(disk_id, start_lba, (size + 511) / 512, buffer) != DISK_STATUS_OK) {
        return VFS_ERROR;
    }
    
    return VFS_SUCCESS;
}

static int iam_list_directory(struct directory* dir) {
    if (!dir) return VFS_ERROR;
    
    for (unsigned int i = 0; i < dir->file_count; i++) {
        kernel_log(dir->files[i]->name);
        kernel_log("\n");
    }
    
    return VFS_SUCCESS;
}

static int iam_find_file(struct directory* dir, const char* name, struct file** result) {
    if (!dir || !name) return VFS_ERROR;
    
    for (unsigned int i = 0; i < dir->file_count; i++) {
        if (strcmp(dir->files[i]->name, name) == 0) {
            *result = dir->files[i];
            return VFS_SUCCESS;
        }
    }
    
    return VFS_NOT_FOUND;
}

// ==================== РЕГИСТРАЦИЯ ФС ЧЕРЕЗ МАКРОС ====================

// ИНИЦИАЛИЗИРУЕМ ОПЕРАЦИИ ПЕРЕД МАКРОСОМ
static struct fs_operations iam_ops = {
    .mount = iam_mount,
    .read_file = iam_read_file,
    .list_directory = iam_list_directory,
    .find_file = iam_find_file
};

// МАКРОС РЕГИСТРАЦИИ - СОЗДАЕТ ПЕРЕМЕННЫЕ
REGISTER_FS(FS_TYPE_IAM, iam_ops);