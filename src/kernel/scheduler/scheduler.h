#ifndef SCHEDULER_H
#define SCHEDULER_H

// Максимальное количество задач
#define MAX_TASKS 8
// Квант времени для каждой задачи (в тиках таймера)
#define TIME_QUANTUM 10

// Состояния задач
typedef enum {
    TASK_READY,
    TASK_RUNNING,
    TASK_SLEEPING,
    TASK_TERMINATED
} task_state_t;

// Структура контекста задачи
typedef struct {
    unsigned int sp;        // Указатель стека
    unsigned int lr;        // Регистр связи
    unsigned int control;   // CONTROL регистр
} task_context_t;

// Структура задачи
typedef struct {
    task_context_t context;
    task_state_t state;
    unsigned int task_id;
    unsigned int priority;
    unsigned int sleep_ticks;
    void (*entry_point)(void*);
    void* arg;
    unsigned int* stack_base;
    unsigned int stack_size;
} task_t;

// Прототипы функций
void scheduler_init(void);
unsigned int task_create(void (*entry)(void*), void* arg, unsigned int stack_size);
void scheduler_start(void);
void scheduler_tick(void);
void task_yield(void);
void task_sleep(unsigned int ticks);
void scheduler_switch_task(void);

#endif