#include <signal.h>

void alarma() {
  printf("acabo de recibir un SIGALRM\n");
}
main(){
  signal(SIGALRM,alarma);
  printf("acabo de programar la captura de un SIGALRM\n");
  alarm(3);
  printf("Ahora he programado la alarma en 3 seg.\n");
  pause();
  printf("vuelvo a programar la alarma\n");
  alarm(3);
  pause();
  printf("En POSIX esta línea nunca se ejecutaría porque me ha matado
  el SIGALRM\n");
}
