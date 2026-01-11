function gyok = hurm(fuggveny, a, b, lepes, abraEngedekyezve)
% hurm - Húrmódszer (regula falsi) zérushely keresésre
%
% PROGRAM LEÍRÁS:
% Ez a függvény egy függvény zérushelyét keresi a húrmódszerrel (hamis helyzet
% szabálya). Az intervallum végpontjain át menő egyenessel közelíti a függvényt,
% és az egyenes zérushelyével szűkíti az intervallumot. Gyorsabb konvergenciájú
% mint az intervallumfelezés. Opcionális grafikus megjelenítés.
%
% Használat: gyok = hurm(fuggveny, a, b, lepes, abraEngedekyezve)
%
% Bemenő paraméterek:
%   fuggveny          - függvény handle, amelynek zérushelyét keressük
%   a, b              - kezdeti intervallum végpontjai (f(a)*f(b) < 0)
%   lepes             - iterációk száma
%   abraEngedekyezve  - ha 1, grafikus szemléltetés (opcionális)
%
% Visszatérési érték:
%   gyok - a zérushely közelítése
%
% A húrmódszer a függvény és az intervallum végpontjai közötti húrt használja
%
% Teszteléshez:
%   gyok = hurm(@(x) x.^2-2, 1, 2, 10, 1) % ábrával
%   fprintf('Gyök: %.10f, sqrt(2): %.10f\n', gyok, sqrt(2));
%   % Vagy ábra nélkül: hurm(@(x) x.^2-2, 1, 2, 15)
% Bolzano-tétel ellenőrzése: f(a) és f(b) különböző előjelei
if fuggveny(a) * fuggveny(b) > 0  % Ha mindkettő pozitív vagy negatív
    error('Az intervallum nem megfelelő. A függvényértékeknek különböző előjelekkel kell rendelkezniük az intervallum végpontjainál.');
end

% Húrmódszer (regula falsi) iterációs ciklusa
for II = 1:lepes  % II = 1-től lépés-ig
    % Húr és x-tengely metszéspontjának kiszámítása (lineáris interpoláció)
    c = (a * fuggveny(b) - b * fuggveny(a)) / (fuggveny(b) - fuggveny(a));  % Metszéspont: x = (a*f(b)-b*f(a))/(f(b)-f(a))

    % Ellenőrizzük, hogy találtunk-e pontos gyököt
    if fuggveny(c) == 0  % Ha f(c) = 0
        gyok = c;  % Gyök = c
        return;  % Azonnal visszatérés
    end

    % Új intervallum kiválasztása (Bolzano-tétel alapján)
    if fuggveny(c) * fuggveny(a) < 0  % Ha f(c) és f(a) különböző előjelűek
        b = c;  % A gyök az [a,c] intervallumban van
    else  % Egyébként
        a = c;  % A gyök a [c,b] intervallumban van
    end
end  % for ciklus vége

gyok = c;  % A közelített gyök (utolsó c érték)

% Grafikus megjelenítés, ha engedélyezve van
if abraEngedekyezve == 1  % Ha ábra kért
    figure;  % Új ábra létrehozása
    fplot(fuggveny, 'LineWidth', 2);  % Függvény kirajzolása
    hold on;  % További elemek hozzáadása az ábrához
    plot(gyok, fuggveny(gyok), 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r');  % Gyök megjelenítése piros körrel
    title('Húrmódszerrel keresett gyök');  % Ábra címe
    xlabel('x');  % X-tengely felirata
    ylabel('f(x)');  % Y-tengely felirata
    grid on;  % Rács bekapcsolása
    legend('Függvény', 'Közelített gyök');  % Jelmagyarázat
end  % if vége
end