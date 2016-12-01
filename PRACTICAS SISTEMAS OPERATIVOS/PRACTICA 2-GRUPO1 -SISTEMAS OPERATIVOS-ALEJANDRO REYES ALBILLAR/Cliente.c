//ALEJANDRO REYES ALBILLAR 45931406-S ara65@alu.ua.es
#include <stdio.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <netinet/in.h>

#define PUERTO 9999
#define MAX_BUFFER 10000

struct sockaddr_in cliente;
int main(int argc, char* argv[]){  
  char buffer[MAX_BUFFER];
  int fin, fd, fd2, tam; //File Descriptor
  
  if(argc<3 || argv[2]==NULL){
    perror("Error de argumentos en el cliente. Se ha de llamar de este modo: ./Cliente <ipServidor> <Comando>\n");
    exit(-1);
  }
  //AF_INET: Address Family Internet, SOCK_(STREAM|DEGRAM):En el protocolo de transporte utilizará TCP si ponemos stream,o UDP si utiliza degram, que significa datagrama
  cliente.sin_family=AF_INET;
  cliente.sin_port=htons(PUERTO);//Puertos por debajo de 1023 son puertos administrativos por lo que necesitarán permisos de superusuario. Empleamos htons: host to network short y se le pasa el puerto
  cliente.sin_addr.s_addr=inet_addr(argv[1]);
  if(fd=socket(AF_INET,SOCK_STREAM,0)==-1){
    perror("Error en el socket del cliente.\n");
    exit(-1);
  }
  else{
    printf("Socket abierto.\n");
    //Solicitud a accept
    if((connect(fd, (struct sockaddr*) &cliente, sizeof(struct sockaddr)))==-1){//Se le pasa el descriptor de socket, se hace un cast de servidor y se le pasa el tamaño del tipo
      perror("Error al conectar con el servidor.\n");
      exit(-1);
    }
    else{
      printf("Conexi�n establecida con servidor.\n");
      write(fd,argv[2],100);
      while(read(fd,buffer, sizeof(buffer))>0){
	printf("%s", buffer);
      }
    }
  }
}
