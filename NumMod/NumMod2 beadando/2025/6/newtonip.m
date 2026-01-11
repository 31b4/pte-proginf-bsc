function ntmeg = newtonip(alappontok, y, graf)
% newtonip - Newton-interpoláció (osztott differenciákkal)
%
% PROGRAM LEÍRÁS:
% Ez a függvény Newton-interpolációs polinomot képez adott alappontokon.
% Az osztott differenciák táblázatát használja, amely lehetővé teszi új alappontok
% hatékony hozzáadását. Interaktívan lehetőséget ad új pontok felvételére,
% és opcionálisan grafikusan megjeleníti az interpolációs polinomot.
%
% Használat: ntmeg = newtonip(alappontok, y, graf)
%
% Bemenő paraméterek:
%   alappontok - interpolációs alappontok (x koordináták)
%   y          - függvényértékek az alappontokban
%   graf       - ha 1, grafikus szemléltetés (opcionális)
%
% Visszatérési érték:
%   ntmeg - az interpolációs polinom Newton alakában (szimbolikus)
%
% Az interpolációs polinom Newton alakja:
% P(x) = f[x0] + f[x0,x1](x-x0) + f[x0,x1,x2](x-x0)(x-x1) + ...
%
% Lehetőség új alappontok hozzáadására futás közben
%
% Teszteléshez:
%   ntmeg = newtonip([1 4 9], [2 3 4], 1) % f(x) = sqrt(x) + 1
%   % Grafikon mutatja az interpolációt
%   % Vagy: ntmeg = newtonip([0 1 2], [1 2 5], 0) % ábra nélkül
    % Alappontok számának megállapítása
    meret = length(alappontok);  % Hány alappont van

    % Méret-konzisztencia ellenőrzése
    if (meret ~= length(y))  % Ha x és y vektorok mérete nem egyezik
        error("Hiba! A függvény x és y koordinátáinak száma nem eggyezik!");
    end

    % Osztott differenciák táblázatának inicializálása
    osztdiff = zeros(meret,meret);  % meret x meret nullákkal feltöltött mátrix
    osztdiff(:,1) = y;  % Az első oszlop: a megadott függvényértékek (y)

    % Osztott differenciák kiszámítása (rekurzív képlet)
    for II = 2:meret  % II = 2-től meret-ig (sorok)
        for JJ = 2:II  % JJ = 2-től II-ig (oszlopok a diagonálisig)
            % Osztott differencia: f[x_{II-JJ+1},...,x_{II}]
            osztdiff(II, JJ) = (osztdiff(II, JJ-1) - osztdiff(II-1, JJ-1)) / (alappontok(II) - alappontok(II-JJ+1));
        end
    end

    % Newton-polinom együtthatóinak kigyűjtése és polinom létrehozása
    % Newton alak: N0 + N1(x-x0) + N2(x-x0)(x-x1) + ...
    % Newton együtthatók: az osztott differenciák mátrix főátlója
    newtonCoeffs = diag(osztdiff)';  % Átló kivonata és transzponálása sorvektorra
    
    % Interpolációs polinom function handle-ként (Newton alakban)
    interpolaciosPolinom = @(x) evaluateNewtonPolynomial(x, newtonCoeffs, alappontok);  % Kiértékelő függvény
    
    % Megoldás megjelenítése a konzolra
    disp("A megoldás (Newton együtthatók):");  % Címsor
    disp("Együtthatók: ");  % Együtthatók címke
    disp(newtonCoeffs);  % Newton együtthatók vektorának kiírása
    disp("Alappontok: ");  % Alappontok címke
    disp(alappontok);  % Alappontok vektorának kiírása

    % Felhasználói interakció: további alappontok hozzáadásának lehetősége
    valasz = input('Szeretne új alappontot hozzáadni? (igen = 1, nem = 0): ');  % Kérdés a felhasználónak

    % While ciklus: amíg a felhasználó új pontot akar hozzáadni
    while valasz == 1  % Amíg a válasz 1 (igen)
        bemenetX = input('Új Alappont: ');  % Új x koordináta bekérése
        bemenetY = input('Új függvényérték (y): ');  % Új y koordináta bekérése

        % Az új pont hozzáadása a megfelelő vektorokhoz
        alappontok = [alappontok, bemenetX];  % X vektor bővítése
        y = [y, bemenetY];  % Y vektor bővítése

        % Interpoláció újraszámítása az új alapponttal
        meret = length(alappontok);  % Frissített méret
        osztdiff = zeros(meret, meret);  % Új táblázat inicializálása
        osztdiff(:, 1) = y';  % Első oszlop: y értékek (oszlopvektorként)
        for II = 2:meret  % Sorok bejárása
            for JJ = 2:II  % Oszlopok bejárása (diagonálisig)
                % Osztott differencia újraszámítása
                osztdiff(II, JJ) = (osztdiff(II, JJ-1) - osztdiff(II-1, JJ-1)) / (alappontok(II) - alappontok(II-JJ+1));
            end
        end

        % Új Newton-polinom létrehozása a frissített adatokkal
        newtonCoeffs = diag(osztdiff)';  % Új együtthatók: főátló kivonata
        interpolaciosPolinom = @(x) evaluateNewtonPolynomial(x, newtonCoeffs, alappontok);  % Új kiértékelő függvény

        % Frissített megoldás megjelenítése
        disp("A megoldás (Newton együtthatók):");  % Címsor
        disp("Együtthatók: ");  % Együtthatók címke
        disp(newtonCoeffs);  % Frissített együtthatók
        disp("Alappontok: ");  % Alappontok címke
        disp(alappontok);  % Frissített alappontok

        % Újabb kérdés a felhasználónak
        valasz = input('Szeretne új alappontot hozzáadni? (igen = 1, nem = 0): ');  % Folytatás?
    end  % while ciklus vége

    % Grafikus megjelenítés, ha kérték (graf paraméter = 1)
    if nargin >= 3 && graf == 1  % Ha van 3. paraméter és az 1
        figure;  % Új ábra létrehozása
        xplot = linspace(min(alappontok) - 1, max(alappontok) + 1, 200);  % X értékek rajzoláshoz (200 pont)
        yplot = arrayfun(interpolaciosPolinom, xplot);  % Polinom kiértékelése minden x-re
        plot(xplot, yplot, 'b-', 'LineWidth', 2);  % Polinom kirajzolása (kék vonal)
        hold on;  % További elemek hozzáadása
        plot(alappontok, y, 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'r');  % Alappontok (piros körök)
        grid on;  % Rács bekapcsolása
        xlabel('x');  % X tengely felirata
        ylabel('y');  % Y tengely felirata
        title('Newton interpoláció');  % Ábra címe
        legend('Interpolációs polinom', 'Alappontok');  % Jelmagyarázat
        hold off;  % Hold kikapcsolása
    end

    % Visszatérési érték: az interpolációs polinom function handle-je
    ntmeg = interpolaciosPolinom;  % Function handle a polinom kiértékeléséhez

end

function result = evaluateNewtonPolynomial(x, coeffs, nodes)
    % Newton-polinom kiértékelése x pontokban
    % Bemenő paraméterek:
    %   x      - kiértékelési pontok (vektor vagy skalár)
    %   coeffs - Newton együtthatók
    %   nodes  - alappontok (csómpontok)
    n = length(coeffs);  % Együtthatók száma
    result = coeffs(1) * ones(size(x));  % Kezdő érték: N0 (konstans tag)
    
    % Végigmegyünk a további tagokon
    for i = 2:n  % i = 2-től n-ig
        term = coeffs(i) * ones(size(x));  % i-edik együttható
        for j = 1:i-1  % Szorzótag: (x-x0)(x-x1)...(x-x_{i-2})
            term = term .* (x - nodes(j));  % Szorozzás (x - x_j)-vel
        end
        result = result + term;  % Hozzáadjuk az eredményhez
    end
end