.DEFAULT_GOAL := debug
gencass:
	gcc -Wall -Wextra -Wstrict-aliasing gencass.c -o gencass
debug: cass.c
	gcc -Wall -Wextra -Wstrict-aliasing -g gencass.c -o gencass
clean:
	rm -f gencass gencass.o
