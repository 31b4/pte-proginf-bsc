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
A kerekasztal-tárgyalások asztala üvegezésre szorul. Írjon programot, amely kiszámítja
tetszõleges üveggyûrû elkészítésének árát. A program kérje be a belsõ és külsõ sugár
mértékét, valamint az üveg árát Ft/m2_ben. Írja ki, hogy mennyibe kerül az üvegezés.
*/
	float kulsosugar=0;
	float belsosugar=0;
	float uvegar=0;
	float fizetendo=0;
	printf("Külsõsugár: "); scanf("%f", &kulsosugar);
	printf("\nBelsõsugár: "); scanf("%f", &belsosugar);
	printf("\nÜvegár: "); scanf("%f", &uvegar);
	fizetendo= ((2*kulsosugar*PI)-(2*belsosugar*PI))*uvegar;
	printf("\nFizetendõ: %f", fizetendo);
	
}

void masodikfeladat(){
/*
Egy tetszõleges méretû hasáb alakú tartályt töltünk meg vízzel. A tartály méreteit és a
másodperc/liter vízhozamot a program kérje be. Számítsa, majd írja ki, hogy mennyi idõ
alatt telik meg a tartály.
*/
	float magassag=0;
	float alapterulet=0;
	float vizhozam=0;
	float terfogat=0;
	float ido=0;
	printf("Magasság deciméterben: "); scanf("%f", &magassag);
	printf("\nAlapterület négyzetdeciméterben: "); scanf("%f", &alapterulet);
	printf("\nVízhozam másodperc/literben: "); scanf("%f", &vizhozam);
	terfogat=magassag*alapterulet;
	ido=terfogat*vizhozam;
	printf("\nA hasáb %f másodperc alatt töltõdik fel.", ido);
	
}

void harmadikfeladat(){
/*
Készítsen programot, amely egy szabályos gúla tömegét számítja ki. A gúla alapélének
méretét, a magasságát, és anyagának fajsúlyát a program kérje be, majd az eredményt írja
ki a képernyõre.
*/
	float magassag=0;
	float alapel=0;
	float fajsuly=0;
	float terfogat=0;
	float tomeg=0;
	printf("Magasság méterben: "); scanf("%f", &magassag);
	printf("\nAlapél méterben: "); scanf("%f", &alapel);
	printf("\nFajsúly kilogram/köbméterben : "); scanf("%f", &fajsuly);
	terfogat=alapel*alapel*magassag/3;
	tomeg=terfogat*fajsuly;
	printf("\nA gúla %f kilogram tömegû", tomeg);
}

void negyedikfeladat(){
/*
Készítsen programot, amely kiszámítja egy henger lefestéséhez szükséges
festékmennyiséget. A henger sugarát, a magasságát, és a festék négyzetméterenként
szükséges mennyiségét a program kérje be, majd az eredményt írja ki a képernyõre.
*/
	float sugar, magassag, negyzetmkent, szukseges;
	printf("\nASugár: "); scanf("%f", &sugar);
	printf("\nMagasság: "); scanf("%f", &magassag);
	printf("\nEnnyi festék kell négyzetméterenként literben: "); scanf("%f", &negyzetmkent);
	szukseges=sugar*magassag*negyzetmkent;
	printf("A henger lefestéséhez szükségesfestékmennyiség: %f liter", szukseges);
}

void otodik(){
/*
Készítsen programot, amely kiszámítja, hogy mekkora a haszna egy kereskedõnek, ha
adott a beszerzési ár és haszonkulcs százalékban. A program kérje be a beszerzési ár és a
haszonkulcs értékét, majd az eredményt írja ki a képernyõre.
*/
	float haszon=0;
	int besz_ar=0;
	int haszonkulcs=0;
	printf("\nBeszerzési ár: "); scanf("%d", &besz_ar);
	printf("\nA haszonkulcs: "); scanf("%d", &haszonkulcs);
	haszon= (besz_ar/100)*(haszonkulcs);
	printf("\nA kereskedõ haszna: %f -ft.", haszon);
}

