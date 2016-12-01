#include <unistd.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <iostream>
#include <vector>

using namespace std;

int main(int argc, char * argv[]){
  if (argc==3){
    vector<int> sons;
    vector<int> padres;
    for(int i = 0;i < atoi(argv[1]);i++){ //Crea los hijos verticales
	  if(fork()==0){ 
	    padres.push_back(getpid());
	    if(i==atoi(argv[1])-1){
	      for(int j = 0;j < atoi(argv[2]);j++){ // crea los hijos horizontales
		if(fork()==0){
		  sons.push_back(getpid());//No lo realiza correctamente, no entiendo el porqué
		  cout <<"Soy el subhijo "<<getpid()<<", mis padres son:";
		  for(int k=0;k<padres.size();k++){//imprime los padres
		    if(k<padres.size()-1){
		      cout << padres[k] << ", ";
		    }
		    else{
		      cout << padres[k] << "."<<endl;
		    }
		  }
		  exit(0);
		}
		else{
		  wait();
		}
		
	      }
	    }
	     //Se dicen quien es el superpadre y cuales son sus hijos
	    if(i==atoi(argv[1])-1){
	      cout <<"Soy el superpadre ("<<getpid()<<"):mis hijos finales son:";
	      for(int m=0;m<sons.size();m++){//imprime los hijos
		if(m<sons.size()-1){
		  cout << sons[m] << ", ";
		}
		else{
		  cout << sons[m] << "."<<endl;
		}
	      }
	    }
	  }
	  else{
	    wait();
	    exit(0);
	  }
    }
    sleep(5);
  }
  else{// Error de argumentos
    printf("Errror en los argumentos. Se deben pasar los argumentos siguiendo el siguiente esquema: \n./hijos <numHijosVerticales> <numHijosHorizontales>\n");
  }
  return (0);
}