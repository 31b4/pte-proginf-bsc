#include <stdio.h>
#include <iostream>

#define PI 3.1415


void elsofeladat();
void masodikfeladat();
void harmadikfeladat();
void negyedikfeladat();
void otodik();
void hatodik();
void hetedik();
void nyolcadik();
void kilencedik();
void tizedik();
void tizenegyedik();

int main(){
	setlocale(LC_ALL, "");
	//elsofeladat();
	//masodikfeladat();
	//harmadikfeladat();
	//negyedikfeladat();
	//otodik();
	//hatodik();
	//hetedik();
	//nyolcadik();
	//kilencedik();
	//tizedik();
	tizenegyedik();
	
}

void elsofeladat(){
/*
A kerekasztal-t�rgyal�sok asztala �vegez�sre szorul. �rjon programot, amely kisz�m�tja
tetsz�leges �veggy�r� elk�sz�t�s�nek �r�t. A program k�rje be a bels� �s k�ls� sug�r
m�rt�k�t, valamint az �veg �r�t Ft/m2_ben. �rja ki, hogy mennyibe ker�l az �vegez�s.
*/
	float kulsosugar=0;
	float belsosugar=0;
	float uvegar=0;
	float fizetendo=0;
	printf("K�ls�sug�r: "); scanf("%f", &kulsosugar);
	printf("\nBels�sug�r: "); scanf("%f", &belsosugar);
	printf("\n�veg�r: "); scanf("%f", &uvegar);
	fizetendo= ((2*kulsosugar*PI)-(2*belsosugar*PI))*uvegar;
	printf("\nFizetend�: %f", fizetendo);
	
}

void masodikfeladat(){
/*
Egy tetsz�leges m�ret� has�b alak� tart�lyt t�lt�nk meg v�zzel. A tart�ly m�reteit �s a
m�sodperc/liter v�zhozamot a program k�rje be. Sz�m�tsa, majd �rja ki, hogy mennyi id�
alatt telik meg a tart�ly.
*/
	float magassag=0;
	float alapterulet=0;
	float vizhozam=0;
	float terfogat=0;
	float ido=0;
	printf("Magass�g decim�terben: "); scanf("%f", &magassag);
	printf("\nAlapter�let n�gyzetdecim�terben: "); scanf("%f", &alapterulet);
	printf("\nV�zhozam m�sodperc/literben: "); scanf("%f", &vizhozam);
	terfogat=magassag*alapterulet;
	ido=terfogat*vizhozam;
	printf("\nA has�b %f m�sodperc alatt t�lt�dik fel.", ido);
	
}

void harmadikfeladat(){
/*
K�sz�tsen programot, amely egy szab�lyos g�la t�meg�t sz�m�tja ki. A g�la alap�l�nek
m�ret�t, a magass�g�t, �s anyag�nak fajs�ly�t a program k�rje be, majd az eredm�nyt �rja
ki a k�perny�re.
*/
	float magassag=0;
	float alapel=0;
	float fajsuly=0;
	float terfogat=0;
	float tomeg=0;
	printf("Magass�g m�terben: "); scanf("%f", &magassag);
	printf("\nAlap�l m�terben: "); scanf("%f", &alapel);
	printf("\nFajs�ly kilogram/k�bm�terben : "); scanf("%f", &fajsuly);
	terfogat=alapel*alapel*magassag/3;
	tomeg=terfogat*fajsuly;
	printf("\nA g�la %f kilogram t�meg�", tomeg);
}

void negyedikfeladat(){
/*
K�sz�tsen programot, amely kisz�m�tja egy henger lefest�s�hez sz�ks�ges
fest�kmennyis�get. A henger sugar�t, a magass�g�t, �s a fest�k n�gyzetm�terenk�nt
sz�ks�ges mennyis�g�t a program k�rje be, majd az eredm�nyt �rja ki a k�perny�re.
*/
	float sugar, magassag, negyzetmkent, szukseges;
	printf("\nASug�r: "); scanf("%f", &sugar);
	printf("\nMagass�g: "); scanf("%f", &magassag);
	printf("\nEnnyi fest�k kell n�gyzetm�terenk�nt literben: "); scanf("%f", &negyzetmkent);
	szukseges=sugar*magassag*negyzetmkent;
	printf("A henger lefest�s�hez sz�ks�gesfest�kmennyis�g: %f liter", szukseges);
}

void otodik(){
/*
K�sz�tsen programot, amely kisz�m�tja, hogy mekkora a haszna egy keresked�nek, ha
adott a beszerz�si �r �s haszonkulcs sz�zal�kban. A program k�rje be a beszerz�si �r �s a
haszonkulcs �rt�k�t, majd az eredm�nyt �rja ki a k�perny�re.
*/
	float haszon=0;
	int besz_ar=0;
	int haszonkulcs=0;
	printf("\nBeszerz�si �r: "); scanf("%d", &besz_ar);
	printf("\nA haszonkulcs: "); scanf("%d", &haszonkulcs);
	haszon= (besz_ar/100)*(haszonkulcs);
	printf("\nA keresked� haszna: %f -ft.", haszon);
}

