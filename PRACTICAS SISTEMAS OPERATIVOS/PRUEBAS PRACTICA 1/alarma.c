#include <signal.h>
void alarma() {
printf("acabo de recibir un SIGALRM\n");
}

main() {
	signal(SIGALRM,alarma);
	printf("Acabo de programar la captura de un SIGALRM\n");
	alarm(5);
	printf("Ahora he programado la alarma en 5 seg.\n");
	pause();
	printf("Ahora continúo con la ejecución normal\n");
}

