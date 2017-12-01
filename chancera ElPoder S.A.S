//INTEGRANTES
//JULIANA MEDINA MONTAÑO JUAN MANUEL CARDONA FABIAN ANDRES CUARTAS



#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

#define reservar_memoria (nodo*)malloc(sizeof(nodo))
//estructura de Nodo
struct nodo{
	int cedula;
	char nombre[30];
	char loterias[20];
	int numcliente;
	int numloteria;
	nodo *derecha;
	nodo *izquierda;
};

FILE * nomLoterias = NULL;
//Arboles

nodo *listaCedulas = NULL;
nodo *listaNombres = NULL;
nodo *listaLoterias= NULL;
nodo * listaNumLot = NULL;
nodo * numeroclientes = NULL;


//Creacion de Nodo
nodo * clientes(int ,char [30]);
nodo * crearLoteria(char [20]);
nodo * numeLoteria(int);
nodo * numcliente(int);
//Prototipo de Funciones
void menu();
void insertarNodo(nodo *&listaCedulas,nodo *&listaNombres,int cedula,char nombre[30]);
void mostrarCedulas(nodo *,int);
void mostrarClientes(nodo *,int);
void ins_lisLot(nodo*& );
void mos_lisLot(nodo * listaLoterias,int cont);	
void generar_loteria(nodo *&listaNumLot);
void mostrar_numlot(nodo*,int);
void numclientes(nodo *& numeroclientes, int numcliente);
void mostrarnumClientes(nodo *,int);
void validar_loteria(nodo *,nodo*,int);
void insertarArbolLot(nodo *& listaLoterias,char  [20]);
int main(){
	/*int conta=0;
	char loterias[20];
	FILE * insertar = NULL;
	
	fgets(nodito.loteria,20,stdin);
	
	insertar = fopen("listas.txt","a");
	if(insertar == NULL){
	printf("nose pudo leer");
	return 0;
}
	//for(int i=0;i<=13;i++){
	
	
	fwrite(&nodito,sizeof(nodito),1,insertar);
	printf("los datos se guardaron\n");
	
}
	
	insertar = fopen("listas.txt","r");
	if(insertar == NULL){
	printf("nose pudo leer");
	return 0;
}
	while(!feof(insertar)){
	fread(&nodito,sizeof(nodito),1,insertar);
	
	//	if(conta == 0){
	printf("loteria : %s",nodito.loteria);
	//}
	
}
	fclose(insertar);*/
	menu();
	return 0;
}
void menu(){
	int flag = 1,opcion,cedula,contador=0,bandera,numjugador;
	char loterias[20];
	char nombre[30];
	while(flag != 0){
		printf(" CHANCES EL PODER S.A.S \n");
		printf(" 1. Ingresar Clientes\n");
		printf(" 2. Jugar Loteria\n");
		printf(" 3. Mostrar Clientes\n");
		printf(" 4. Visualizar Loterias\n\n");
		
		printf(" 0. Salir\n\n");
		printf(" Seleccione una Opcion\n");
		scanf("%d",&opcion);
		switch(opcion){
		case 1:
			printf("Para dejar de ingresar Clientes a la lista Oprima -1 \n\n");
			bandera = -2;
			do{
				printf("Ingrese el Numero de Cedula: ");
				scanf("%d",&cedula);
				if( cedula != -1){
					fflush(stdin);
					printf("Ingrese el Nombre del Cliente:");
					fgets(nombre,30,stdin);
					insertarNodo(listaCedulas,listaNombres,cedula,nombre);
				}
			}while(cedula != -1);
			system("pause");
			system("cls");	
			break;
		case 2:
			printf("Para dejar de ingresar numeros Oprima -1 \n\n");
			printf("Ingrese el/los numero(s) con el/los cual(es) desea jugar:\n");
			do{
				scanf("%d",&numjugador);
				if( numjugador != -1){
					numclientes(numeroclientes,numjugador);
				}
			}while(numjugador != -1);
			
			printf("Resultado :");
			fgets(loterias,20,stdin);
			
			generar_loteria(listaNumLot);
			mostrar_numlot(listaNumLot,contador);
			validar_loteria(numeroclientes,listaNumLot,contador);
			system("pause");
			system("cls");
			break;
		case 3: 
			if(listaCedulas != NULL && listaNombres != NULL){ 
				mostrarCedulas(listaCedulas,contador);
				printf("\n");
				mostrarClientes(listaNombres,contador);
			}else{
				printf("No hay Clientes Ingresados Aun\n");
			}
			system("pause");
			system("cls");	
			break;

		case 4:
			ins_lisLot(listaLoterias);
			mos_lisLot(listaLoterias,contador);
			system("pause");
			system("cls");
			break;
		case 0:
			flag = 0;
			printf("adios\n");
			break;
		default:
			printf("Opcion Invalida\n");
			system("pause");
			system("cls");
			break;
		}
	}
}
nodo * clientes(int cedula,char nombre [30]){
	nodo * nuevo_nodo = reservar_memoria;
	nuevo_nodo->cedula = cedula;
	strcpy(nuevo_nodo->nombre,nombre);
	nuevo_nodo->derecha = NULL;
	nuevo_nodo->izquierda = NULL;
	
	return nuevo_nodo;
}
void insertarNodo(nodo *& listaCedulas,nodo *& listaNombres,int cedula,char nombre[30]){
	
	if (listaCedulas == NULL){
		nodo * nuevo_nodo = clientes(cedula,nombre);
		listaCedulas = nuevo_nodo;
		listaNombres = nuevo_nodo;
	}else{
		int valorRaiz = listaCedulas->cedula;
		if(cedula < valorRaiz){
			insertarNodo(listaCedulas->izquierda,listaNombres->izquierda,cedula,nombre);
		}else{
			insertarNodo(listaCedulas->derecha,listaNombres->derecha,cedula,nombre);
		}
	}
}
void mostrarCedulas(nodo *listaCedulas,int cont){
	if (listaCedulas == NULL){
		return;
	}else{
		mostrarCedulas(listaCedulas->derecha,cont+1);
		for(int i=0;i<cont;i++){
			printf("   ");
		}
		printf("%d\n",listaCedulas->cedula);
		mostrarCedulas(listaCedulas->izquierda,cont+1);
	}
}

