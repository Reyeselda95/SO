//ALEJANDRO REYES ALBILLAR 45931406-S ara65@alu.ua.es
#include <stdio.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <netinet/in.h>

#define PUERTO 9999

void main(int argc, char* argv[]){
  char buffer[256];
  int tam, fd, fd2;
  
  struct sockaddr_in servidor;
  struct sockaddr_in cliente;
    
  servidor.sin_family=AF_INET;
  servidor.sin_port=htons(PUERTO);
  servidor.sin_addr.s_addr=INADDR_ANY;  
  
  if(fd=socket(AF_INET,SOCK_STREAM,0)==-1){
    perror("Error en el socket.\n");
    exit(-1);
  }
  else{
  	printf("El socket funciona bien.\n");
  	
    if(bind(fd, (struct sockaddr*) &servidor, sizeof(struct sockaddr))==-1){
      perror("Error en el bind.\n");
      exit(-1);
    }
    else{
		printf("El bind funciona bien.\n");
	    if(listen(fd, 5)==-1){
			perror("Error en el listen.\n");
		}
	    else{
		    printf("El listen funciona bien.\n");
		    for(;;){
		    tam=sizeof(struct sockaddr_in);
		    
		    //Recibe de connect
		    if(fd2=accept(fd, (struct sockaddr*) &cliente, &tam)==-1){
		      perror("Fallo en el accept.\n");
		      exit(-1);
		    }
			else{
				printf("Cliente aceptado.\n");
				if(fork()==0){//Si es el hijo
			      close(fd);
			
			      while(read(fd2, buffer, sizeof(buffer))>0){
				close(1);
				dup(fd2);
				execlp(buffer, buffer, NULL);
				write(fd2, execlp(buffer, buffer, NULL),100);
			      }
			      close(fd2);
			      exit(0);
			    }
			    else{
			      close(fd2);
			    }
			}
		  } 
	  }	
	}
  }
}
