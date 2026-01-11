function gyok = intfel(fuggveny, a, b, epszilon)
% intfel - Intervallumfelezési módszer (bisection) zérushely keresésre
%
% PROGRAM LEÍRÁS:
% Ez a függvény egy folytonos függvény zérushelyét keresi az intervallumfelezési
% módszerrel. A Bolzano-tétel alapján ha f(a) és f(b) különböző előjelűek,
% akkor létezik zérushely az [a,b] intervallumban. Az intervallumot folyamatosan
% felezésével szűkíti a gyök helyét. Robust és megbízható módszer.
%
% Használat: gyok = intfel(fuggveny, a, b, epszilon)
%
% Bemenő paraméterek:
%   fuggveny  - függvény handle, amelynek zérushelyét keressük
%   a, b      - kezdeti intervallum végpontjai (f(a)*f(b) < 0 kell legyen)
%   epszilon  - ha egész: lépésszám; ha valós: pontossági korlát
%
% Visszatérési érték:
%   gyok - a zérushely közelítése
%
% Bolzano-tétel: ha f(a)*f(b) < 0, akkor létezik f(x*) = 0
%
% Teszteléshez:
%   f = @(x) x.^2 - 2; % sqrt(2) keresése
%   gyok = intfel(f, 1, 2, 1e-8)
%   fprintf('Gyök: %.10f, sqrt(2): %.10f\n', gyok, sqrt(2));
%   % Vagy: gyok = intfel(f, 1, 2, 20) % 20 lépés
% Bolzano-tétel ellenőrzése: f(a) és f(b) különböző előjelei
if fuggveny(a) * fuggveny(b) > 0  % Ha mindkettő pozitív vagy negatív
    error('Az intervallum nem megfelelő. A függvényértékeknek különböző előjelekkel kell rendelkezniük az intervallum végpontjainál.');
end
if (isinteger(epszilon))  % Az epszilon paraméter lépésszám (egész)
    lepes = epszilon;  % Fix iterációszám beállítása
    for II=1:lepes  % II = 1-től lépés-ig
        % Intervallum felezese: új középpont számítása
        c = (a + b) / 2;  % Középpont: (a+b)/2

        % Ellenőrizzük, hogy találtunk-e pontos megoldást
        if fuggveny(c) == 0  % Ha f(c) = 0, megtaláltuk a gyököt
            gyok = c;  % Gyök = c
            return;  % Azonnal visszatérés
        end

        % Az új intervallum kiválasztása (Bolzano-tétel alapján)
        if fuggveny(c) * fuggveny(a) < 0  % Ha f(c) és f(a) különböző előjelűek
            b = c;  % A gyök az [a,c] intervallumban van
        else  % Egyébként f(c) és f(b) különböző előjelűek
            a = c;  % A gyök a [c,b] intervallumban van
        end
    end  % for ciklus vége

else %Az epszilon az a tolerancia
    while (b - a) / 2 > epszilon
        % Intervallum felezése: új középpont
        c = (a + b) / 2;

        % Megoldást megtalálta
        if fuggveny(c) == 0
            gyok = c;
            return;
        end

        % Az új intervallum kiválasztása
        if fuggveny(c) * fuggveny(a) < 0
            b = c;
        else
            a = c;
        end
    end
end
%Az intervallum közepén lévő pontot adjuk vissza
gyok = (a + b) / 2;
end