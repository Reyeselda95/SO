#include <stdio.h>
#include <unistd.h>
int main (int argc, char *argv[]) {
	int i;
	printf ("Ejecutando el programa invocado (prog2). Sus argumentos son:\n");
	for ( i = 0; i < argc; i ++ )
	printf ("argv[%d] : %s \n", i, argv[i]);
	sleep(10);
	exit(0);
}

