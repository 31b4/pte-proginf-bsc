function transzMat = affin1(a1, a2)
% affin1 - Origót fixben hagyó affin transzformáció mátrixa (2x2)
%
% PROGRAM LEÍRÁS:
% Ez a függvény kiszámítja azt a 2x2 affin transzformációs mátrixot,
% amely az (1,0) és (0,1) bázisvektorokat adott képvektorokba viszi. Az origó
% fixpont marad. Lehetőséget ad grafikus interaktív bemenetre is,
% ahol a felhasználó az egérrel kattinthat a kívánt pontokra.
%
% Használat:
%   T = affin1(u,v)
% ahol `u` és `v` 2 elemű sor- vagy oszlopvektorok, melyek megadják
% az (1,0) és (0,1) bázis vektorok képeit. A visszaadott `T` mátrix
% teljesíti: T * [1;0] = u és T * [0;1] = v.
%
% Ha paraméter nélkül hívjuk, a függvény grafikus bemenet lehetőséget ad:
% kattints két pontra (először az (1,0) képe, majd a (0,1) képe).
%
% Teszteléshez:
%   T = affin1([1,2],[3,4])  % eredmény: [1 3; 2 4]
%   % Ellenőrzés: T * [1;0] = [1;2], T * [0;1] = [3;4]
%   % Vagy grafikus mód: affin1() és kattints két pontra

% Paraméterek számának meghatározása és aszerinti eselétválasztás
switch nargin  % Bemenő paraméterek száma
    case 2  % Két paraméter: u és v vektorok megadva
        % Bemenő paraméterek formátumának ellenőrzése
        if ~isvector(a1) || numel(a1)~=2 || ~isvector(a2) || numel(a2)~=2  % Ha nem 2 elemű vektorok
            error('A bemenő paramétereknek 2 elemű vektoroknak kell lenniük.');
        end
        % Transzformációs mátrix összeállítása: oszlopai az e1=(1,0) és e2=(0,1) képei
        transzMat = [a1(:), a2(:)];  % Mindkettő oszlopvektor lesz
    case 0  % Paraméter nélküli hívás: grafikus bemenet mód
        clf;  % Aktuális ábra törlése
        axis equal;  % Egyenlő tengely arányok
        axis([-10 10 -10 10]);  % Ábra tartománya: [-10,10] x [-10,10]
        hold on;  % További rajzolás engedélyezése
        grid on;  % Rács bekapcsolása
        title('Kattints az (1,0) képére, majd a (0,1) képére');  % Utasítás

        % Két pont bekérése az ábráról egérkattintással
        [x,y] = ginput(2);  % Első pont: (1,0) képe, második: (0,1) képe
        transzMat = [x(1) x(2); y(1) y(2)];  % Mátrix összeállítása: [u v]
    otherwise  % Hibás számú paraméter
        error('affin1: érvénytelen számú bemenő paraméter');  % Hibajelzés
end