void hatodik(){
/*
K�sz�tsen programot, amely kisz�m�tja, hogy egy szab�szg�p h�ny ruh�t tud kiszabni egy
adott m�ret� anyagb�l. A program k�rje be az anyag m�ret�t (hossz�s�g, sz�less�g) �s az
egy ruh�hoz sz�ks�ges anyag ter�let�t, majd az eredm�nyt �rja ki a k�perny�re.
*/
	float hossz, szelesseg, szukseges;
	int kiszabhato;
	printf("\nAz anyag hossza m�terben: "); scanf("%f", &hossz);	
	printf("\nAz anyag sz�less�ge m�terben: "); scanf("%f", &szelesseg);
	printf("\nEgy ruh�hoz mennyi anyag sz�ks�ges n�gyzetm�terben: "); scanf("%f", &szukseges);
	kiszabhato=hossz*szelesseg/szukseges;
	printf("\nAz anyag %d ruh�hoz el�g.", kiszabhato);
}

void hetedik(){
/*
K�sz�tsen programot, amely bek�ri egy t�glalap �s egy n�gyzet m�reteit. Majd kisz�m�tja
�s ki�rja a k�perny�re, hogy a n�gyzet ter�lete h�nyszor kisebb a t�glalap�n�l, �s mennyi
a marad�k.
*/
	float teglalap, negyzet, hanyszorf, maradek;
	int hanyszori;
	printf("\nA t�glalap ter�lete n�gyzetm�terben: "); scanf("%f", &teglalap);	
	printf("\nA n�gyzet ter�lete n�gyzetm�terben: "); scanf("%f", &negyzet);
	hanyszorf=teglalap/negyzet;
	hanyszori=teglalap/negyzet;
	maradek=teglalap-(hanyszori*negyzet);
	printf("A n�gyzet %.2f -szor van meg a t�glalapban.\nA n�gyzet %d -szor van meg a t�glalapban marad�k n�lk�l �s a marad�k %.2f m�ter", hanyszorf, hanyszori, maradek);
}

void nyolcadik(){
/*
K�sz�tsen programot, amely egy t�glatest t�meg�t sz�m�tja ki. A t�glatest m�reteit �s
anyag�nak fajs�ly�t a program k�rje be, majd az eredm�nyt �rja ki a k�perny�re.
*/
	float a, b, c, fajsuly, tomeg;
	printf("\nA t�glatest a oldala m�terben: "); scanf("%f", &a);	
	printf("\nA t�glatest b oldala m�terben: "); scanf("%f", &b);
	printf("\nA t�glatest c oldala m�terben:  "); scanf("%f", &c);	
	printf("\nA fajs�ly kilogram/k�bm�terben: "); scanf("%f", &fajsuly);
	tomeg=a*b*c*fajsuly;
	printf("\nA t�glatest s�lya %.3f kilogram", tomeg);
}

void kilencedik(){
/*
K�sz�tsen programot, amely kisz�m�tja egy t�glatest t�rfogat�t �s felsz�n�t. A t�glatest
m�reteit a program k�rje be, majd az eredm�nyt �rja ki a k�perny�re.
*/
	float a, b, c, terf, felsz;
	printf("\nA t�glatest a oldala m�terben: "); scanf("%f", &a);	
	printf("\nA t�glatest b oldala m�terben: "); scanf("%f", &b);
	printf("\nA t�glatest c oldala m�terben:  "); scanf("%f", &c);
	terf=a*b*c;
	felsz= 2*(a*b+b*c+a*c);
	printf("\nA t�glatest t�rfogata %.3f k�bm�ter, a felsz�ne pedig %.3f n�gyzetm�ter.", terf, felsz);	
}

void tizedik(){
/*
K�sz�tsen programot, amely bek�ri egy k�r �s egy n�gyzet m�reteit. Majd kisz�m�tja �s
ki�rja a k�perny�re, hogy a k�r ker�lete h�nyszor kisebb a n�gyzet�n�l, �s mennyi a
marad�k.
*/
	float sugar, oldal, kort, negyzett, hanyszorf, maradek;
	int hanyszori;
	printf("\nA k�r sugara m�terben: "); scanf("%f", &sugar);	
	printf("\nA n�gyzet oldala m�terben: "); scanf("%f", &oldal);
	kort=2*PI*sugar;
	negyzett=oldal*oldal;
	hanyszorf=negyzett/kort;
	hanyszori=negyzett/kort;
	maradek=negyzett-(hanyszori*kort);
	printf("\nA k�r ker�lete %.3f kisebb a n�gyzet�n�l.\nA k�r %d -szer van meg marad�k n�lk�l a n�gyzetben, a marad�k pedig %.3f m�ter.", hanyszorf, hanyszori, maradek);	
	
}

void tizenegyedik(){
/*
K�sz�tsen programot, amely kisz�m�tja, hogy mennyit nyer egy v�s�rl� az �rlesz�ll�t�skor,
ha adott az eredeti �r �s az engedm�ny sz�zal�kban. A program k�rje be az eredeti �rat �s
az engedm�ny �rt�k�t, majd az eredm�nyt �rja ki a k�perny�re.
*/
	int eredeti, akcio, megtakaritas;
	printf("\nAz eredeti �r: "); scanf("%f", &eredeti);	
	printf("\nAz akci� sz�zal�kban: "); scanf("%f", &akcio);
	megtakaritas=eredeti/100*akcio;
	printf("A v�s�rl� megtakar�t�sa %d -ft", megtakaritas);
	
}









