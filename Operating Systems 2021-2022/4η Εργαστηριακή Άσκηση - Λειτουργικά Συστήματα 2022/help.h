
/*help.h*/

#ifndef MAP_H
#define MAP_H

#include <stdlib.h>
#include <unistd.h>

#define die(msg) \
  do { perror(msg); exit(EXIT_FAILURE); } while(0)

  long get_page_size(void);

  void show_maps(void);

  void show_va_info(uint64_t va);

  uint64_t get_physical_address(unsigned long virt_addr);

  void press_enter(void);

  #endif /* MAP_H */
