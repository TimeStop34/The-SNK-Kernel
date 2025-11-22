#include "string.h"

size_t strlen(const char* str) {
    size_t len = 0;
    while (str[len]) len++;
    return len;
}

char* strcat(char* dest, const char* src) {
    // Сохраняем начало dest для возврата
    char* ptr = dest;
    
    // Находим конец dest
    while (*ptr != '\0') {
        ptr++;
    }
    
    // Копируем src в конец dest
    while (*src != '\0') {
        *ptr = *src;
        ptr++;
        src++;
    }
    
    // Добавляем нуль-терминатор
    *ptr = '\0';
    
    return dest;
}

char* my_strcat(char* dest, const char* src, size_t n) {
    char* ptr = dest;
    
    // Находим конец dest
    while (*ptr != '\0') {
        ptr++;
    }
    
    // Копируем не более n символов из src
    size_t i = 0;
    while (i < n && *src != '\0') {
        *ptr = *src;
        ptr++;
        src++;
        i++;
    }
    
    // Добавляем нуль-терминатор
    *ptr = '\0';
    
    return dest;
}