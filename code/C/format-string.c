#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int main (int argc, char **argv) {
	char buf[10] = { '\0' };
	int x = 1; 
	snprintf(buf, sizeof(buf), argv[1]);
	buf[sizeof(buf)-1] = 0;
	printf("Buffer size is: (%d) \nData input: %s \n", strlen(buf), buf);
	printf("in hex: %#x\nMemory address for x: (%p) \n", x, &x);
	strdup(argv[1]);
	return 0;
}
