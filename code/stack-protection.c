#include <stdio.h>
// this disables "warning: implicit declaration of function 'gets'"
#pragma GCC diagnostic ignored "-Wimplicit-function-declaration"

void user_read() {
        char buffer[28];
        gets(buffer);
}

int main(void) {
        user_read();
}

