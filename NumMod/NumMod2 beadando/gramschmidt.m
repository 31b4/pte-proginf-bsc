function [Q, R] = gramschmidt(A)
    [m, n] = size(A);  % Meghatározza A sorainak és oszlopainak számát

    if m < n
        error('A mátrixnak több oszlopnak kell lennie, mint soroknak.');
    end

    Q = zeros(m, n);  % Inicializálja az ortogonális mátrix Q-t
    R = zeros(n, n);  % Inicializálja a felső háromszög mátrix R-t

    for j = 1:n
        v = A(:, j);  % Az aktuális oszlopot másolja v-be
        for i = 1:j-1
            R(i, j) = Q(:, i)' * A(:, j);  % Számolja ki R(i, j)-t
            v = v - R(i, j) * Q(:, i);  % Módosítja v-t az ortogonalizációhoz
        end
        R(j, j) = norm(v);  % Számolja ki R(j, j)-t, a norma segítségével
        if R(j, j) == 0
            error('A mátrix oszlopai lineárisan függők, a QR-felbontás nem megvalósítható.');
        end
        Q(:, j) = v / R(j, j);  % Normalizálja az ortogonális oszlopot
    end
end