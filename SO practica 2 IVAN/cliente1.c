#include <stdio.h>          
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <string.h>

#define Port 9999
#define MAXDATASIZE 100 

struct sockaddr_in cliente;
main(int argc, char *argv[]){
int td,td2,tam,numbytes;
char buffer[MAXDATASIZE];

if(argv[2]==NULL){
perror("argument 2  error\n");
exit(-1);
}

if((td=socket(AF_INET,SOCK_STREAM,0))==-1){
	perror("socket() error\n");
	exit(-1);
}


cliente.sin_family = AF_INET;
cliente.sin_port = htons(Port);
cliente.sin_addr.s_addr = inet_addr(argv[1]);

if((connect(td,(struct sockaddr*)& cliente,sizeof (struct sockaddr)))==-1){
	perror("connect() error\n");
	exit(-1);

}

write(td,argv[2],100);

while(read(td,buffer,sizeof(buffer))>0){

printf("%s",buffer);
}




}
