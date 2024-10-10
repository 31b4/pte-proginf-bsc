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
Olvassuk be egy [a,b] intervallum alsó és felsõ határát, valamint egy tetszõleges értéket.
Vizsgáljuk meg és írjuk ki, hogy az érték az intervallum alatt, benne vagy felette van-e.
*/
	float a, b, ertek;
	printf("Kérem az intervallum alsó határát: "); scanf("%f", &a);
	printf("Kérem az intervallum felsõ határát: "); scanf("%f", &b);
	if(a>b) printf("Hibás adatok!");
	else{
		printf("Kérek egy tetszõleges értéket: "); scanf("%f", &ertek);
		if(ertek>=a && ertek<=b){
			printf("Az érték a tartományon belül van");
		}
		else	if(ertek<a) printf("Az érték az intervallum alatt van");
				else printf("Az érték az intervallum felett van");
	}
}

void masodik(){
/*
Készítsen programot, amely bekér két számot, majd növekvõ sorrendben kiírja azokat.
*/
	float a, b;
	printf("Kérem az elsõ számot: "); scanf("%f", &a);
	printf("Kérem a második számot: "); scanf("%f", &b);
	if(a>b) printf("Növekvõ sorrendben: %.2f %.2f", b, a);
	else printf("Növekvõ sorrendben: %.2f  %.2f", a, b);
}

void harmadik(){
/*
Kérje be a programunk két zárt intervallum alsó és felsõ határait (a végpontokat nö-
vekvõ sorrendben adjuk meg). Vizsgáljuk meg, és írjuk ki, hogy az intervallumoknak van-
e közös részük.
*/
	float also1, felso1, also2, felso2;
	printf("Kérem az elsõ intervallum alsó határát: "); scanf("%f", &also1);
	printf("Kérem az elsõ intervallum felsõ határát: "); scanf("%f", &felso1);
	if(also1>felso1) printf("Hibás adatok!");
	printf("Kérem az második intervallum alsó határát: "); scanf("%f", &also2);
	printf("Kérem az második intervallum felsõ határát: "); scanf("%f", &felso2);
	if(also2>felso2) printf("Hibás adatok!");
	if((also2>=also1 &&also2<=felso1)||(felso2>=also1 &&felso2<=felso1)) printf("Van közös részük");
	else printf("Nincs közös részük");	
}

void negyedik(){
/*
Készítsen programot, amely bekér három számot. Megkeresi, majd kiírja a legnagyobb
értéket.
*/
	float a, b, c;
	printf("Kérem az elsõ számot: "); scanf("%f", &a);
	printf("Kérem a második számot: "); scanf("%f", &b);
	printf("Kérem a harmadik számot: "); scanf("%f", &c);
	if(a>b && a>c) printf("A legnagyobb szám %f", a);
	else	if(b>a && b>c) printf("A legnagyobb szám %f", b);
			else printf("A legnagyobb szám %f", c);
	
	
}

void otodik(){
/*
Írjon programot, amely beolvas egy fizetést, majd megállapítja (kiírja), hogy az alacsony,
közepes vagy magas. A fizetés határokat elõzõleg kérje be a program.
*/
	int magas, kozepes, fizetes;
	printf("Ettõl az összegtõl magas a fizetés: "); scanf("%d", &magas);
	printf("Ettõl az összegtõl közepes egy fizetés: "); scanf("%d", &kozepes);
	
	if(kozepes>magas) printf("Impassziblü");
	else{
		printf("Kérem a fizetést: "); scanf("%d", &fizetes);
		if(fizetes<kozepes) printf("A %d -forintos fizetés alacsony.", fizetes);
			else	if(fizetes<magas) printf("A %d -forintos fizetés közepes.", fizetes);
					else printf("A %d -forintos fizetés magas.", fizetes);
	}
}

