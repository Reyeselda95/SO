#include<stdio.h>
#include<sys/types.h>
#include<sys/socket.h>
#include<netinet/in.h>
#include<netdb.h>

int main(int argc, char *argv[])
{

    int fd, numbytes;

    struct sockaddr_in server;
    server.sin_family       =   AF_INET;
    server.sin_port         =   htons(atoi(argv[2]));
    server.sin_addr.s_addr  =   inet_addr(argv[1]);

    fd=socket(AF_INET, SOCK_STREAM, 0);

    if (fd<0)
    {
        printf("error en socketn" );
    }

    else
    {
        int tam = sizeof(struct sockaddr);
        connect(fd,(struct sockaddr*)&server, tam);

        char buffer[100];
        //string buffer;

        printf("Conectado\n");

        int conectado = 1;

        if (recv(fd, buffer, 100, 0) > 0)
        {
            printf("Mensaje recibido: %s\n", buffer);
        }

        do
        {
            printf("Comando: ");
            scanf("%s", buffer);

            write(fd,buffer,sizeof(buffer));

            if (strcmp(buffer, "adios")==0)
            {
                conectado = 0;
                exit(0);
            }

            if (recv(fd, buffer, 100, 0) > 0)
            {
                printf("Mensaje recibido: %s\n", buffer);
            }
        }while(conectado==1);
    }
}
