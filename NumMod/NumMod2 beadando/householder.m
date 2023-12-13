function H = householder(P, P0)
    % Ellenőrizzük, hogy a bemeneti vektorok azonos hosszúak
    if length(P) ~= length(P0)
        error('A bemeneti vektorok hossza eltérő.');
    end

    % Kiszámoljuk a Householder-transzformáció vektorát
    v = P0 - P;

    % Normalizáljuk a Householder-transzformáció vektort
    v = v / norm(v);

    % Számoljuk ki a Householder-transzformáció mátrixát
    H = eye(length(P)) - 2 * v * v';

    % A paraméter elojelének választása az irány függvényében
    if dot(P0 - P, P) < 0
        H = -H;
    end
end
