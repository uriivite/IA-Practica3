#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <string.h>
#include <time.h>

void create(int n, char tipo[], char buff[]){
    char aux[20];
	for (int i = 0; i < n; i++){
    	sprintf(aux, "%s%d ",tipo,i);
    	strcat(buff, aux);
    }
    sprintf(aux, "- %s\n", tipo);
    strcat (buff, aux);
}

void iniRovers(int i, int nBases, char buff[]){
	char aux[60];
	int baseRandom = rand() % nBases;
	sprintf(aux, "(aparcat rover%d base%d)\n(rover_buit rover%d)\n",i,baseRandom,i);
	strcat (buff, aux);
}

void iniPersones(int i, int nAssentaments, char buff[]){
	char aux[60];
	int assentamentRandom = rand() % nAssentaments;
	sprintf(aux, "(l_persona persona%d assentament%d)\n", i, assentamentRandom);
	strcat (buff, aux);
}

void iniSuministres(int i, int nAssentaments, char buff[]){
	char aux[60];
	int assentamentRandom = rand() % nAssentaments;
	sprintf(aux, "(l_sum suministre%d assentament%d)\n", i, assentamentRandom);
	strcat (buff, aux);
}

void makePeticionsP(int i, int nAssentaments, char buff[]){
    char aux[60];
	int assentamentRandom = rand() % nAssentaments;
	sprintf(aux, "(peticio_p persona%d assentament%d)\n", i, assentamentRandom);
	strcat (buff, aux);	
}

void makePeticionsS(int i, int nAssentaments, char buff[]){
    char aux[60];
	int assentamentRandom = rand() % nAssentaments;
	sprintf(aux, "(peticio_s suministre%d assentament%d)\n", i, assentamentRandom);
	strcat (buff, aux);	
}

int main(int argc, char const *argv[]) {
    FILE  *fd = fopen("pfile.txt", "w");
    time_t t;
    char buff[2000];
    srand((unsigned) time(&t));
   
    int nRovers = rand() % 10 + 1;
    int nBases = rand() % 5 + 1;
    int nAssentaments = rand() % 20 + 1;
    int nPersones = rand() % 10 + 1;
    int nSuministres = rand() % 10 + 1;
    //int nCombustible = rand() % 20;
    
    //DEFINE PROBLEM
    
    sprintf(buff, "(define (problem roverprob1) (:domain Mart)\n(:objects\n");
	create (nRovers, "rover",buff);
	create (nBases, "base",buff);
	create (nAssentaments, "assentament", buff);
	create (nPersones, "persona", buff);
	create (nSuministres, "suministre", buff);
	
	//INIT
	
	strcat(buff, "\n)\n(:init\n");
	
	for (int i = 0; i < nRovers; i++) iniRovers(i,nBases,buff);
	for (int i = 0; i < nPersones; i++) iniPersones(i,nAssentaments, buff);
	for (int i = 0; i < nSuministres; i++) iniSuministres(i, nAssentaments, buff);
	for (int i = 0; i < nPersones; i++) makePeticionsP(i,nAssentaments,buff);
	for (int i = 0; i < nSuministres; i++) makePeticionsS(i, nAssentaments, buff);

	//GOAL
	
	strcat(buff, "\n)\n(:goal\n");
	
	//METRIC
	
    strcat(buff, "\n)\n(:metric minimize(coste-total))\n)\n");
    
    //WRITE FILE AND CLOSE
	fputs (buff, fd);
	fclose (fd);
}