void hatodik(){
/*
Készítsen programot, amely kiszámítja, hogy egy szabászgép hány ruhát tud kiszabni egy
adott méretû anyagból. A program kérje be az anyag méretét (hosszúság, szélesség) és az
egy ruhához szükséges anyag területét, majd az eredményt írja ki a képernyõre.
*/
	float hossz, szelesseg, szukseges;
	int kiszabhato;
	printf("\nAz anyag hossza méterben: "); scanf("%f", &hossz);	
	printf("\nAz anyag szélessége méterben: "); scanf("%f", &szelesseg);
	printf("\nEgy ruhához mennyi anyag szükséges négyzetméterben: "); scanf("%f", &szukseges);
	kiszabhato=hossz*szelesseg/szukseges;
	printf("\nAz anyag %d ruhához elég.", kiszabhato);
}

void hetedik(){
/*
Készítsen programot, amely bekéri egy téglalap és egy négyzet méreteit. Majd kiszámítja
és kiírja a képernyõre, hogy a négyzet területe hányszor kisebb a téglalapénál, és mennyi
a maradék.
*/
	float teglalap, negyzet, hanyszorf, maradek;
	int hanyszori;
	printf("\nA téglalap területe négyzetméterben: "); scanf("%f", &teglalap);	
	printf("\nA négyzet területe négyzetméterben: "); scanf("%f", &negyzet);
	hanyszorf=teglalap/negyzet;
	hanyszori=teglalap/negyzet;
	maradek=teglalap-(hanyszori*negyzet);
	printf("A négyzet %.2f -szor van meg a téglalapban.\nA négyzet %d -szor van meg a téglalapban maradék nélkül és a maradék %.2f méter", hanyszorf, hanyszori, maradek);
}

void nyolcadik(){
/*
Készítsen programot, amely egy téglatest tömegét számítja ki. A téglatest méreteit és
anyagának fajsúlyát a program kérje be, majd az eredményt írja ki a képernyõre.
*/
	float a, b, c, fajsuly, tomeg;
	printf("\nA téglatest a oldala méterben: "); scanf("%f", &a);	
	printf("\nA téglatest b oldala méterben: "); scanf("%f", &b);
	printf("\nA téglatest c oldala méterben:  "); scanf("%f", &c);	
	printf("\nA fajsúly kilogram/köbméterben: "); scanf("%f", &fajsuly);
	tomeg=a*b*c*fajsuly;
	printf("\nA téglatest súlya %.3f kilogram", tomeg);
}

void kilencedik(){
/*
Készítsen programot, amely kiszámítja egy téglatest térfogatát és felszínét. A téglatest
méreteit a program kérje be, majd az eredményt írja ki a képernyõre.
*/
	float a, b, c, terf, felsz;
	printf("\nA téglatest a oldala méterben: "); scanf("%f", &a);	
	printf("\nA téglatest b oldala méterben: "); scanf("%f", &b);
	printf("\nA téglatest c oldala méterben:  "); scanf("%f", &c);
	terf=a*b*c;
	felsz= 2*(a*b+b*c+a*c);
	printf("\nA téglatest térfogata %.3f köbméter, a felszíne pedig %.3f négyzetméter.", terf, felsz);	
}

void tizedik(){
/*
Készítsen programot, amely bekéri egy kör és egy négyzet méreteit. Majd kiszámítja és
kiírja a képernyõre, hogy a kör kerülete hányszor kisebb a négyzeténél, és mennyi a
maradék.
*/
	float sugar, oldal, kort, negyzett, hanyszorf, maradek;
	int hanyszori;
	printf("\nA kör sugara méterben: "); scanf("%f", &sugar);	
	printf("\nA négyzet oldala méterben: "); scanf("%f", &oldal);
	kort=2*PI*sugar;
	negyzett=oldal*oldal;
	hanyszorf=negyzett/kort;
	hanyszori=negyzett/kort;
	maradek=negyzett-(hanyszori*kort);
	printf("\nA kör kerülete %.3f kisebb a négyzeténél.\nA kör %d -szer van meg maradék nélköl a négyzetben, a maradék pedig %.3f méter.", hanyszorf, hanyszori, maradek);	
	
}

void tizenegyedik(){
/*
Készítsen programot, amely kiszámítja, hogy mennyit nyer egy vásárló az árleszállításkor,
ha adott az eredeti ár és az engedmény százalékban. A program kérje be az eredeti árat és
az engedmény értékét, majd az eredményt írja ki a képernyõre.
*/
	int eredeti, akcio, megtakaritas;
	printf("\nAz eredeti ár: "); scanf("%f", &eredeti);	
	printf("\nAz akció százalékban: "); scanf("%f", &akcio);
	megtakaritas=eredeti/100*akcio;
	printf("A vásárló megtakarítása %d -ft", megtakaritas);
	
}









