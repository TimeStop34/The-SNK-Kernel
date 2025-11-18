#pragma once

#include "../../vfs.h"

// Сигнатуры iam_fs
#define IAM_FILE_SIGNATURE "__iamfile__"
#define IAM_END_SIGNATURE "__endoffile__"
#define IAM_SIGNATURE_SIZE 12

// Типы файлов
#define IAM_FILE_TYPE_BINARY 0
#define IAM_FILE_TYPE_TEXT 1
#define IAM_FILE_TYPE_EXECUTABLE 2

// Макрос для регистрации ФС - ТОЛЬКО ОБЪЯВЛЕНИЕ ПЕРЕМЕННЫХ!
#define REGISTER_FS(fs_type, ops) \
    struct fs_operations* _##fs_type##_ops = &ops; \
    unsigned int _##fs_type##_type = fs_type

// Регистрация iam_fs
void iam_fs_register(void);