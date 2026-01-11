function [Ainv, detA, L, U] = gaussel3(A, showSteps)
% gaussel3 - Mátrix inverz, determináns, LU felbontás
%
% PROGRAM LEÍRÁS:
% Ez a függvény kiszámítja egy négyzetes mátrix inverzét, determinánsát,
% valamint LU felbontását (PA = LU alak). A felbontás részleges pivotalást használ
% a numerikus stabilitás érdekében. Az inverz számítása LU felbontás alapján
% történik, n darab lineáris egyenletrendszer megoldásával.
%
% Használat: [Ainv, detA, L, U] = gaussel3(A, showSteps)
%
% A - bemenő négyzetes mátrix
% showSteps - ha true, kiírja az LU felbontást (opcionális)
%
% Teszteléshez:
%   A = [4 7; 2 6];
%   [Ainv, detA, L, U] = gaussel3(A, true)
%   % Ellenőrzések:
%   % norm(A*Ainv - eye(2)) < 1e-10  % A*A^(-1) = I
%   % norm(L*U - A) < 1e-10          % LU = PA (P figyelembevételével)
%   % detA  % Várt: 10
%
% Visszaadja:
%   Ainv - A inverze
%   detA - A determinánsa
%   L - alsó háromszög mátrix (LU felbontásból)
%   U - felső háromszög mátrix (LU felbontásból)

    % Opcionális paraméter alapértelmezése
    if nargin < 2
        showSteps = false;  % Alapértelmezetten nem írjuk ki a részleteket
    end

    % Mátrix méret ellenőrzése
    [n, m] = size(A);
    if n ~= m
        error('Csak négyzetes mátrix adható meg!');  % Inverz csak négyzetes mátrixra
    end

    % LU felbontás (PA = LU alakban, ahol P permutációs mátrix)
    % L = alsó háromszög mátrix, U = felső háromszög mátrix
    L = eye(n);  % L inicializálása egységmátrixszal (átló = 1)
    U = A;       % U kezdetben A-val egyenlő, ezt alakítjuk át
    P = eye(n);  % Permutációs mátrix (egységmátrixból indul)
    
    % Gauss-elimináció LU felbontással
    for k = 1:n-1  % Első n-1 oszlopon
        % Részleges főelem-kiválasztás: legnagyobb abszolút érték keresése a k-adik oszlopban
        [~, pivot_row] = max(abs(U(k:n, k)));
        pivot_row = pivot_row + k - 1;  % Relatív -> abszolút index
        
        % Ha a legnagyobb elem is nulla, a mátrix szinguláris
        if abs(U(pivot_row, k)) < eps
            error('A mátrix szinguláris, nem invertálható!');
        end
        
        % Sor csere (ha szükséges) U-ban és P-ben
        if pivot_row ~= k
            U([k pivot_row], :) = U([pivot_row k], :);  % U sorok cseréje
            P([k pivot_row], :) = P([pivot_row k], :);  % P sorok cseréje
            % L-ben is cserélni kell a már kiszámolt elemeket (az átló alattiak)
            if k > 1
                L([k pivot_row], 1:k-1) = L([pivot_row k], 1:k-1);
            end
        end
        
        % Elimináció és L mátrix feltöltése
        for i = k+1:n  % Pivot alatt lévő sorok
            % L[i,k] = multiplikátor = U[i,k] / U[k,k]
            L(i, k) = U(i, k) / U(k, k);
            % Sorművelet: i-edik sor -= L[i,k] * k-adik sor
            U(i, k:n) = U(i, k:n) - L(i, k) * U(k, k:n);
        end
    end
    
    % Utolsó átlóelem ellenőrzése
    if abs(U(n, n)) < eps
        error('A mátrix szinguláris, nem invertálható!');
    end
    
    % LU felbontás eredményének kiírása (ha kértük)
    if showSteps
        fprintf('LU felbontás (PA = LU):\n\n');
        fprintf('L (alsó háromszög mátrix):\n');
        disp(L);
        fprintf('U (felső háromszög mátrix):\n');
        disp(U);
        fprintf('P (permutációs mátrix):\n');
        disp(P);
        fprintf('Ellenőrzés - PA:\n');
        disp(P*A);
        fprintf('Ellenőrzés - LU:\n');
        disp(L*U);
    end
    
    % Determináns számítása a PA = LU felbontásból
    % det(PA) = det(P) * det(A), és det(PA) = det(LU) = det(L) * det(U)
    % Tehát: det(A) = det(L) * det(U) / det(P)
    % det(L) = 1 (mivel L átlója csupa 1-es)
    % det(U) = U átlóelemeinek szorzata (háromszög mátrix determinánsa)
    % det(P) = ±1 a sorok cseréjének paritásától függően
    detU = prod(diag(U));  % U átlóelemeinek szorzata
    detP = det(P);  % P determinánsa (±1)
    detA = detP * detU;  % A determinánsa
    
    % Inverz számítása LU felbontás alapján
    % Meg kell oldanunk az A * X = I egyenletet, ahol X = A^-1 és I az egységmátrix
    % PA = LU miatt: A = P^T * L * U (mivel P ortogonális, P^-1 = P^T)
    % Tehát: P^T * L * U * X = I => L * U * X = P * I => LU * X = P
    % Ezt n különálló egyenletrendszerként oldjuk meg, mindegyik oszlopra
    
    Ainv = zeros(n, n);  % Inverz mátrix tárolója
    for j = 1:n  % Végigmegyünk az I minden oszlopán (egységvektorokon)
        % Megoldjuk A * x = e_j-t, ahol e_j a j-edik egységvektor
        e = zeros(n, 1);
        e(j) = 1;  % j-edik pozíció = 1, többi = 0
        
        % PA * x = P * e_j alakítás miatt: LU * x = P * e_j
        b = P * e;  % Permutált jobboldal
        
        % 1. lépés: Előre behelyettesítés L * y = b megoldása
        % Alsó háromszög mátrix => előrefelé haladunk
        y = zeros(n, 1);
        for i = 1:n
            % y[i] = (b[i] - Σ(L[i,k] * y[k])) / L[i,i]
            y(i) = (b(i) - L(i, 1:i-1) * y(1:i-1)) / L(i, i);
        end
        
        % 2. lépés: Visszahelyettesítés U * x = y megoldása
        % Felső háromszög mátrix => visszafelé haladunk
        x = zeros(n, 1);
        for i = n:-1:1
            % x[i] = (y[i] - Σ(U[i,k] * x[k])) / U[i,i]
            x(i) = (y(i) - U(i, i+1:n) * x(i+1:n)) / U(i, i);
        end
        
        % Az x vektor lesz az inverz j-edik oszlopa
        Ainv(:, j) = x;
    end
    
    if showSteps
        fprintf('\nInverz mátrix:\n');
        disp(Ainv);
        fprintf('Ellenőrzés - A * A^-1:\n');
        disp(A * Ainv);
        fprintf('Determináns: %.10f\n', detA);
    end
end
