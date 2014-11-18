#include "hheuristic.h"



//HISTORY EURISTIC

Hheur hheur;

void Hheur::clear()
{
	for(int i=0;i<64;i++)
		for(int j=0;j<64;j++)
			value[i][j] = 0;
}

Hheur::Hheur()
{
	clear();
}

uint32_t evalhheur (Move m) 
{ 
	return hheur.value[m.front()][m.back()]; 
}

bool sorthheur(Move i, Move j) 
{ 
	return (evalhheur(i)>evalhheur(j)); 
}
