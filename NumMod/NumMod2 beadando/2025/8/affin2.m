function transzMat = affin2(a,b,c,A,B,C)
% affin2 - Tetszőleges affin transzformáció mátrixának meghatározása
%
% PROGRAM LEÍRÁS:
% Ez a függvény kiszámítja azt a 3x3 homogén transzformációs mátrixot,
% amely egy háromszöget (a,b,c csúcspont) egy másik háromszögbe (A,B,C) visz.
% Homogén koordinátákat használ (3. koordináta = 1), így eltolást is kezel.
% Lehetőséget ad grafikus interaktív bemenetre és vizualizációra is.
%
% Használat:
%   T = affin2(a,b,c,A,B,C)
% ahol a,b,c az eredeti háromszög csúcsai (2 elemű vektorok),
% A,B,C pedig a hozzájuk tartozó képpontok az affin transzformációban.
% A függvény visszaadja a 3x3 homogén transzformációs mátrixot T-t, melyre
%   [Ax;Ay;1] = T * [ax;ay;1]
% teljesül minden megfelelő csúcspárra.
%
% Ha paraméter nélkül hívjuk, a függvény grafikus bemenet lehetőséget ad:
% kattints három pontra az eredeti háromszöghöz, majd három pontra
% a transzformált háromszöghöz.
%
% Teszteléshez:
%   a=[0,0]; b=[1,0]; c=[0,1];
%   A=[10,10]; B=[20,10]; C=[10,20];
%   T = affin2(a,b,c,A,B,C)
%   % Ellenőrzés: T*[a;1] = [A;1]
%   % Vagy grafikus mód: affin2() és kattints 6 pontra

% Paraméterek számának meghatározása és eselétválasztás
switch nargin  % Bemenő paraméterek száma
    case 6  % Hat paraméter: a,b,c és A,B,C háromszög csúcsi megadva
        % A két háromszög kirajzolása vizualizációhoz
        clf;  % Ábra törlése
        axis equal;  % Egyenlő arányok
        axis([0 100 0 100]);  % Ábra tartománya: [0,100] x [0,100]
        hold on;  % További rajzolás engedélyezése
        grid on;  % Rács

        % Eredeti háromszög (a,b,c) oldalainak rajzolása
        line([a(1) b(1)],[a(2) b(2)],'Marker','.','LineStyle','-');  % a-b él
        line([c(1) b(1)],[c(2) b(2)],'Marker','.','LineStyle','-');  % c-b él
        line([c(1) a(1)],[c(2) a(2)],'Marker','.','LineStyle','-');  % c-a él

        % Transzformált háromszög (A,B,C) oldalainak rajzolása
        line([A(1) B(1)],[A(2) B(2)],'Marker','.','LineStyle','-');  % A-B él
        line([C(1) B(1)],[C(2) B(2)],'Marker','.','LineStyle','-');  % C-B él
        line([C(1) A(1)],[C(2) A(2)],'Marker','.','LineStyle','-');  % C-A él

    case 0  % Paraméter nélküli hívás: grafikus bemenet mód
        clf;  % Ábra törlése
        axis equal;  % Egyenlő arányok
        axis([0 100 0 100]);  % Ábra tartománya
        hold on;  % További rajzolás engedélyezése
        grid on;  % Rács

        % Eredeti háromszög csúcsinak bekérése egérkattintással
        fprintf('Rajzold meg az eredeti háromszöget:\n');  % Utasítás
        a = ginput(1); plot(a(1),a(2),'o');  % 'a' csúcs bekérése és megjelenítése
        b = ginput(1); plot(b(1),b(2),'o');  % 'b' csúcs
        c = ginput(1); plot(c(1),c(2),'o');  % 'c' csúcs

        % Eredeti háromszög éleinek rajzolása
        line([a(1) b(1)],[a(2) b(2)],'Marker','.','LineStyle','-');  % a-b él
        line([c(1) b(1)],[c(2) b(2)],'Marker','.','LineStyle','-');  % c-b él
        line([c(1) a(1)],[c(2) a(2)],'Marker','.','LineStyle','-');  % c-a él

        % Transzformált háromszög csúcsinak bekérése
        fprintf('Rajzold meg a transzformált háromszöget:\n');  % Utasítás
        A = ginput(1); plot(A(1),A(2),'o');  % 'A' csúcs bekérése és megjelenítése
        B = ginput(1); plot(B(1),B(2),'o');  % 'B' csúcs
        C = ginput(1); plot(C(1),C(2),'o');  % 'C' csúcs

        % Transzformált háromszög éleinek rajzolása
        line([A(1) B(1)],[A(2) B(2)],'Marker','.','LineStyle','-');  % A-B él
        line([C(1) B(1)],[C(2) B(2)],'Marker','.','LineStyle','-');  % C-B él
        line([C(1) A(1)],[C(2) A(2)],'Marker','.','LineStyle','-');  % C-A él

    otherwise  % Hibás számú paraméter
        error('affin2: call with six arguments or none for graphical input');  % Hibajelzés
end

% Koordináták kiegészítése homogén koordinátákra (sorvektorokként)
a = [a 1];  % a = [ax, ay] -> [ax, ay, 1]
b = [b 1];  % b = [bx, by] -> [bx, by, 1]
c = [c 1];  % c = [cx, cy] -> [cx, cy, 1]

A = [A 1];  % A = [Ax, Ay] -> [Ax, Ay, 1]
B = [B 1];  % B = [Bx, By] -> [Bx, By, 1]
C = [C 1];  % C = [Cx, Cy] -> [Cx, Cy, 1]

% 3x3 mátrixok összeállítása: oszlopok = homogén pontok
P = [a' , b' , c'];   % Eredeti pontok mátrixa: P = [a, b, c] (3x3)
Q = [A' , B' , C'];   % Képpontok mátrixa: Q = [A, B, C] (3x3)

% Invertálhatóság ellenőrzése: az eredeti pontok nem lehetnek kollineárisak
if abs(det(P)) < eps  % Ha det(P) ≈ 0, a pontok egy egyenesen vannak
    error('affin2: az eredeti pontok kollineárisak vagy szinguláris mátrixot adnak');
end

% Affin transzformáció mátrixának kiszámítása
% Q = T * P  =>  T = Q * P^(-1)
transzMat = Q / P;  % Mátrix osztás: Q * inv(P)
end