void mostrarClientes(nodo *listaNombres,int cont){
	if (listaNombres == NULL){
		return;
	}else{
		mostrarClientes(listaNombres->derecha,cont+1);
		for(int i=0;i<cont;i++){
			printf("   ");
		}
		printf("%s\n",listaNombres->nombre);
		mostrarClientes(listaNombres->izquierda,cont+1);
	}
}
void insertarArbolLot(nodo *& listaLoterias,char lectura [20]){
	int j=strlen(lectura);
	int i;
	if (listaLoterias == NULL){
		nodo * nuevo_nodo = crearLoteria(lectura);
		listaLoterias = nuevo_nodo;
	}else{
		int a=strlen(listaLoterias->loterias);
		 i = a;
		if(j < i){
			insertarArbolLot(listaLoterias->izquierda,lectura);
		}else{
			insertarArbolLot(listaLoterias->derecha,lectura);
		}
	}
}

nodo * crearLoteria(char lectura [20]){
	
	nodo * nuevo_nodo = reservar_memoria;
	strcpy(nuevo_nodo->loterias,lectura);
	nuevo_nodo->derecha = NULL;
	nuevo_nodo->izquierda = NULL;
}


void ins_lisLot(nodo *& listaLoterias){
	char * Loterias = "lista.txt";
	char lectura[20];
	int dato[14];
	nomLoterias = fopen(Loterias,"r");
	if(nomLoterias == NULL){
		printf("No se pudo crear");
		exit;
	}
	printf("\n\nLoterias\n\n");
		for(int i = 1; i<15;i++){
		fscanf(nomLoterias," %[^\n]",&lectura);	
		insertarArbolLot(listaLoterias,lectura);
		}
		
	fclose(nomLoterias);
}
void mos_lisLot(nodo * listaLoterias,int cont){
	if (listaLoterias == NULL){
		return;
	}else{
		mos_lisLot(listaLoterias->derecha,cont+1);
		for(int i=0;i<cont;i++){
			printf("   ");
		}
		printf("%s\n",listaLoterias->loterias);
		mostrarCedulas(listaLoterias->izquierda,cont+1);
	}
}
nodo * numeLoteria(int numloteria){
	
	nodo * nuevo_nodo = reservar_memoria;
	nuevo_nodo->numloteria = numloteria;
	nuevo_nodo->derecha = NULL;
	nuevo_nodo->izquierda = NULL;
	return nuevo_nodo;
}
//generar numero para la loteria
void generar_loteria(nodo *&listaNumLot){
	srand(time(NULL));
	int num =1000+rand()%(9999-1000);
	if (listaNumLot == NULL){
		nodo * nuevo_nodo = numeLoteria(num);
		listaNumLot = nuevo_nodo;
	}else{
		int valorRaiz = listaNumLot->numloteria;
		if(num < valorRaiz){
			generar_loteria(listaNumLot->izquierda);
		}else{
			generar_loteria(listaNumLot->derecha);
		}
	}
}
void mostrar_numlot(nodo * listaNumLot,int cont){
	if (listaNumLot == NULL){
		return;
	}else{
		mostrar_numlot(listaNumLot->derecha,cont+1);
		for(int i=0;i<cont;i++){
			printf("   ");
		}
		printf("%d\n",listaNumLot->numloteria);
		mostrarCedulas(listaNumLot->izquierda,cont+1);
	}
}

nodo * numcliente(int numjugador){
	nodo * nuevo_nodo = reservar_memoria;
	nuevo_nodo->numcliente = numjugador;
	nuevo_nodo->derecha = NULL;
	nuevo_nodo->izquierda = NULL;
	
	return nuevo_nodo;
}


void numclientes(nodo *&numeroclientes, int numjugador){
	if (numeroclientes == NULL){
		nodo * nuevo_nodo = numcliente(numjugador);
		numeroclientes = nuevo_nodo;
	}else{
		int valorRaiz = numeroclientes->numcliente;
		if(numjugador < valorRaiz){
			numclientes(numeroclientes->izquierda,numjugador);
		}else{
			numclientes(numeroclientes->derecha,numjugador);
		}
	}
}
void mostrarnumClientes(nodo *numeroclientes,int cont){
	if (numeroclientes == NULL){
		return;
	}else{
		mostrarnumClientes(numeroclientes->derecha,cont+1);
		for(int i=0;i<cont;i++){
			printf("   ");
		}
		printf("%d\n",numeroclientes->numcliente);
		mostrarnumClientes(numeroclientes->izquierda,cont+1);
	}
}
void validar_loteria(nodo * numeroclientes,nodo *listaNumLot,int cont){
	if (numeroclientes == NULL){
		return;
	}else{
		
		if(numeroclientes->numcliente == listaNumLot->numloteria){
			printf(" ¡ EUREKA HAS GANADO EL PREMIO MAYOR CON %d\n !",listaNumLot->numloteria);
		}else{
			printf("Oopss BUENA SUERTE PARA LA PROXIMA :( \n");
		}
	}
}



