#include<stdio.h>
#include<sys/types.h>
#include<sys/socket.h>
#include<netinet/in.h>
#include <string.h>


int main(int argc, char * argv[])
{

    int fd, fd2;
    char buffer[100];
    struct sockaddr_in server;
    struct sockaddr_in client;
    int sin_size;

    if ((fd=socket(AF_INET, SOCK_STREAM, 0))==1)
    {
        printf ("Error en socket\n" );
    }

    server.sin_family = AF_INET;
    server.sin_port=htons(9999);
    server.sin_addr.s_addr=INADDR_ANY;

    system("clear");

	printf("     ___                                    \n");
	printf("    / ()\\                                   \n");
	printf("  _|_____|_                                 \n");
	printf(" | | === | |         SISTEMAS OPERATIVOS    \n");
	printf(" |_|  o  |_|                                \n");
	printf("  ||  o  ||              SERVIDOR V1.0      \n");
	printf("  ||__*__||                                 \n");
	printf(" |- \\___/ -|         JOSE VICENTE LOZANO    \n");
	printf(" /=\\ /=\\ /=\\                                \n");
	printf("_[_]_[_]_[_]________________________________\n");

    if (bind(fd,(struct sockaddr *) &server, sizeof(struct sockaddr))== -1)
    {
        printf("Error en bind\n" );
    }
    else
    {
        if (listen(fd, 2) == -1)
        {
            printf("Error en listen\n" );
        }
        else
        {
            while (1)
            {
                printf("Esperando Conexiones\n");

                sin_size = sizeof(struct sockaddr_in);

                if ((fd2=accept(fd,   (struct sockaddr *)    &client,         &sin_size)) == -1)
                {
                    printf ("Cliente rechazado\n" );
                }
                else
                {
                    if (fork()==0)
                    {
                        printf("Cliente conectado\n");
                        send(fd2, "Bienvenido a mi servidor!!!\n",100, 0);
                        close(1);
                        dup(fd2);

                        while(1)
                        {
                            if (recv(fd2, buffer, 100, 0) > 0)
                            {
                                if ( strcmp(buffer,"adios") == 0)
                                {
                                    printf("Adios!!\n");
                                    exit(0);
                                }
                                else
                                {
                                    system(buffer);
                                }
                            }
                        }
                    }
                }
            }
        }
    }
	return 0;
}
