#include "vfs.h"

// Корневая директория VFS
static struct directory* vfs_root = 0;

// Таблица точек монтирования
static struct mount_point mounts[16];
static unsigned int mount_count = 0;

// Инициализация VFS
void vfs_init(void) {
    // Инициализация таблицы монтирования
    for (int i = 0; i < 16; i++) {
        mounts[i].mounted = 0;
    }
    mount_count = 0;
    
    // Создание корневой директории
    vfs_init_root();
}

// Инициализация корневой директории
void vfs_init_root(void) {
    static struct file* root_files[1];
    static struct file test_file;
    static struct directory root_dir;
    
    // Создаем тестовый файл
    test_file.name = "test.file";
    test_file.size = 0;
    test_file.flags = 0;
    test_file.fs_specific = 0;
    test_file.parent_dir = &root_dir;
    
    root_files[0] = &test_file;
    
    // Создаем корневую директорию
    root_dir.name = "";
    root_dir.files = root_files;
    root_dir.file_count = 1;
    root_dir.subdirs = 0;
    root_dir.subdir_count = 0;
    root_dir.parent_dir = &root_dir;
    root_dir.fs_specific = 0;
    
    vfs_root = &root_dir;
}

// Монтирование файловой системы
int vfs_mount(unsigned int disk_id, unsigned int fs_type) {
    if (mount_count >= 16) return VFS_ERROR;
    
    struct fs_operations* ops = 0;
    switch (fs_type) {
        case FS_TYPE_IAM:
            ops = _FS_TYPE_IAM_ops;
            break;
        case FS_TYPE_FAT16:
            ops = _FS_TYPE_FAT16_ops;
            break;
        default:
            return VFS_INVALID_FS;
    }
    
    if (!ops || !ops->mount) return VFS_INVALID_FS;
    
    if (!disk_is_present(disk_id)) return VFS_ERROR;
    
    struct directory* root_dir = 0;
    int result = ops->mount(disk_id, &root_dir);
    if (result != VFS_SUCCESS) return result;
    
    mounts[mount_count].disk_id = disk_id;
    mounts[mount_count].fs_type = fs_type;
    mounts[mount_count].ops = ops;
    mounts[mount_count].root = root_dir;
    mounts[mount_count].mounted = 1;
    mount_count++;
    
    return VFS_SUCCESS;
}

// Открытие файла
int vfs_open(const char* path, struct file** file) {
    for (unsigned int i = 0; i < vfs_root->file_count; i++) {
        if (strcmp(vfs_root->files[i]->name, path) == 0) {
            *file = vfs_root->files[i];
            return VFS_SUCCESS;
        }
    }
    return VFS_NOT_FOUND;
}

// Чтение файла
int vfs_read(struct file* file, void* buffer, unsigned int size) {
    return VFS_SUCCESS;
}

// Листинг директории
int vfs_list(const char* path) {
    if (strcmp(path, "/") == 0 || strcmp(path, "") == 0) {
        for (unsigned int i = 0; i < vfs_root->file_count; i++) {
            kernel_log(vfs_root->files[i]->name);
            kernel_log("\n");
        }
        return VFS_SUCCESS;
    }
    return VFS_NOT_FOUND;
}

// Получение корневой директории
struct directory* vfs_get_root(void) {
    return vfs_root;
}

// МАКРОС ДРАЙВЕРА
DRIVER(vfs, vfs_init, NULL, FLAG_NONE);