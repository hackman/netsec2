#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h> // for lseek
#include <stdlib.h> // for malloc
#include <string.h> // for memset
#include <stdio.h>  // for printf

#define LINE_SIZE 120
//#define DEBUG
#define FIX

void split_line(char *line) {
	char *key = NULL;
	char *value = NULL;
	value = strchr(line, '=');
	key = strndup(line, value - line);
#ifdef FIX
	if (value) {
#endif
		value++;
		printf("Key: %s Value: %s\n", key, value);
#ifdef FIX
	}
#endif
}

int load_config(const char *file, char *result) {
	unsigned int fd = -1;
	char *buf = NULL;
	char *buf2 = NULL;
	char *newline = NULL;
	int ret = -1;
	int line = 0;
	int pos = 0;
	int finished = 0;
	fd = open(file, O_RDONLY|O_CLOEXEC);
	if (fd == -1) {
		return 0;	
	} else {
		buf = malloc(LINE_SIZE);
		buf2 = malloc(LINE_SIZE);
		while (finished == 0) {
			memset(buf, '\0', LINE_SIZE);
			ret = read(fd, buf, LINE_SIZE);
			if (ret == 0 ) {
				close(fd);
				return 0;
			}
			if (ret == EOF) {
				break;
			}
			newline = strchr(buf, '\n');
			while (newline != NULL) {
				line = newline - buf;			// count the chars until "\n"
				memset(buf2, '\0', LINE_SIZE);	// clean buf2 from previous input
				strncat(buf2, buf, line);
#ifdef DEBUG
				fprintf(stderr, "%-100s\tline: %d read: %d len: %3d %p\n", buf2, line, ret, strlen(buf2), newline);
#endif
				split_line(buf2);
				pos += line+1;					// move the total file position forward
				buf += line+1;					// move the buf forward
				newline = strchr(buf, '\n');	// find the next "\n"
			}
#ifdef DEBUG
			printf("File pos: %d\n", pos);
#endif
			lseek(fd, pos, SEEK_SET);		// go to the new position, which is the last detected "\n"
			if (ret < LINE_SIZE || ret == EOF) {
				finished++;
				break;
			}
		}
		close(fd);
		return 1;
	}
	return 2;
}

int main(void) {
	char *secrets = NULL;

	load_config("secrets.conf", secrets);

	return 0;
}
