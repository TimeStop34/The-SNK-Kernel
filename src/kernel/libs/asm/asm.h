#ifndef INCL_LIB_ASM
#define INCL_LIB_ASM

#define cpu_pause() __asm__ __volatile__("pause" ::: "memory")

// Полезные ASM функции
extern void outb (unsigned short port, unsigned char byte);
extern void outw(unsigned short port, unsigned short value);
extern void outl(unsigned short port, unsigned int value);
extern unsigned char inb (unsigned short port);
extern unsigned short inw (unsigned short port);
extern unsigned int inl (unsigned short port);

extern void in_out_wait(void);

// Write in 8-bit registers
extern void in_ah(unsigned char byte);
extern void in_al(unsigned char byte);
extern void in_bh(unsigned char byte);
extern void in_bl(unsigned char byte);
extern void in_ch(unsigned char byte);
extern void in_cl(unsigned char byte);
extern void in_dh(unsigned char byte);
extern void in_dl(unsigned char byte);

// Write in 16-bit registers
extern void in_ax(short word);
extern void in_bx(short word);
extern void in_cx(short word);
extern void in_dx(short word);
extern void in_si(short word);

// Write in 32-bit registers
extern void in_ebx(int dword);
extern void in_edx(int dword);
extern void in_esi(int dword);

// Read from 8-bit registers
extern unsigned char get_ah();
extern unsigned char get_al();
extern unsigned char get_bh();
extern unsigned char get_bl();
extern unsigned char get_ch();
extern unsigned char get_cl();
extern unsigned char get_dh();
extern unsigned char get_dl();

// Read from 16-bit registers
extern unsigned short get_ax();
extern unsigned short get_bx();
extern unsigned short get_cx();
extern unsigned short get_dx();
extern unsigned short get_si();

// Read from 32-bit registers
extern int get_ebx();
extern int get_edx();
extern int get_esi();

// Clear 8-bit registers
extern void clear_ah();
extern void clear_al();
extern void clear_bh();
extern void clear_bl();
extern void clear_ch();
extern void clear_cl();
extern void clear_dh();
extern void clear_dl();

// Clear 16-bit registers
extern void clear_ax();
extern void clear_bx();
extern void clear_cx();
extern void clear_dx();

// Control Registers
extern unsigned long get_cr0(void);
extern unsigned long get_cr2(void);
extern unsigned long get_cr3(void);
extern unsigned long get_cr4(void);
extern void set_cr0(unsigned long value);
extern void set_cr2(unsigned long value);
extern void set_cr3(unsigned long value);
extern void set_cr4(unsigned long value);

// Segment Registers
extern unsigned short get_cs(void);
extern unsigned short get_ds(void);
extern unsigned short get_es(void);
extern unsigned short get_fs(void);
extern unsigned short get_gs(void);
extern unsigned short get_ss(void);
extern void set_cs(unsigned short value);
extern void set_ds(unsigned short value);
extern void set_es(unsigned short value);
extern void set_fs(unsigned short value);
extern void set_gs(unsigned short value);
extern void set_ss(unsigned short value);

// Default Segments
#define KERNEL_CS 0x08
#define KERNEL_DS 0x10
#define USER_CS   0x18 // Not implemented in GDT
#define USER_DS   0x20 // Not implemented in GDT

// Debug Registers
extern unsigned long get_dr0(void);
extern unsigned long get_dr1(void);
extern unsigned long get_dr2(void);
extern unsigned long get_dr3(void);
extern unsigned long get_dr6(void);
extern unsigned long get_dr7(void);
extern void set_dr0(unsigned long value);
extern void set_dr1(unsigned long value);
extern void set_dr2(unsigned long value);
extern void set_dr3(unsigned long value);
extern void set_dr6(unsigned long value);
extern void set_dr7(unsigned long value);

// Test Registers (для старых процессоров)
extern unsigned long get_tr6(void);
extern unsigned long get_tr7(void);
extern void set_tr6(unsigned long value);
extern void set_tr7(unsigned long value);

#endif
