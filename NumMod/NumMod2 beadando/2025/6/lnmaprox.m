function approxPolinom = lnmaprox(polinomFokszam, csomopontokX, csomopontokY, grafikon)
% lnmaprox - Legkisebb négyzetek módszerével polinom approximáció
%
% PROGRAM LEÍRÁS:
% Ez a függvény polinom approximációt végez adott pontokra a legkisebb négyzetek
% módszerével. Olyan polinomot keres, amely minimális négyzetes eltéréssel
% illeszkedik az adatpontokra. A Gauss-féle normálegyenletek megoldásával történik.
% Opcionálisan grafikusan is megjeleníti az eredményt.
%
% Használat: approxPolinom = lnmaprox(polinomFokszam, csomopontokX, csomopontokY, grafikon)
%
% Bemenő paraméterek:
%   polinomFokszam - az approximációs polinom fokszáma
%   csomopontokX   - csomponentok x koordinátái
%   csomopontokY   - csomponentok y koordinátái (függvényértékek)
%   grafikon       - ha 1, grafikus szemléltetés
%
% Visszatérési érték:
%   approxPolinom - a legkisebb négyzetek approximációs polinom értékei
%
% A módszer a Gauss-féle normálegyenletek megoldásával történik
%
% Teszteléshez:
%   approxPolinom = lnmaprox(2, [-2,-1,0,1,2], [-4, -2, 1, 2, 4], 1)
%   % Második fokú polinommal közelíti az adatokat
%   % Grafikon mutatja az eredényt
    % Bemenő vektorok méretének konzisztencia-ellenőrzése
    if (numel(csomopontokX) ~= numel(csomopontokY))  % Ha az x és y vektorok mérete különbözik
        error("A csomopontok x és y vektorok elemeinek azonos méretűnek kell lennie.");
    end

    % Legkisebb négyzetek approximáció: polinom együtthatók számítása
    egyutthatok = polyfit(csomopontokX, csomopontokY, polinomFokszam);  % MATLAB polyfit függvény

    % Közelítő polinom kiértékelése a megadott csomópontokban
    approxPolinom = polyval(egyutthatok, csomopontokX);  % Polinom kiértékelés: p(x_i)

    % Grafikus megjelenítés, ha kérték
    if grafikon == 1  % Ha a grafikon paraméter 1
        figure;  % Új ábra létrehozása
        plot(csomopontokX, csomopontokY, 'b', 'MarkerSize', 10);  % Eredeti adatpontok (kék)
        hold on;  % További elemek hozzáadása
        plot(csomopontokX, approxPolinom, 'r-', 'LineWidth', 2);  % Közelítő polinom (piros vonal)
        xlabel('X tengely');  % X tengely felirata
        ylabel('Y tengely');  % Y tengely felirata
        title('Legkisebb négyzetek módszerével közelített polinom');  % Ábra címe
        grid on;  % Rács bekapcsolása
        hold off;  % Hold kikapcsolása
    end

end