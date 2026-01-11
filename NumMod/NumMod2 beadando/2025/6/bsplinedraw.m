function bsplinedraw(indexek)
% bsplinedraw - B-Spline függvények megrajzolása a [0,1] intervallumon
%
% PROGRAM LEÍRÁS:
% Ez a függvény B-Spline alapfüggvényeket jelenít meg grafikusan a [0,1]
% intervallumon. A B-Spline függvények rekurzívan kerülnek kiszámításra.
% Segít megérteni a B-Spline görbék alapjait és az alapfüggvények alakját.
%
% Használat: bsplinedraw(indexek)
%
% Bemenő paraméter:
%   indexek - a megrajzolandó B-Spline függvények indexeinek vektora
%
% A függvény megjeleníti a megadott indexű B-Spline alapfüggvényeket
% a [0,1] intervallumon. A B-Spline függvények rekurzívan kerülnek kiszámításra.
%
% Teszteléshez:
%   bsplinedraw([8 4 6 1 2])
%   % Vagy: bsplinedraw(1:10) % első 10 B-Spline függvény
%   % A grafikon mutatja az alapfüggvényeket
    % Intervallum definiálása: [0,1] 100 egyenlő részre osztva
    interval = linspace(0,1,100);  % 100 pont a [0,1] intervallumon

    % B-Spline függvényértékek mátrixának inicializálása
    bSplineFuggveny = zeros(length(indexek), length(interval));  % indexek_szám x 100 mátrix

    % Végigmegyünk minden megadott indexen
    for II=1:length(indexek)  % II = 1-től az indexek számáig
        for JJ = 1:length(interval)  % JJ = 1-től 100-ig (minden intervallum pont)
            % B-Spline függvény kiértékelése az II-edik indexhez a JJ-edik pontban
            bSplineFuggveny(JJ) = bsplineRekurziv(indexek(II),0,interval(JJ));  % Rekurzív kiszámítás
        end
    end

    % B-Spline függvények grafikus megjelenítése
    figure;  % Új ábra létrehozása
    hold on;  % Több görbe rajzolása ugyanarra az ábrára
    for II = 1:length(indexek)  % Végigmegyünk minden indexen
        plot(interval, bSplineFuggveny(II, :), 'LineWidth', 2);  % II-edik B-Spline kirajzolása
    end
    title('B-Spline');  % Ábra címe
    xlabel('intervallum');  % X tengely: intervallum [0,1]
    ylabel('B-spline(intervallum)');  % Y tengely: B-Spline érték
    grid on;  % Rács bekapcsolása
    hold off;  % Hold kikapcsolása

    end  % bsplinedraw függvény vége

    function result = bsplineRekurziv(splineFokszam, kiertekeles, intervallumHelye)
    % B-Spline alap függvény rekurzív kiszámítása
    % Bemenő paraméterek:
    %   splineFokszam      - B-Spline fokszáma (rekurziós mélység)
    %   kiertekeles        - Kezdőpont (alapfüggvénynél x=0)
    %   intervallumHelye   - Kiértékelés helye: egy szám a [0, 1] intervallumból
    if splineFokszam == 0  % Rekurzió alapesete: nulladrendű B-Spline
        result = 1;  % B_0(x) = 1 (konstans)
    else  % Rekurzív eset: magasabb rendű B-Spline
        % Cox-de Boor rekurziós képlet:
        % B_n(x) = (x-t_i)/n * B_{n-1}(x) + (t_{i+n+1}-x)/n * B_{n-1}(x-1)
        result = (intervallumHelye - kiertekeles) / splineFokszam * bsplineRekurziv(splineFokszam - 1, kiertekeles, intervallumHelye) + ...
            (kiertekeles + splineFokszam + 1 - intervallumHelye) / splineFokszam * bsplineRekurziv(splineFokszam - 1, kiertekeles + 1, intervallumHelye);
    end
end