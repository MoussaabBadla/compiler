#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct
{
   int state;
   char name[20];
   char code[20];
   char type[20];
   float val;
 } element;

typedef struct
{ 
   int state; 
   char name[20];
   char code[20];
   char type[20];
} elt;
	typedef struct
	{
		char signFromatage;
		char idf[20]; 
 
	} compatibilite;

element tab[1000];
elt tabs[40],tabm[40];


void initialisation()
{
  int i;
  for (i=0;i<1000;i++)
  tab[i].state=0;
  
  

  for (i=0;i<40;i++)
    {tabs[i].state=0;
    tabm[i].state=0;}

}



void inserer (char entite[], char code[],char type[],float val,int i, int y)
{
  switch (y)
 { 
   case 0:/*insertion dans la table des IDF et CONST*/
       tab[i].state=1;
       strcpy(tab[i].name,entite);
       strcpy(tab[i].code,code);
	   strcpy(tab[i].type,type);
	   tab[i].val=val;
	   break;

   case 1:/*insertion dans la table des mots clés*/
       tabm[i].state=1;
       strcpy(tabm[i].name,entite);
       strcpy(tabm[i].code,code);
	   strcpy(tabm[i].type,type);
       break; 
    
   case 2:/*insertion dans la table des séparateurs*/
      tabs[i].state=1;
      strcpy(tabs[i].name,entite);
      strcpy(tabs[i].code,code);
      break;
 }

}

void rechercher (char entite[], char code[],char type[],float val,int y)	
{

int j,i;

switch(y) 
  {
   case 0:/*verifier si la case dans la tables des IDF et CONST est libre*/
        for (i=0;((i<1000)&&(tab[i].state==1))&&(strcmp(entite,tab[i].name)!=0);i++); 
        if(tab[i].state==0)
        { 
	        
			inserer(entite,code,type,val,i,0); 
	      
         }
		 
        else if (strcmp(entite,tab[i].name)==0){
          printf("entite (%s) existe deja\n",entite);
		}
		else if (i>=1000)
		{ printf("La table des symboles des idfs est pleine");}
        break;

   case 1:/*verifier si la case dans la tables des mots clés est libre*/
       
       for (i=0;((i<40)&&(tabm[i].state==1))&&(strcmp(entite,tabm[i].name)!=0);i++); 
        if(tabm[i].state==0){
		inserer(entite,code,type,val,i,1);}
        else if (strcmp(entite,tabm[i].name)==0){
		printf("entite (%s) existe deja\n",entite);}
		else if (i>=40){
		printf ("La table des mots cles est pleine");}
        break; 
    
   case 2:/*verifier si la case dans la tables des séparateurs est libre*/
         for (i=0;((i<40)&&(tabs[i].state==1))&&(strcmp(entite,tabs[i].name)!=0);i++); 
        if(i<40)
         inserer(entite,code,type,val,i,2);
        else
   	       printf("entite (%s) existe deja\n",entite);
        break;

  }

}



void afficher() {
    int i;
    printf("/***************Table des symboles IDF*************/\n");
    printf("____________________________________________________________________\n");
    printf("\t| Nom_Entite |  Code_Entite | Type_Entite | Val_Entite\n");
    printf("____________________________________________________________________\n");
    
    for(i=0;i<50;i++) {	
        if(tab[i].state==1)
        { 
            printf("\t|%10s |%15s | %12s | %12f\n",tab[i].name,tab[i].code,tab[i].type,tab[i].val);    
        }
    }

 
    printf("\n/***************Table des symboles mots cles*************/\n");

    printf("___________________________________________________\n");
    printf("\t| Nom_Entite |  Code_Entite | Type_Entite |\n");
    printf("___________________________________________________\n");
    
    for(i=0;i<40;i++){
        if(tabm[i].state==1){ 
            printf("\t|%10s |%12s | |%12s | \n",tabm[i].name, tabm[i].code, tabm[i].type);       
        }
    }

    printf("\n/***************Table des symboles separateurs*************/\n");

    printf("_____________________________________\n");
    printf("\t| NomEntite |  CodeEntite | \n");
    printf("_____________________________________\n");
    
    for(i=0;i<40;i++){
        if(tabs[i].state==1) { 
            printf("\t|%10s |%12s | \n",tabs[i].name,tabs[i].code );   
        }
    } 
}


