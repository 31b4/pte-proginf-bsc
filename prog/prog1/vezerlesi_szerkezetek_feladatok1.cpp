#include <stdio.h>
#include <iostream>

void elso();
void masodik();
void harmadik();
void negyedik();
void otodik();
void hatodik();
void hetedik();
void nyolcadik();
void kilencedik();
void tizedik();
void tizenegyedik();
void tizenkettedik();
void feladat1();
void feladat2();
void feladat3();

int main(){
	setlocale(LC_ALL, "");
	//elso();
	//masodik();
	//harmadik();
	//negyedik();
	//otodik();
	//hatodik();
	//hetedik();
	//nyolcadik();
	//kilencedik();
	//tizedik();
	//tizenegyedik();
	//tizenkettedik();
	//feladat1();
	//feladat2();
	//feladat3();
	
}
void elso(){
/*
Olvassuk be egy [a,b] intervallum als� �s fels� hat�r�t, valamint egy tetsz�leges �rt�ket.
Vizsg�ljuk meg �s �rjuk ki, hogy az �rt�k az intervallum alatt, benne vagy felette van-e.
*/
	float a, b, ertek;
	printf("K�rem az intervallum als� hat�r�t: "); scanf("%f", &a);
	printf("K�rem az intervallum fels� hat�r�t: "); scanf("%f", &b);
	if(a>b) printf("Hib�s adatok!");
	else{
		printf("K�rek egy tetsz�leges �rt�ket: "); scanf("%f", &ertek);
		if(ertek>=a && ertek<=b){
			printf("Az �rt�k a tartom�nyon bel�l van");
		}
		else	if(ertek<a) printf("Az �rt�k az intervallum alatt van");
				else printf("Az �rt�k az intervallum felett van");
	}
}

void masodik(){
/*
K�sz�tsen programot, amely bek�r k�t sz�mot, majd n�vekv� sorrendben ki�rja azokat.
*/
	float a, b;
	printf("K�rem az els� sz�mot: "); scanf("%f", &a);
	printf("K�rem a m�sodik sz�mot: "); scanf("%f", &b);
	if(a>b) printf("N�vekv� sorrendben: %.2f %.2f", b, a);
	else printf("N�vekv� sorrendben: %.2f  %.2f", a, b);
}

void harmadik(){
/*
K�rje be a programunk k�t z�rt intervallum als� �s fels� hat�rait (a v�gpontokat n�-
vekv� sorrendben adjuk meg). Vizsg�ljuk meg, �s �rjuk ki, hogy az intervallumoknak van-
e k�z�s r�sz�k.
*/
	float also1, felso1, also2, felso2;
	printf("K�rem az els� intervallum als� hat�r�t: "); scanf("%f", &also1);
	printf("K�rem az els� intervallum fels� hat�r�t: "); scanf("%f", &felso1);
	if(also1>felso1) printf("Hib�s adatok!");
	printf("K�rem az m�sodik intervallum als� hat�r�t: "); scanf("%f", &also2);
	printf("K�rem az m�sodik intervallum fels� hat�r�t: "); scanf("%f", &felso2);
	if(also2>felso2) printf("Hib�s adatok!");
	if((also2>=also1 &&also2<=felso1)||(felso2>=also1 &&felso2<=felso1)) printf("Van k�z�s r�sz�k");
	else printf("Nincs k�z�s r�sz�k");	
}

void negyedik(){
/*
K�sz�tsen programot, amely bek�r h�rom sz�mot. Megkeresi, majd ki�rja a legnagyobb
�rt�ket.
*/
	float a, b, c;
	printf("K�rem az els� sz�mot: "); scanf("%f", &a);
	printf("K�rem a m�sodik sz�mot: "); scanf("%f", &b);
	printf("K�rem a harmadik sz�mot: "); scanf("%f", &c);
	if(a>b && a>c) printf("A legnagyobb sz�m %f", a);
	else	if(b>a && b>c) printf("A legnagyobb sz�m %f", b);
			else printf("A legnagyobb sz�m %f", c);
	
	
}

void otodik(){
/*
�rjon programot, amely beolvas egy fizet�st, majd meg�llap�tja (ki�rja), hogy az alacsony,
k�zepes vagy magas. A fizet�s hat�rokat el�z�leg k�rje be a program.
*/
	int magas, kozepes, fizetes;
	printf("Ett�l az �sszegt�l magas a fizet�s: "); scanf("%d", &magas);
	printf("Ett�l az �sszegt�l k�zepes egy fizet�s: "); scanf("%d", &kozepes);
	
	if(kozepes>magas) printf("Impasszibl�");
	else{
		printf("K�rem a fizet�st: "); scanf("%d", &fizetes);
		if(fizetes<kozepes) printf("A %d -forintos fizet�s alacsony.", fizetes);
			else	if(fizetes<magas) printf("A %d -forintos fizet�s k�zepes.", fizetes);
					else printf("A %d -forintos fizet�s magas.", fizetes);
	}
}

