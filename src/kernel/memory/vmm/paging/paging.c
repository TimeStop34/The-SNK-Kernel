#include "paging.h"

void create_empty_page_directory(page_directory_entry_t* dir_ptr) {
    memset(dir_ptr, 0, 1024 * sizeof(page_directory_entry_t));
}