#pragma once

#include "../libs/types.h"

/*
    Функции для работы с памятью
*/

/*  *
    * Копирует `n` байт из `src` в `dest`
    * Области не должны пересекаться!
    */
void memcpy(void *dest, const void *src, size_t n);

/*  *
    * Копирует(перемещает, но не очищает исходные) `n` байт из `src` в `dest`
    * Корректно работает с пересекающимеся областями
    */
void memmove(void *dest, const void *src, size_t n);


/*
    Заполняет первые `n` байт области памяти `ptr` указанным значением `value`
*/
void memset(void *ptr, int value, size_t n);

/*
    Сравнивает первые `n` байт двух областей памяти: `ptr1` и `ptr2`
    @return Результат сравнения, в типе `bool`
*/
bool memcmp(const void *ptr1, const void *ptr2, size_t n);