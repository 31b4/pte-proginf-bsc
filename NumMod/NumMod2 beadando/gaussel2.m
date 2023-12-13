function x = gaussel2(A, b, full_pivoting)
    [m, n] = size(A);  % Az egyenletrendszer mátrix méreteinek meghatározása
    
    if m ~= n
        error('Az egyenletrendszer mátrixa nem négyzet alakú.');  % Hiba, ha nem négyzet alakú a mátrix
    end
    
    if nargin < 3
        full_pivoting = false;  % Alapértelmezett érték: részleges föelemkiválasztás
    end
    
    augmented_matrix = [A, b];  % Az augmentált mátrix létrehozása
    
    for k = 1:n
        if full_pivoting
            % Teljes föelemkiválasztás
            [max_val, max_row_idx] = max(abs(augmented_matrix(k:n, k:n)));
            [~, max_col_idx] = max(max_val);
            max_row_idx = max_row_idx(max_col_idx) + k - 1;
        else
            % Részleges föelemkiválasztás
            [max_val, max_row_idx] = max(abs(augmented_matrix(k:n, k)));
            max_row_idx = max_row_idx + k - 1;
        end
        
        if max_val == 0
            if full_pivoting
                error('A teljes föelemkiválasztás nem hajtható végre sor és oszlopcsere nélkül.');
            else
                disp('Részleges föelemkiválasztás eredménye: Teljes föelemkiválasztás szükséges.');
                full_pivoting = true;
                continue;
            end
        end
        
        augmented_matrix([k, max_row_idx], :) = augmented_matrix([max_row_idx, k], :);  % Sorcserék
        
        pivot = augmented_matrix(k, k);
        augmented_matrix(k, :) = augmented_matrix(k, :) / pivot;  % Pivot oszlop normálása
        
        for i = k+1:n
            factor = augmented_matrix(i, k);
            augmented_matrix(i, :) = augmented_matrix(i, :) - factor * augmented_matrix(k, :);  % Eliminációs lépések
        end
    end
    
    x = zeros(n, 1);  % Megoldásvektor inicializálása
    for i = n:-1:1
        x(i) = augmented_matrix(i, end) - augmented_matrix(i, i+1:n) * x(i+1:n);  % Visszavezetés lépései
    end
end
