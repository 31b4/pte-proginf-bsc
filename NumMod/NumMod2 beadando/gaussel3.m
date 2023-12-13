function [inverse_matrix, determinant] = gaussel3(A)
    [m, n] = size(A);  % Az egyenletrendszer mátrix méreteinek meghatározása
    
    if m ~= n
        error('A bemeneti mátrix nem négyzet alakú.');  % Hiba, ha nem négyzet alakú a mátrix
    end
    
    if m == 0
        error('Az üres mátrixnak nincs inverze vagy determinánsa.');  % Hiba, ha üres a mátrix
    end
    
    if nargin > 1
        error('Túl sok bemeneti argumentum van. A függvény csak egy mátrixot fogad el.');  % Hiba, ha túl sok bemeneti argumentum van
    end
    
    % Determináns kiszámítása
    determinant = det(A);
    
    if determinant == 0
        error('A mátrixnak nincs inverze, mivel a determináns 0.');  % Hiba, ha a determináns 0
    end
    
    % Inverz számítása
    inverse_matrix = inv(A);
end
