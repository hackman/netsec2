#include <stdio.h>
#include <alloca.h>
// this disables "warning: implicit declaration of function 'gets'"
#pragma GCC diagnostic ignored "-Wimplicit-function-declaration"

//void __attribute__ ((stack_protect)) fun() {
void fun() {
	char *buf = alloca(0x100);
	/* Don't allow gcc to optimise away the buf */
	asm volatile("" :: "m" (buf));
}

void user_read() {
        char buffer[28];
        gets(buffer);
}

int main(void) {
        user_read();
}

