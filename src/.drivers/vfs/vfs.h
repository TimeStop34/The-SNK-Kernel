#pragma once

#include "../drivers.h"
#include "../disks/disk.h"

// Типы файловых систем
#define FS_TYPE_IAM 1
#define FS_TYPE_FAT16 2

// Результаты операций VFS
#define VFS_SUCCESS 0
#define VFS_ERROR -1
#define VFS_NOT_FOUND -2
#define VFS_INVALID_FS -3

// Структура файла
struct file {
    char* name;
    unsigned int size;
    unsigned int flags;
    void* fs_specific;
    struct directory* parent_dir;
};

// Структура директории
struct directory {
    char* name;
    struct file** files;
    unsigned int file_count;
    struct directory** subdirs;
    unsigned int subdir_count;
    struct directory* parent_dir;
    void* fs_specific;
};

// Операции файловой системы
struct fs_operations {
    int (*mount)(unsigned int disk_id, struct directory** root);
    int (*read_file)(struct file* file, void* buffer, unsigned int size);
    int (*list_directory)(struct directory* dir);
    int (*find_file)(struct directory* dir, const char* name, struct file** result);
};

// Макрос для регистрации ФС в VFS
#define REGISTER_FS(fs_type, ops) \
    static struct fs_operations* _##fs_type##_ops = &ops; \
    static unsigned int _##fs_type##_type = fs_type

// Структура точки монтирования (ДОБАВЛЯЕМ В .H!)
struct mount_point {
    unsigned int disk_id;
    unsigned int fs_type;
    struct fs_operations* ops;
    struct directory* root;
    int mounted;
};

// Функции VFS (ВСЕ ОБЪЯВЛЕНЫ В .H!)
void vfs_init(void);
void vfs_init_root(void);
int vfs_mount(unsigned int disk_id, unsigned int fs_type);
int vfs_open(const char* path, struct file** file);
int vfs_read(struct file* file, void* buffer, unsigned int size);
int vfs_list(const char* path);
static void vfs_auto_mount_disk(unsigned int dev_id);
struct directory* vfs_get_root(void);

// Внешние ссылки на зарегистрированные ФС
extern struct fs_operations* _FS_TYPE_IAM_ops;
// extern struct fs_operations* _FS_TYPE_FAT16_ops;