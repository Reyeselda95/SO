#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <stdio.h>
#include <signal.h>

int main(int argc, char* argv[]){
  int i, j, seguir;
  int bispid, abupid;
  if(argc==2){
    for(i=0; i<=2;i++){
      if(fork()==0){
	if(i==0){
	  printf("Soy el proceso ejec: mi pid es %d\n", getpid());
	}
	else if(i==1){
	  printf("Soy el proceso A: mi pid es %d. Mi padre es %d\n", getpid(),getppid());
	  abupid=getppid();
	}
	else if(i==2){
	  printf("Soy el proceso B: mi pid es %d. Mi padre es %d. Mi abuelo es %d\n", getpid(),getppid(),abupid);
	  bispid=abupid;
	  abupid=getppid();
	  for(j=0; j<=2; j++){
	    if(fork()==0){
	      switch(j){
		case 0:
		  printf("Soy el proceso X: mi pid es %d. Mi padre es %d. Mi abuelo es %d. Mi bisabuelo es %d\n", getpid(),getppid(),abupid,bispid);
		  break;
		case 1:
		  printf("Soy el proceso Y: mi pid es %d. Mi padre es %d. Mi abuelo es %d. Mi bisabuelo es %d\n", getpid(),getppid(),abupid,bispid);
		  break;
		case 2:
		  printf("Soy el proceso Z: mi pid es %d. Mi padre es %d. Mi abuelo es %d. Mi bisabuelo es %d\n", getpid(),getppid(),abupid,bispid);
		  void pstree(){
		     execlp("pstree", "pstree", NULL);
		     perror("Error al ejecutar el comando pstree");
		     exit(0);
		  }
		  signal(SIGALRM,pstree);
		  alarm(atoi(argv[1]));	
		  pause();
		  break;
		default:
		  break;
	      }
	     exit(0);
	    }
	    
	    else{wait();}
	  }
	}else{exit(0);}
      }else{wait();exit(0);} 
     
    }
  }
  
  else{
    printf("Se debe pasar un entero como argumento\n");
  } 
}