void hatodik(){
/*
K�sz�tsen programot, amely bek�r h�rom sz�mot. Megkeresi, majd ki�rja a legkisebb �r-
t�ket.
*/
	float a, b, c;
	printf("K�rem az els� sz�mot: "); scanf("%f", &a);
	printf("K�rem a m�sodik sz�mot: "); scanf("%f", &b);
	printf("K�rem a harmadik sz�mot: "); scanf("%f", &c);
	if(a<b && a<c) printf("A legnagyobb sz�m %f", a);
	else	if(b<a && b<c) printf("A legnagyobb sz�m %f", b);
			else printf("A legnagyobb sz�m %f", c);
}

void hetedik(){
/*
K�sz�tsen programot, amely bek�r k�t sz�mot, majd cs�kken� sorrendben ki�rja azokat.
*/
	float a, b;
	printf("K�rem az els� sz�mot: "); scanf("%f", &a);
	printf("K�rem a m�sodik sz�mot: "); scanf("%f", &b);
	if(a>b) printf("N�vekv� sorrendben: %.2f %.2f", b, a);
	else printf("N�vekv� sorrendben: %.2f  %.2f", a, b);
}

void nyolcadik(){
/*
�rjon programot, amely �letkort olvas be (maximum 100 �ves korig), �s az al�bbi sz�ve-
get �rja ki: ha az �letkor 10, 20, 30, 40, 50, 60, 70, 80, 100: �Gratul�lunk�; 1-29: �Fiatal�;
30-59: K�z�pkor��; 60-100: �Id�s�. (Hib�s adatmegad�s eset�n adjon hibajelz�st!)
*/
	int kor;
	printf("K�rem a kort: "); scanf("%d", &kor);
	if(kor>100 || kor<=0) printf("Hib�s �letkor");
	else{
		if(kor%10==0 && kor!=90) printf("Gratul�lunk");
		if(kor>=1 && kor<=29) printf("Fiatal");
		if(kor>=35 && kor<=59) printf("K�z�pkor�");
		if(kor>=60) printf("Id�s");
	}	
}

void kilencedik(){
/*
�rjon programot, amely beolvassa egy h�nap sorsz�m�t, majd ki�rja a h�nap nev�t �s azt,
hogy melyik �vszakban van. (Hib�s adatmegad�s eset�n adjon hibajelz�st!)
*/
	int honap;
	printf("K�rem a h�nap sorsz�m�t: "); scanf("%d", &honap);
	switch(honap){
		case 1: case 2 : case 12: printf("t�l\n"); break;
		case 3: case 4: case 5: printf("tavasz\n"); break;
		case 6: case 7: case 8: printf("ny�r\n"); break;
		case 9: case 10: case 11: printf("�sz\n"); break;
		default: printf("Hibas h�nap\n"); break;
	}
	switch(honap){
		case 1: printf("janu�r\n"); break;
		case 2: printf("febru�r\n"); break;
		case 3: printf("m�rcius\n"); break;
		case 4: printf("�prilis\n"); break;
		case 5: printf("m�jus\n"); break;
		case 6: printf("j�nius\n"); break;
		case 7: printf("j�lius\n"); break;
		case 8: printf("augusztus\n"); break;
		case 9: printf("szeptember\n"); break;
		case 10: printf("okt�ber\n"); break;
		case 11: printf("november\n"); break;
		case 12: printf("december\n"); break;
		default: printf("\n"); break;
	}
}

void tizedik(){
/*
�rjon programot, amely beolvassa egy nap (h�ten bel�li) sorsz�m�t, majd ki�rja a nap ne-
v�t �s jelezze, ha h�tv�gi napot adtunk meg. (Hib�s adatmegad�s eset�n adjon hibajel-
z�st!)
*/
	int nap;
	printf("Adja meg a nap h�ten bel�li sorsz�m�t: "); scanf("%d", &nap);
	switch(nap){
		case 1: printf("h�tf�\n"); break;
		case 2: printf("kedd\n"); break;
		case 3: printf("szerda\n"); break;
		case 4: printf("cs�t�rt�k\n"); break;
		case 5: printf("p�ntek\n"); break;
		case 6: printf("H�tv�ge: szombat\n"); break;
		case 7: printf("H�tv�ge: vas�rnap\n"); break;
		default: printf("Hib�s sorsz�m\n"); break;
	}
}

