#include "scheduler.h"

// Статические переменные планировщика
static task_t tasks[MAX_TASKS];
static unsigned int current_task = 0;
static unsigned int task_count = 0;
static unsigned int scheduler_ticks = 0;
static unsigned char scheduler_running = 0;

// Стеки для задач
static unsigned int idle_task_stack[128] __attribute__((aligned(8)));
static unsigned int task_stacks[MAX_TASKS][256] __attribute__((aligned(8)));

// Простая замена memset
static void memory_set(void* ptr, unsigned char value, unsigned int size) {
    unsigned char* p = (unsigned char*)ptr;
    for (unsigned int i = 0; i < size; i++) {
        p[i] = value;
    }
}

// Функция задачи по умолчанию
static void idle_task(void* arg) {
    while (1) {
        __asm volatile("wfi"); // Wait For Interrupt
    }
}

// Инициализация планировщика
void scheduler_init(void) {
    // Очистка всех структур задач
    memory_set(tasks, 0, sizeof(tasks));
    task_count = 0;
    current_task = 0;
    scheduler_ticks = 0;
    scheduler_running = 0;
    
    // Создаем задачу бездействия
    task_create(idle_task, 0, sizeof(idle_task_stack));
}

// Создание новой задачи
unsigned int task_create(void (*entry)(void*), void* arg, unsigned int stack_size) {
    if (task_count >= MAX_TASKS) {
        return 0; // Ошибка - нет свободных слотов
    }
    
    // Находим свободный слот
    unsigned int task_id;
    for (task_id = 0; task_id < MAX_TASKS; task_id++) {
        if (tasks[task_id].state == TASK_TERMINATED || tasks[task_id].entry_point == 0) {
            break;
        }
    }
    
    if (task_id == MAX_TASKS) {
        return 0; // Нет свободных слотов
    }
    
    task_t* task = &tasks[task_id];
    
    // Инициализация задачи
    task->task_id = task_id;
    task->state = TASK_READY;
    task->entry_point = entry;
    task->arg = arg;
    task->priority = 1;
    task->sleep_ticks = 0;
    
    // Выделение стека
    task->stack_base = task_stacks[task_id];
    task->stack_size = sizeof(task_stacks[0]);
    
    // Инициализация контекста задачи
    unsigned int* stack_top = task->stack_base + (task->stack_size / sizeof(unsigned int)) - 1;
    
    // Инициализация фрейма стека
    *(--stack_top) = 0x01000000; // xPSR
    *(--stack_top) = (unsigned int)entry; // PC (точка входа)
    *(--stack_top) = 0xFFFFFFFE; // LR
    
    // Сохраняем указатель стека
    task->context.sp = (unsigned int)stack_top;
    task->context.lr = 0xFFFFFFFE;
    task->context.control = 0;
    
    task_count++;
    return task_id;
}

// Запуск планировщика
void scheduler_start(void) {
    if (task_count == 0) {
        return;
    }
    
    scheduler_running = 1;
    
    // Находим первую готовую задачу
    for (unsigned int i = 0; i < MAX_TASKS; i++) {
        if (tasks[i].state == TASK_READY && tasks[i].entry_point != 0) {
            current_task = i;
            tasks[i].state = TASK_RUNNING;
            break;
        }
    }
    
    // Запускаем первую задачу
    scheduler_switch_to_task(current_task);
}

// Обработчик тика системного таймера
void scheduler_tick(void) {
    if (!scheduler_running) return;
    
    scheduler_ticks++;
    
    // Обновляем счетчики сна
    for (unsigned int i = 0; i < MAX_TASKS; i++) {
        if (tasks[i].state == TASK_SLEEPING && tasks[i].sleep_ticks > 0) {
            tasks[i].sleep_ticks--;
            if (tasks[i].sleep_ticks == 0) {
                tasks[i].state = TASK_READY;
            }
        }
    }
    
    // Round-robin планирование каждые TIME_QUANTUM тиков
    if (scheduler_ticks % TIME_QUANTUM == 0) {
        task_yield();
    }
}

// Добровольная передача управления
void task_yield(void) {
    if (!scheduler_running) return;
    
    // Ищем следующую готовую задачу
    for (unsigned int i = 1; i <= MAX_TASKS; i++) {
        unsigned int next_task = (current_task + i) % MAX_TASKS;
        
        if (tasks[next_task].state == TASK_READY && 
            tasks[next_task].entry_point != 0) {
            
            tasks[current_task].state = TASK_READY;
            current_task = next_task;
            tasks[current_task].state = TASK_RUNNING;
            
            scheduler_switch_task();
            break;
        }
    }
}

// Перевод задачи в режим сна
void task_sleep(unsigned int ticks) {
    if (!scheduler_running) return;
    
    tasks[current_task].state = TASK_SLEEPING;
    tasks[current_task].sleep_ticks = ticks;
    task_yield();
}

// Переключение на задачу
void scheduler_switch_to_task(unsigned int task_id) {
    task_t* task = &tasks[task_id];
    
    __asm volatile(
        "msr psp, %0\n"
        "mov r0, #2\n"
        "msr control, r0\n"
        "isb\n"
        "bx lr\n"
        : 
        : "r" (task->context.sp)
        : "r0"
    );
}

// Сохранение и восстановление контекста
__attribute__((naked)) void scheduler_switch_task(void) {
    __asm volatile(
        "mrs r0, psp\n"
        "stmdb r0!, {r4-r11, lr}\n"
        "ldr r1, =current_task\n"
        "ldr r1, [r1]\n"
        "ldr r2, =tasks\n"
        "mov r3, #104\n"
        "mul r1, r1, r3\n"
        "add r2, r2, r1\n"
        "str r0, [r2]\n"
        
        "ldr r1, =current_task\n"
        "ldr r1, [r1]\n"
        "ldr r2, =tasks\n"
        "mov r3, #104\n"
        "mul r1, r1, r3\n"
        "add r2, r2, r1\n"
        "ldr r0, [r2]\n"
        "ldmia r0!, {r4-r11, lr}\n"
        "msr psp, r0\n"
        "bx lr\n"
    );
}