void hatodik(){
/*
Készítsen programot, amely bekér három számot. Megkeresi, majd kiírja a legkisebb ér-
téket.
*/
	float a, b, c;
	printf("Kérem az elsõ számot: "); scanf("%f", &a);
	printf("Kérem a második számot: "); scanf("%f", &b);
	printf("Kérem a harmadik számot: "); scanf("%f", &c);
	if(a<b && a<c) printf("A legnagyobb szám %f", a);
	else	if(b<a && b<c) printf("A legnagyobb szám %f", b);
			else printf("A legnagyobb szám %f", c);
}

void hetedik(){
/*
Készítsen programot, amely bekér két számot, majd csökkenõ sorrendben kiírja azokat.
*/
	float a, b;
	printf("Kérem az elsõ számot: "); scanf("%f", &a);
	printf("Kérem a második számot: "); scanf("%f", &b);
	if(a>b) printf("Növekvõ sorrendben: %.2f %.2f", b, a);
	else printf("Növekvõ sorrendben: %.2f  %.2f", a, b);
}

void nyolcadik(){
/*
Írjon programot, amely életkort olvas be (maximum 100 éves korig), és az alábbi szöve-
get írja ki: ha az életkor 10, 20, 30, 40, 50, 60, 70, 80, 100: „Gratulálunk”; 1-29: „Fiatal”;
30-59: Középkorú”; 60-100: „Idõs”. (Hibás adatmegadás esetén adjon hibajelzést!)
*/
	int kor;
	printf("Kérem a kort: "); scanf("%d", &kor);
	if(kor>100 || kor<=0) printf("Hibás életkor");
	else{
		if(kor%10==0 && kor!=90) printf("Gratulálunk");
		if(kor>=1 && kor<=29) printf("Fiatal");
		if(kor>=35 && kor<=59) printf("Középkorú");
		if(kor>=60) printf("Idõs");
	}	
}

void kilencedik(){
/*
Írjon programot, amely beolvassa egy hónap sorszámát, majd kiírja a hónap nevét és azt,
hogy melyik évszakban van. (Hibás adatmegadás esetén adjon hibajelzést!)
*/
	int honap;
	printf("Kérem a hónap sorszámát: "); scanf("%d", &honap);
	switch(honap){
		case 1: case 2 : case 12: printf("tél\n"); break;
		case 3: case 4: case 5: printf("tavasz\n"); break;
		case 6: case 7: case 8: printf("nyár\n"); break;
		case 9: case 10: case 11: printf("õsz\n"); break;
		default: printf("Hibas hónap\n"); break;
	}
	switch(honap){
		case 1: printf("január\n"); break;
		case 2: printf("február\n"); break;
		case 3: printf("március\n"); break;
		case 4: printf("április\n"); break;
		case 5: printf("május\n"); break;
		case 6: printf("június\n"); break;
		case 7: printf("július\n"); break;
		case 8: printf("augusztus\n"); break;
		case 9: printf("szeptember\n"); break;
		case 10: printf("október\n"); break;
		case 11: printf("november\n"); break;
		case 12: printf("december\n"); break;
		default: printf("\n"); break;
	}
}

void tizedik(){
/*
Írjon programot, amely beolvassa egy nap (héten belüli) sorszámát, majd kiírja a nap ne-
vét és jelezze, ha hétvégi napot adtunk meg. (Hibás adatmegadás esetén adjon hibajel-
zést!)
*/
	int nap;
	printf("Adja meg a nap héten belüli sorszámát: "); scanf("%d", &nap);
	switch(nap){
		case 1: printf("hétfõ\n"); break;
		case 2: printf("kedd\n"); break;
		case 3: printf("szerda\n"); break;
		case 4: printf("csütörtök\n"); break;
		case 5: printf("péntek\n"); break;
		case 6: printf("Hétvége: szombat\n"); break;
		case 7: printf("Hétvége: vasárnap\n"); break;
		default: printf("Hibás sorszám\n"); break;
	}
}

void tizenegyedik(){
/*
Kérje be egy tanuló osztályzatát, majd írja ki azt szövegesen (elégtelen, elégséges stb.).
(Hibás adatmegadás esetén adjon hibajelzést!)
*/
	int jegy;
	printf("Adja meg a tanuló osztályzatát: "); scanf("%d", &jegy);
	switch(jegy){
		case 1: printf("elégtelen\n"); break;
		case 2: printf("elégséges\n"); break;
		case 3: printf("közepes\n"); break;
		case 4: printf("jó\n"); break;
		case 5: printf("jeles\n"); break;
		default: printf("Hibás jegy tesa\n"); break;
	}	
}

