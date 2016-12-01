#include <signal.h>
main() {
  printf("Voy a suicidarme\n");
  kill(getpid(), SIGKILL);
  perror("No he muerto???");
}