void tizenegyedik(){
/*
K�rje be egy tanul� oszt�lyzat�t, majd �rja ki azt sz�vegesen (el�gtelen, el�gs�ges stb.).
(Hib�s adatmegad�s eset�n adjon hibajelz�st!)
*/
	int jegy;
	printf("Adja meg a tanul� oszt�lyzat�t: "); scanf("%d", &jegy);
	switch(jegy){
		case 1: printf("el�gtelen\n"); break;
		case 2: printf("el�gs�ges\n"); break;
		case 3: printf("k�zepes\n"); break;
		case 4: printf("j�\n"); break;
		case 5: printf("jeles\n"); break;
		default: printf("Hib�s jegy tesa\n"); break;
	}	
}

void tizenkettedik(){
/*
K�rjen be egy sz�mkaraktert, majd �rja ki azt sz�vegesen. (Hib�s adatmegad�s eset�n
adjon hibajelz�st!)
*/
	int szam;
	printf("K�rek egy sz�mkaraktert: "); scanf("%d", &szam);
	switch(szam){
		case 0: printf("nulla"); break;
		case 1: printf("egy"); break;
		case 2: printf("kett�"); break;
		case 3: printf("h�rom"); break;
		case 4: printf("n�gy"); break;
		case 5: printf("�t"); break;
		case 6: printf("hat"); break;
		case 7: printf("h�t"); break;
		case 8: printf("nyolc"); break;
		case 9: printf("kilenc"); break;
		default: printf("Hib�s karakter"); break;
	}
}

void feladat1(){
/*
K�sz�tsen programot, amely meghat�rozza a v�z halmaz�llapot�t �s ki�rja azt (�j�g�, �v�z�, �g�z�). 
A h�m�rs�klet �rt�keket (oC-ban) val�s (lebeg�pontos) sz�mk�nt k�rje be. 
�gyeljen arra, hogy az abszol�t 0 fokn�l (-273,16oC) hidegebb semmi sem lehet. 
(Hib�s adatmegad�s eset�n adjon hibajelz�st!)
*/
	float hom;
	printf("K�rek egy h�m�rs�kletet celsiusfokban: "); scanf("%f", &hom);
	if(hom< -273.16) printf("Hib�s adat, nem lehet abszolut 0 fokn�l hidegebb h�m�rs�kletet v�lasztani.");
	else{
		if(hom<0) printf("A halmaz�llapot j�g");
		else{
			if(hom<100) printf("A halmaz�llapot v�z");
			else printf("A halmaz�llapot g�z");
		}
	}
}

void feladat2(){
/*
�rjon programot, amely bek�r h�rom val�s (lebeg�pontos) sz�mot, 
majd ki�rja a megadott sz�mok k�z�l, hogy melyik a legnagyobb �s a legkisebb.
*/
	float a, b, c;
	printf("K�rem az els� sz�mot: "); scanf("%f", &a);
	printf("K�rem az m�sodik sz�mot: "); scanf("%f", &b);
	printf("K�rem az harmadik sz�mot: "); scanf("%f", &c);
	if(a>b && a>c) printf("A legnagyobb sz�m %.3f", a);
	else{
		if(b>a && b>c) printf("A legnagyobb sz�m %.3f", b);
		else printf("A legnagyobb sz�m %.3f", c);
	}
	if(a<b && a<c) printf("A legkisebb sz�m %.3f", a);
	else{
		if(b<a && b<c) printf("A legkisebb sz�m %.3f", b);
		else printf("A legkisebb sz�m %.3f", c);
	}
}

void feladat3(){
/*
�rjon programot, amely bek�r h�rom �rdemjegyet, majd kisz�m�tja az 
oszt�ly�tlagot eg�szre kerek�tve (1-t�l 5-ig eg�sz sz�m!),
ezut�n az eredm�nyt sz�vegesen ki�rja (5: �jeles�; 4: �j�; 3: �k�zepes�; 2: �el�gs�ges�, 1: �el�gtelen�). 
(Hib�s adatmegad�s eset�n adjon hibajelz�st!)
*/
	int a, b, c, atlag;
	printf("K�rem az els� oszt�lyzatot: "); scanf("%d", &a);
	printf("K�rem az m�sodik oszt�lyzatot: "); scanf("%d", &b);
	printf("K�rem az harmadik oszt�lyzatot: "); scanf("%d", &c);
	if(a<1 || a>5 || b<1 || b>5 || c<1 || c>5)	printf("Hib�s adat");
	else{
		atlag=(a+b+c)/3;
		printf("Az �tlag: %d, ", atlag);
		switch(atlag){
			case 1: printf("el�gtelen\n"); break;
			case 2: printf("el�gs�ges\n"); break;
			case 3: printf("k�zepes\n"); break;
			case 4: printf("j�\n"); break;
			case 5: printf("jeles\n"); break;
			default: printf("Hib�s adatmegad�s\n"); break;
			
		}
	}
}