int rechercherIDF(char entite[]){
  int i=0;
  for (i; i<1000; i++){
    if (strcmp(entite,tab[i].name)==0){return i;}
  }
  return -1;
}



int rechercheNonDeclare(char entite[]) {
  int position;
  position=rechercherIDF(entite);
       if (position != -1 && strcmp(tab[position].type," ")==0){ return 0;} // la variable n'est pas declaree.
       else {return 1;} // la variable est declaree.
}





 
void insererType(char entite[], char type[])
	{
   int position;
   position =rechercherIDF(entite);
	 if(position !=-1)
	  {
	    strcpy(tab[position].type,type); 
	  }
  }




void CodeCst (char entite [])
{
	int position;
	position =rechercherIDF(entite);
	if (position != -1) 
	{
		strcpy(tab[position].code,"IDF CONSTANT");
	}
}



void SaveValue(char entite[], float val)
{
	int position;
	position =rechercherIDF(entite);
	if (position != -1) 
	{
		tab[position].val=val;
	}
}



int VerifIdfConst(char entite[])
{
	int position;
	position =rechercherIDF(entite);
	if (position != -1) 
	{
		if (strcmp(tab[position].code,"IDF CONSTANT")==0){return 1;}//l'idf est un IDF CONSTANT
		else {return 0;}// l'idf n'est pas un IDF CONSTANT
	}
}



int NbrSgnFormat (char chaine [])
{
	int i =0;
	int taille = strlen(chaine);
	int compteur=0;
	for (i=0; i<taille; i++)
	{
		if ((chaine[i]==';') || (chaine[i]=='%') || (chaine[i]=='&') || (chaine[i]=='?'))
		{
			compteur++;
		}
	}
	return compteur;
}



int CompType (char entite [], char type [])
{
	int position;
	position =rechercherIDF(entite);
	if (position != -1) 
	{
		if (strcmp(tab[position].type,type)==0){return 1;}//le type est compatible
		else {return 0;}//le type n'est pas compatible
	}
}


 void insererSignFormat (char chaine[],compatibilite tableau[]){
  int i = 0;
  int j= 0;
	int taille = strlen(chaine);
  	for (i=0; i<taille; i++)
	{
		switch (chaine[i])
    {
    case  ';'/* constant-expression */:
      tableau[j].signFromatage =';';/* code */
      j++;
      break;
    case  '?'/* constant-expression */:
      tableau[j].signFromatage ='?';/* code */
      j++;
      break;
    case  '&'/* constant-expression */:
      tableau[j].signFromatage ='&';/* code */
      j++;
      break;      
    case  '%'/* constant-expression */:
      tableau[j].signFromatage ='%';/* code */
      j++;
      break;    
    default:
      break;
    }
  }


 }

char* retournType(char entite[]){
  int position=0;
  position = rechercherIDF(entite);
  if (position!=-1){
    return tab[position].type;
  }
}

int verifierCompatibilite(compatibilite tableau[],int nbr){
  int i = 0;
  for (i; i<nbr; i++){
    switch (tableau[i].signFromatage)
    {
    case ';'/* constant-expression */:
      /* code */
      if (strcmp(retournType(tableau[i].idf),"INTEGER")!=0){return i+1;} // incompatibilie de type dans la case i / la variable numero i+1
      break;
    case '%'/* constant-expression */:
      /* code */
      if (strcmp(retournType(tableau[i].idf),"REAL")!=0){return i+1;}
      break;
    case '?'/* constant-expression */:
      /* code */
      if (strcmp(retournType(tableau[i].idf),"STRING")!=0){return i+1;}
      break;
    case '&'/* constant-expression */:
      /* code */
      if (strcmp(retournType(tableau[i].idf),"CHAR")!=0){return i+1;}
      break;    
    default:
      break;
    }
  }
  return 0 ; // tous les types sont  compatible

}
