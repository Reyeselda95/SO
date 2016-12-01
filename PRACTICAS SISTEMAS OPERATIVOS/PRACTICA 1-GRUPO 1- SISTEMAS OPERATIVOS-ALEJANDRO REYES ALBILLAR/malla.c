#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char* argv[]) {
  int i, j, x, y;
  
  if(argc==3){
    x=atoi(argv[1]);
    y=atoi(argv[2]);
    printf("name= %s\n", argv[0]);
    printf("x= %d\n",x);
    printf("y= %d\n",y);
    
    for(j=0; j<y; j++){
    	//Aqui se crean los hijos del proceso padre
     if(fork()==0){
      printf("My pid: %d --- My ppid: %d\n", getpid(), getppid());
      for(i=0;i<x-1; i++){ //El primer hijo ya se creó así que será x-1
	if(fork()==0){
	  printf("My pid: %d --- My ppid: %d\n", getpid(), getppid());	
	}else{break;}
      }break; 
     }
    }sleep(15); 
  }
  
  else{
    printf("Se deben pasar 2 argumentos mediante la sintaxis malla numcolumnas(x) numfilas(y)");
  }
  
}
