function x = gaussel2(A, b, method, showSteps)
% gaussel2 - Gauss elimináció részleges/teljes főelem-kiválasztással
%
% PROGRAM LEÍRÁS:
% Ez a függvény lineáris egyenletrendszereket old meg Gauss-eliminációval,
% főelem-kiválasztást (pivotalást) alkalmazva a numerikus stabilitás érdekében.
% Két módot támogat: részleges pivot (csak sorcsere) és teljes pivot (sor- és
% oszlopcsere is). Automatikusan teljes pivotra vált ha a részleges sikertelen.
%
% Használat: x = gaussel2(A, b, method, showSteps)
%
% A - együttható mátrix (négyzetes)
% b - jobboldali vektor
% method - 'partial' (részleges) vagy 'full' (teljes) főelem-kiválasztás
% showSteps - ha true, közbülső mátrixokat kiírja (opcionális)
%
% Teszteléshez:
%   A = [0 2 1; 1 -2 -3; -1 1 2]; b = [3; -3; -1];
%   x1 = gaussel2(A, b, 'partial', true)  % Részleges pivot
%   x2 = gaussel2(A, b, 'full', true)     % Teljes pivot
%   % Ellenőrzés: norm(A*x1 - b) < 1e-10
%
% Visszaadja az x megoldásvektort
%
% Ha részleges főelem-kiválasztás sikertelen, automatikusan teljes módra vált

    % Opcionális paraméterek alapértelmezése
    if nargin < 3
        method = 'partial';  % Alapértelmezett: részleges főelem-kiválasztás
    end
    if nargin < 4
        showSteps = false;  % Alapértelmezetten nem írjuk ki a lépéseket
    end

    % Mátrix méret ellenőrzése
    [n, m] = size(A);  % n x m mátrix
    if n ~= m
        error('A mátrix nem négyzetes.');  % Csak négyzetes mátrixra működik
    end
    if length(b) ~= n
        error('A vektor mérete nem megfelelő.');  % b hossza == n kell legyen
    end

    % Bővített mátrix létrehozása: [A | b]
    Ab = [A b(:)];
    perm = 1:n;  % Oszlop permutáció nyomon követése (teljes pivot esetén használjuk)
    switched_to_full = false;  % Jelző, ha partial-ról full-ra váltunk

    % Gauss-elimináció főelem-kiválasztással
    for k = 1:n-1  % Végigmegyünk az első n-1 oszlopon
        if strcmp(method, 'partial')
            % Részleges főelem-kiválasztás: csak sorok cseréje
            % Keressük a legnagyobb abszolút értékű elemet a k-adik oszlopban, k-tól n-ig
            [max_val, idx] = max(abs(Ab(k:n, k)));
            idx = idx + k - 1;  % Relatív index -> abszolút index konverzió
            
            % Ha a legnagyobb elem is túl kicsi (gyakorlatilag nulla)
            if max_val < eps
                fprintf('Figyelem: Részleges főelem-kiválasztás sikertelen a %d. lépésnél.\n', k);
                fprintf('Automatikus váltás teljes főelem-kiválasztásra.\n');
                method = 'full';  # Váltás teljes pivotra
                switched_to_full = true;  % Jelezzük a váltást
            else
                % Ha nem a k-adik sorban van a maximum, cseréljük meg a sorokat
                if idx ~= k
                    Ab([k idx], :) = Ab([idx k], :);  % Sor csere
                    if showSteps
                        fprintf('Részleges pivot: sor %d <-> sor %d\n', k, idx);
                    end
                end
            end
        end
        
        if strcmp(method, 'full')
            % Teljes főelem-kiválasztás: sorok ÉS oszlopok cseréje
            % Keressük a legnagyobb abszolút értékű elemet a k:n x k:n részben
            [max_val, max_idx] = max(abs(Ab(k:n, k:n)), [], 'all');
            % Lineáris index -> 2D index konverzió
            [p, q] = ind2sub([n-k+1, n-k+1], max_idx);
            p = p + k - 1;  % Relatív -> abszolút sor index
            q = q + k - 1;  % Relatív -> abszolút oszlop index
            
            % Ha még így is túl kicsi a pivot, hiba
            if max_val < eps
                error('Nulla pivot - az elimináció nem folytatható!');
            end
            
            % Sor csere (ha szükséges)
            if p ~= k
                Ab([k p], :) = Ab([p k], :);  % Teljes sor csere
                if showSteps
                    fprintf('Teljes pivot: sor %d <-> sor %d\n', k, p);
                end
            end
            
            % Oszlop csere (ha szükséges) - CSAK az együttható mátrix részén!
            % A jobboldalt (utolsó oszlop) NEM cseréljük
            if q ~= k
                Ab(:, [k q]) = Ab(:, [q k]);  % Oszlop csere
                perm([k q]) = perm([q k]);     % Permutáció nyilvántartása
                if showSteps
                    fprintf('Teljes pivot: oszlop %d <-> oszlop %d\n', k, q);
                end
            end
        end

        % Pivot elem ellenőrzése (biztonsági ellenőrzés)
        if abs(Ab(k, k)) < eps
            error('Nulla pivot!');  % Nem kellene előfordulnia a pivot választás után
        end

        % Elimináció: a k-adik oszlop nullázása a pivot alatt
        for i = k+1:n  % Minden pivot alatti sorra
            mult = Ab(i, k) / Ab(k, k);  % Multiplikátor számítása
            Ab(i, :) = Ab(i, :) - mult * Ab(k, :);  % Sorművelet
        end

        % Közbülső állapot kiírása (ha kértük)
        if showSteps
            fprintf('Lépés %d után:\n', k);
            disp(Ab);  % Aktuális bővített mátrix megjelenítése
        end
    end
    
    % Információ kiírása, ha váltottunk módszert
    if switched_to_full
        fprintf('Megjegyzés: A megoldás teljes főelem-kiválasztással készült.\n');
    end

    % Visszahelyettesítés (hátraló behelyettesítés)
    % Felső háromszög mátrixból oldjuk meg az egyenletrendszert
    x = zeros(n, 1);  % Megoldásvektor inicializálása
    for i = n:-1:1  % Visszafelé haladunk az utolsó sortól az elsőig
        % x[i] = (b[i] - Σ(a[i,j] * x[j])) / a[i,i]
        x(i) = (Ab(i, end) - Ab(i, 1:n) * x) / Ab(i, i);
    end
    
    % Ha teljes pivot volt, az oszlopcserék miatt rossz sorrendben vannak az x elemek
    % Vissza kell állítani az eredeti változó sorrendet
    if strcmp(method, 'full')
        x_temp = x;      % Mentjük az aktuális sorrendet
        x(perm) = x_temp;  % Permutáció inverze: visszaállítjuk az eredeti sorrendet
    end
end
