#include <stdio.h>          
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <string.h>


 
#define Port 9999

main(int argc, char *argv[]){
int td,td2,tam;
char buffer[256];



if((td=socket(AF_INET,SOCK_STREAM,0))==-1){
	perror("socket() error\n");
    	exit (-1);

}

struct sockaddr_in servidor;
struct sockaddr_in cliente;


servidor.sin_family = AF_INET;
servidor.sin_port = htons(Port);
servidor.sin_addr.s_addr = INADDR_ANY; 


if(bind(td,(struct sockaddr*)& servidor,sizeof (struct sockaddr))==-1){
	perror("blind() error\n");
    	exit(-1);

}

listen(td,5);



for(;;){
tam =sizeof(struct sockaddr_in);
 

if((td2=accept(td,(struct sockaddr*)& cliente,&tam))==-1){
	perror("accept() error\n");
      	exit(-1);
}


      if(fork()==0){ //Codigo del hijo
      close (td);
      
	while(read(td2,buffer,sizeof(buffer))>0){
	close(1);
	dup(td2);
	execlp( buffer, buffer, NULL);
	write(td2,execlp( buffer, buffer, NULL),100);
	}
      close(td2);
      exit(0);
    }
    else{
      close(td2);
    }
      
   

}

}