void tizenkettedik(){
/*
Kérjen be egy számkaraktert, majd írja ki azt szövegesen. (Hibás adatmegadás esetén
adjon hibajelzést!)
*/
	int szam;
	printf("Kérek egy számkaraktert: "); scanf("%d", &szam);
	switch(szam){
		case 0: printf("nulla"); break;
		case 1: printf("egy"); break;
		case 2: printf("kettõ"); break;
		case 3: printf("három"); break;
		case 4: printf("négy"); break;
		case 5: printf("öt"); break;
		case 6: printf("hat"); break;
		case 7: printf("hét"); break;
		case 8: printf("nyolc"); break;
		case 9: printf("kilenc"); break;
		default: printf("Hibás karakter"); break;
	}
}

void feladat1(){
/*
Készítsen programot, amely meghatározza a víz halmazállapotát és kiírja azt („jég”, „víz”, „gõz”). 
A hõmérséklet értékeket (oC-ban) valós (lebegõpontos) számként kérje be. 
Ügyeljen arra, hogy az abszolút 0 foknál (-273,16oC) hidegebb semmi sem lehet. 
(Hibás adatmegadás esetén adjon hibajelzést!)
*/
	float hom;
	printf("Kérek egy hõmérsékletet celsiusfokban: "); scanf("%f", &hom);
	if(hom< -273.16) printf("Hibás adat, nem lehet abszolut 0 foknál hidegebb hõmérsékletet választani.");
	else{
		if(hom<0) printf("A halmazállapot jég");
		else{
			if(hom<100) printf("A halmazállapot víz");
			else printf("A halmazállapot gõz");
		}
	}
}

void feladat2(){
/*
Írjon programot, amely bekér három valós (lebegõpontos) számot, 
majd kiírja a megadott számok közül, hogy melyik a legnagyobb és a legkisebb.
*/
	float a, b, c;
	printf("Kérem az elsõ számot: "); scanf("%f", &a);
	printf("Kérem az második számot: "); scanf("%f", &b);
	printf("Kérem az harmadik számot: "); scanf("%f", &c);
	if(a>b && a>c) printf("A legnagyobb szám %.3f", a);
	else{
		if(b>a && b>c) printf("A legnagyobb szám %.3f", b);
		else printf("A legnagyobb szám %.3f", c);
	}
	if(a<b && a<c) printf("A legkisebb szám %.3f", a);
	else{
		if(b<a && b<c) printf("A legkisebb szám %.3f", b);
		else printf("A legkisebb szám %.3f", c);
	}
}

void feladat3(){
/*
Írjon programot, amely bekér három érdemjegyet, majd kiszámítja az 
osztályátlagot egészre kerekítve (1-tõl 5-ig egész szám!),
ezután az eredményt szövegesen kiírja (5: „jeles”; 4: „jó”; 3: „közepes”; 2: „elégséges”, 1: „elégtelen”). 
(Hibás adatmegadás esetén adjon hibajelzést!)
*/
	int a, b, c, atlag;
	printf("Kérem az elsõ osztályzatot: "); scanf("%d", &a);
	printf("Kérem az második osztályzatot: "); scanf("%d", &b);
	printf("Kérem az harmadik osztályzatot: "); scanf("%d", &c);
	if(a<1 || a>5 || b<1 || b>5 || c<1 || c>5)	printf("Hibás adat");
	else{
		atlag=(a+b+c)/3;
		printf("Az átlag: %d, ", atlag);
		switch(atlag){
			case 1: printf("elégtelen\n"); break;
			case 2: printf("elégséges\n"); break;
			case 3: printf("közepes\n"); break;
			case 4: printf("jó\n"); break;
			case 5: printf("jeles\n"); break;
			default: printf("Hibás adatmegadás\n"); break;
			
		}
	}
}









