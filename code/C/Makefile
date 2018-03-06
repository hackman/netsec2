TARGETS = no-protection stack-protection fortify-1 fortify-2 format-string
STACK_SOURCE = stack-protection.c
FORMAT_SOURCE = format-string.c

all: $(TARGETS)

no-protection: $(STACK_SOURCE)
	gcc -g -Wall -Wpragmas -fno-stack-protector $(STACK_SOURCE) -o no-protection

# -fstack-protector
#     Emit extra code to check for buffer overflows, such as stack smashing attacks.  This is done by adding a guard variable to functions with vulnerable objects.  This includes
#     functions that call "alloca", and functions with buffers larger than 8 bytes.  The guards are initialized when a function is entered and then checked when the function exits.  If a
#     guard check fails, an error message is printed and the program exits.
#
# -fstack-protector-all
#     Like -fstack-protector except that all functions are protected.
#
# -fstack-protector-strong
#     Like -fstack-protector but includes additional functions to be protected --- those that have local array definitions, or have references to local frame addresses.
#
# -fstack-protector-explicit
#     Like -fstack-protector but only protects those functions which have the "stack_protect" attribute

stack-protection: $(STACK_SOURCE)
	gcc -g -Wall -Wpragmas -fstack-protector $(STACK_SOURCE) -o stack-protection

fortify-1: $(STACK_SOURCE)
	gcc -g -Wall -Wpragmas -D_FORTIFY_SOURCE=1 -O1 $(STACK_SOURCE) -o fortify-1

fortify-2: $(STACK_SOURCE)
	gcc -g -Wall -Wpragmas -D_FORTIFY_SOURCE=2 -O2 $(STACK_SOURCE) -o fortify-2

format-string: $(FORMAT_SOURCE)
	gcc -g -Wall -Wpragmas -D_FORTIFY_SOURCE=2 -O2 $(FORMAT_SOURCE) -o format-string


clean:
	rm -f $(TARGETS)
