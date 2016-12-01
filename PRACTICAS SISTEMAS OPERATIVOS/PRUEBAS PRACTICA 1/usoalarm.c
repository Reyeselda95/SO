#include <signal.h>
int seguir = 1; /* Variable global */
void fin(int n) {
  seguir = 0;
}

main() {
  int contador = 0;
  signal(SIGALRM, fin);
  alarm(1);
  do {
    printf("Esta es la línea %d\n", contador++);
  } while (seguir);
  printf("TOTAL: %d líneas\n", contador);
}
