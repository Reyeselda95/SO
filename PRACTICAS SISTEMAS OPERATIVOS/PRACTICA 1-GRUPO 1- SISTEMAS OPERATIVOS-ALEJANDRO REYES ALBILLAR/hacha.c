#include <iostream>
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <fcntl.h>

using namespace std;

const char* toString(int i,char* argv){
  int use;
  int cont=0;
  string s="";
  string aux="";
  string aux2="";
  string ss=argv;
  ss+=".h";
  int k=i;
  int m=i;
  while(k>-1){
    use=k%10;
    if(i<10){
      s+='0';
      switch(i){
	case 0:
	  s+='0';
	  break;
	case 1:
	  s+='1';
	  break;
	case 2:
	  s+='2';
	  break;
	case 3:
	  s+='3';
	  break;
	case 4:
	  s+='4';
	  break;
	case 5:
	  s+='5';
	  break;
	case 6:
	  s+='6';
	  break;
	case 7:
	  s+='7';
	  break;
	case 8:
	  s+='8';
	  break;
	case 9:
	  s+='9';
	  break;
	default:
	  break;
      }
    }
    else{
      switch(use){
	case 0:
	  s+='0';
	  break;
	case 1:
	  s+='1';
	  break;
	case 2:
	  s+='2';
	  break;
	case 3:
	  s+='3';
	  break;
	case 4:
	  s+='4';
	  break;
	case 5:
	  s+='5';
	  break;
	case 6:
	  s+='6';
	  break;
	case 7:
	  s+='7';
	  break;
	case 8:
	  s+='8';
	  break;
	case 9:
	  s+='9';
	  break;
	default:
	  break;
      }
      cont++;
    }
    k=k/10;
    if(k==0){
      k=-1;
    }    
  }
  if(m>=10){
    for(int i=s.size()-1;i>=0;i--){
      aux+=s[i];
    }
    s=aux;
  }

  ss+=s;
  return ss.c_str();
}


int main(int argc, char * argv[]){
  int nuevo, tam, cont;
  char buffer[atoi(argv[2])+1];
  if(argc==3){
    int abierto=open(argv[1], O_RDONLY);
    if(abierto>=0){ //Si abre el archivo
      //aqui tenemos que poner un while para que lea varias veces el archivo hasta el final
      cont=0;
      while(tam>0){//necesito condicion para que finalice el bucle
	tam=read(abierto, buffer, atoi(argv[2]));//Devuelve el número de bytes leidos con éxito
	if(tam==-1){ //Error al leer el archivo
	  perror("Error de lectura\n");
	}
	else{
	  buffer[tam]=0;//Pone el final de la cadena
	  //hacemos algo con lo contenido en buffer
	  nuevo=creat(toString(cont, argv[1]),0777);
	  if(nuevo<0){ //Errror al crear
	    perror("Error al crear \n");
	  } 
	  else{
	    //Aqui  ponemos los datos dentro del archivo
	    if(write(nuevo, buffer, strlen(buffer)) != strlen(buffer)){
	      perror("Error al escribir");//Error al escribir
	      break;
	    }
	    close(nuevo);
	  }
	  cont++;
	}
      }
      close(abierto);
    }
    else{ //No se ha podido abrir el archivo
      perror("No se ha podido abrir el archivo");
      exit(0);
    }    
  }
  else{ //Error de argumentos
    printf("Error de argumentos, debes pasar los argumentos de este modo:\nhacha <nombrearchivo> <tamañoarchivodividido>\n");
    exit(0);
  }  
  exit(0);
}