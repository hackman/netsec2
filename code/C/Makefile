TARGETS = no-protection stack-protection fortify-1 fortify-2

all: $(TARGETS)

no-protection: 
	gcc -g -Wall -Wpragmas -fno-stack-protector stack-protection.c -o no-protection

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

stack-protection:
	gcc -g -Wall -Wpragmas -fstack-protector stack-protection.c -o stack-protection

fortify-1:
	gcc -g -Wall -Wpragmas -D_FORTIFY_SOURCE=1 -O1 stack-protection.c -o fortify-1

fortify-2:
	gcc -g -Wall -Wpragmas -D_FORTIFY_SOURCE=2 -O2 stack-protection.c -o fortify-2

clean:
	rm -f $(TARGETS)
