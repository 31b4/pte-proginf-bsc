function x = gaussel1(A, b, showSteps)
% gaussel1 - Gauss elimináció sor- és oszlopcsere nélkül
%
% PROGRAM LEÍRÁS:
% Ez a függvény lineáris egyenletrendszereket old meg Gauss-eliminációval,
% anélkül hogy sor- vagy oszlopcserét végezne (nincs pivotalás). Kezeli az
% alul- és túlhatározott rendszereket, valamint ellenőrzi a megoldhatóságot
% a Rouche-Capelli tétel alapján.
%
% Használat: x = gaussel1(A, b, showSteps)
%
% A - együttható mátrix (n x m)
% b - jobboldali vektor (n x 1)
% showSteps - ha true, kiírja a közbülső lépéseket (opcionális)
%
% Teszteléshez:
%   A = [2 1; 5 7]; b = [11; 13];
%   x = gaussel1(A, b, true)  % Lépések megjelenítése
%   % Ellenőrzés: norm(A*x - b) < 1e-10
%   
%   % Túlhatározott rendszer:
%   A2 = [1 2; 3 4; 5 6]; b2 = [1; 2; 3];
%   x2 = gaussel1(A2, b2)
%
% Visszaadja az x megoldásvektort
%
% Hibát dob, ha a GE nem hajtható végre sor/oszlopcsere nélkül
% Kezeli az alulhatározott rendszert (bázismegoldás)
% Kezeli a túlhatározott rendszert

    % Opcionális paraméter alapértelmezése
    if nargin < 3
        showSteps = false;  % Alapértelmezetten nem írjuk ki a lépéseket
    end

    % Mátrix dimenziók lekérdezése
    [n, m] = size(A);  % n = sorok száma, m = oszlopok száma
    % Ellenőrizzük, hogy a jobboldali vektor hossza megegyezik a sorok számával
    if size(b, 1) ~= n
        error('A jobboldali vektor mérete nem megfelelő.');
    end
    b = b(:);  % Biztosítjuk, hogy oszlopvektor legyen (reshape)

    % Bővített mátrix létrehozása: [A | b]
    % Ez a Gauss-elimináció általános formája
    Ab = [A b];

    % Gauss-elimináció (Előre elimináció)
    r = min(n, m);  % maximális rang (lépcsős alak maximális lépcsői)
    pivot_row = 1;  % Aktuális pivot sor indexe
    
    % Végigmegyünk a lehető pivot pozíciókon
    for k = 1:r
        % Ha elfogytak a sorok, befejezzük
        if pivot_row > n
            break;
        end
        
        % Ellenőrizzük a pivot elemet a k-adik oszlopban
        % Ha nulla, akkor sor/oszlopcsere kellene (de ez a metódus nem teszi)
        if abs(Ab(pivot_row, k)) < eps
            error('Nulla pivot a (%d,%d) pozícióban - szükséges lenne sor/oszlopcsere!', pivot_row, k);
        end
        
        % Elimináció: A pivot sor alatti sorokból elimnáljuk a k-adik oszlopot
        for i = pivot_row+1:n  % Minden pivot sor alatti sorra
            if Ab(i, k) ~= 0  % Ha nem nulla az elem
                % Számítjuk a multiplikátort: m = A[i,k] / A[pivot,k]
                mult = Ab(i, k) / Ab(pivot_row, k);
                % Sorművelet: i-edik sor = i-edik sor - m * pivot sor
                Ab(i, :) = Ab(i, :) - mult * Ab(pivot_row, :);
            end
        end
        
        % Ha kértük, kiírjuk a köztes eredményt
        if showSteps
            fprintf('Lépés %d után (pivot sor: %d, oszlop: %d):\n', k, pivot_row, k);
            disp(Ab);  % Megjelenítjük a mátrixot
        end
        
        pivot_row = pivot_row + 1;  % Következő pivot sor
    end

    % Rang ellenőrzése (Rouche-Capelli tétel)
    % rank(A) vs rank([A|b]) összehasonlítása
    rank_A = 0;   % A mátrix rangja
    rank_Ab = 0;  # Bővített mátrix rangja
    tol = 1e-10;  % Numerikus nullázási küszöb
    
    % Végigmegyünk minden soron és ellenőrizzük, hogy nulla sor-e
    for i = 1:n
        % Ha a sor A részében van nem-nulla elem
        if any(abs(Ab(i, 1:m)) > tol)
            rank_A = rank_A + 1;      % Növeljük rank(A)-t
            % Ha a jobboldal is nem nulla
            if abs(Ab(i, end)) > tol
                rank_Ab = rank_Ab + 1;  % Növeljük rank([A|b])-t
            end
        % Ha A része nulla, de jobboldal nem (inkonzisztencia jele)
        elseif abs(Ab(i, end)) > tol
            rank_Ab = rank_Ab + 1;  % Csak rank([A|b])-t növeljük
        end
    end
    
    % Rouche-Capelli tétel: megoldás létezik ⇔ rank(A) = rank([A|b])
    if rank_A < rank_Ab
        error('Az egyenletrendszer inkonzisztens (nincs megoldás).');
    end
    
    % Alulhatározott rendszer: több ismeretlen mint egyenlet
    if rank_A < m
        fprintf('Figyelem: Az egyenletrendszer alulhatározott.\n');
        fprintf('Egy bázismegoldást adunk vissza (szabad változók nullázva).\n');
    end
    
    % Túlhatározott rendszer: több egyenlet mint ismeretlen
    if n > m && rank_A == m
        fprintf('Figyelem: Az egyenletrendszer túlhatározott, de konzisztens.\n');
    end

    % Visszahelyettesítés (Hátráló behelyettesítés)
    % Lépcsős alakból visszafele haladva oldjuk meg az egyenleteket
    x = zeros(m, 1);  % Megoldásvektor inicializálása nullákkal
    
    % Visszafele haladunk az utolsó nem-nulla sortól az elsőig
    for i = min(rank_A, m):-1:1
        % Keressük meg az i-edik sor pivot oszlopát
        % (az első nem-nulla elem pozíciója)
        pivot_col = 0;
        for j = 1:m
            if abs(Ab(i, j)) > tol  % Ha találtunk nem-nulla elemet
                pivot_col = j;  % Ez a pivot oszlop
                break;          % Megállítjuk a keresést
            end
        end
        
        % Ha találtunk pivot oszlopot
        if pivot_col > 0
            % Kiszámítjuk az ismeretlen értékét:
            % x[pivot_col] = (b[i] - Σ(a[i,j] * x[j])) / a[i,pivot_col]
            % A már kiszámított x értékeket levonjuk
            x(pivot_col) = (Ab(i, end) - Ab(i, 1:m) * x) / Ab(i, pivot_col);
        end
    end
end
