use core::ptr;

// Структура для сохранения контекста выполнения
pub struct Context {
    // Поля для сохранения регистров и состояния процессора
    // В реальной реализации здесь будут храниться указатель на стек, 
    // регистры и другая контекстная информация
}

impl Context {
    // Сохранить текущий контекст как self
    pub unsafe fn save(&mut self) {
        // В реальной реализации здесь будет ассемблерный код для сохранения
        // регистров и состояния процессора в структуру Context
        // Например: сохранение SP, PC, регистров общего назначения и т.д.
    }
    
    // Восстановить контекст из self
    pub unsafe fn restore(&self) {
        // В реальной реализации здесь будет ассемблерный код для восстановления
        // регистров и состояния процессора из структуры Context
        // Например: восстановление SP, PC, регистров общего назначения и т.д.
    }
}

// Структура для представления задачи
pub struct Task {
    pub id: u32,
    pub state: TaskState,
    pub next: *mut Task,
    pub context: Context,  // Добавлен контекст задачи
}

#[derive(Clone, Copy, PartialEq)]
pub enum TaskState {
    Ready,
    Running,
    Blocked,
}

// Round-Robin планировщик
pub struct RRScheduler {
    current: *mut Task,
    ready_queue: *mut Task,
    task_count: u32,
}

impl RRScheduler {
    pub const fn new() -> Self {
        Self {
            current: ptr::null_mut(),
            ready_queue: ptr::null_mut(),
            task_count: 0,
        }
    }

    // Добавление задачи в планировщик
    pub unsafe fn add_task(&mut self, task: *mut Task) {
        if task.is_null() {
            return;
        }

        (*task).state = TaskState::Ready;
        (*task).next = ptr::null_mut();

        if self.ready_queue.is_null() {
            self.ready_queue = task;
            (*task).next = task; // Замыкаем кольцо
        } else {
            // Вставляем в конец очереди
            let mut last: *mut Task = self.ready_queue;
            while (*last).next != self.ready_queue {
                last = (*last).next;
            }
            (*last).next = task;
            (*task).next = self.ready_queue;
        }

        self.task_count += 1;
    }

    // Удаление задачи из планировщик
    pub unsafe fn remove_task(&mut self, task_id: u32) -> bool {
        if self.ready_queue.is_null() {
            return false;
        }

        let mut current: *mut Task = self.ready_queue;
        let mut prev: *mut Task = ptr::null_mut();

        loop {
            if (*current).id == task_id {
                // Нашли задачу для удаления
                if self.task_count == 1 {
                    // Последняя задача в очереди
                    self.ready_queue = ptr::null_mut();
                } else {
                    if prev.is_null() {
                        // Удаляем первую задачу, нужно найти последнюю
                        let mut last: *mut Task = self.ready_queue;
                        while (*last).next != self.ready_queue {
                            last = (*last).next;
                        }
                        self.ready_queue = (*self.ready_queue).next;
                        (*last).next = self.ready_queue;
                    } else {
                        (*prev).next = (*current).next;
                    }

                    if self.current == current {
                        self.current = ptr::null_mut();
                    }
                }

                self.task_count -= 1;
                return true;
            }

            prev = current;
            current = (*current).next;

            if current == self.ready_queue {
                break;
            }
        }

        false
    }

    // Выбор следующей задачи для выполнения
    pub unsafe fn schedule(&mut self) -> *mut Task {
        if self.ready_queue.is_null() {
            return ptr::null_mut();
        }

        // Если есть текущая задача, сохраняем её контекст и переводим в готовность
        if !self.current.is_null() {
            (*self.current).context.save();  // Сохраняем контекст текущей задачи
            (*self.current).state = TaskState::Ready;
        }

        // Выбираем следующую задачу
        if self.current.is_null() {
            self.current = self.ready_queue;
        } else {
            self.current = (*self.current).next;
        }

        (*self.current).state = TaskState::Running;
        (*self.current).context.restore();  // Восстанавливаем контекст новой задачи
        self.current
    }

    // Получение текущей активной задачи
    pub fn get_current_task(&self) -> *mut Task {
        self.current
    }

    // Получение количества задач
    pub fn get_task_count(&self) -> u32 {
        self.task_count
    }

    // Блокировка текущей задачи
    pub unsafe fn block_current_task(&mut self) -> bool {
        if self.current.is_null() {
            return false;
        }

        let task_id = (*self.current).id;
        (*self.current).state = TaskState::Blocked;
        
        // Удаляем заблокированную задачу из очереди готовых
        self.remove_task(task_id)
    }

    // Разблокировка задачи
    pub unsafe fn unblock_task(&mut self, task: *mut Task) {
        if !task.is_null() {
            self.add_task(task);
        }
    }

    // Получение ID текущей задачи
    pub unsafe fn get_current_task_id(&self) -> Option<u32> {
        if self.current.is_null() {
            None
        } else {
            Some((*self.current).id)
        }
    }

    // Проверка, пуста ли очередь
    pub fn is_empty(&self) -> bool {
        self.ready_queue.is_null()
    }
}