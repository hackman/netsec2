TARGETS = no-protection stack-protection fortify-1 fortify-2

all: $(TARGETS)

no-protection: 
	gcc -g -Wall -Wpragmas stack-protection.c -o no-protection

# -fstack-protector
# -fstack-protector-all
# -fstack-protector-strong
# -fstack-protector-explicit
stack-protection:
	gcc -g -Wall -Wpragmas -fstack-protector stack-protection.c -o stack-protection

fortify-1:
	gcc -g -Wall -Wpragmas -D_FORTIFY_SOURCE=1 -O1 stack-protection.c -o fortify-1

fortify-2:
	gcc -g -Wall -Wpragmas -D_FORTIFY_SOURCE=2 -O2 stack-protection.c -o fortify-2

clean:
	rm -f $(TARGETS)
