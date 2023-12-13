function [Q, R] = hhalg(A)
    [m, n] = size(A); % A bemeneti mátrix sorainak és oszlopainak számát meghatározzuk.

    if m < n
        error('A bemeneti mátrixnak több oszlopa kell legyen, mint sorai.');
    end

    Q = eye(m); % Inicializáljuk az ortogonális mátrixot az egység mátrixszal.
    R = A; % Inicializáljuk a felső háromszög mátrixot a bemeneti mátrixsal.

    for k = 1:n % Ciklus minden oszlopon
        x = R(k:m, k); % Kiválasztjuk az aktuális oszlop részét.
        e = zeros(length(x), 1); % Létrehozunk egy nullmátrixot.

        e(1) = 1; % Az e vektor első eleme 1, amely az identitás vektor része.

        v = householder(x, e); % Householder-transzformáció vektorát számoljuk ki.

        P = eye(m); % Inicializáljuk a Householder-mátrixot az egység mátrixszal.
        P(k:m, k:m) = eye(m - k + 1) - 2 * v * v'; % Kiszámoljuk a Householder-mátrixot.

        R = P * R; % Az R mátrix átalakítása a Householder-mátrix segítségével.
        Q = Q * P'; % Az Q mátrix átalakítása a transzponált Householder-mátrix segítségével.
    end
end
