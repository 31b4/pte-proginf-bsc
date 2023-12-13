function x = gaussel1(A, b)
    [m, n] = size(A);  % Az egyenletrendszer mátrix méreteinek meghatározása
    
    if m ~= n
        error('Az egyenletrendszer mátrixa nem négyzet alakú.');  % Hiba, ha nem négyzet alakú a mátrix
    end
    
    augmented_matrix = [A, b];  % Az augmentált mátrix létrehozása
    
    for k = 1:n
        % Pivot kiválasztása és sorcserék
        [max_val, max_idx] = max(abs(augmented_matrix(k:n, k)));  % Pivot sor kiválasztása
        max_idx = max_idx + k - 1;  % A pivot indexének frissítése
        
        if max_val == 0
            error('A Gauss-elimináció nem hajtható végre sor és oszlopcsere nélkül.');  % Hiba, ha nem lehet pivotot kiválasztani
        end
        
        augmented_matrix([k, max_idx], :) = augmented_matrix([max_idx, k], :);  % Sorcsere a pivot sorral
        
        % Pivot oszlop normálása
        pivot = augmented_matrix(k, k);
        augmented_matrix(k, :) = augmented_matrix(k, :) / pivot;  % Pivot oszlop normálása
        
        % Elimináció
        for i = k+1:n
            factor = augmented_matrix(i, k);  % Eliminációs faktor
            augmented_matrix(i, :) = augmented_matrix(i, :) - factor * augmented_matrix(k, :);  % Eliminációs lépés
        end
    end
    
    % Visszavezetés (back-substitution)
    x = zeros(n, 1);  % Megoldásvektor inicializálása
    for i = n:-1:1
        x(i) = augmented_matrix(i, end) - augmented_matrix(i, i+1:n) * x(i+1:n);  % Visszavezetés lépései
    end
end
