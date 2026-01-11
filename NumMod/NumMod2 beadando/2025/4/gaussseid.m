function [x, info] = gaussseid(A, b, opts)
% gaussseid - Gauss-Seidel iteráció lineáris egyenletrendszer megoldására
%
% PROGRAM LEÍRÁS:
% Ez a függvény lineáris egyenletrendszereket old meg a Gauss-Seidel iterációs
% módszerrel. A Jacobi-tól eltérően azonnal felhasználja az új értékeket,
% ami gyorsabb konvergenciát eredményez. Általában gyorsabb mint a Jacobi módszer,
% de nehezebb párhuzamosítani.
%
% Használat: [x, info] = gaussseid(A, b, opts)
%
% Bemenő paraméterek:
%   A    - együttható mátrix (n x n)
%   b    - jobboldali vektor (n x 1)
%   opts - opciók struktúra (opcionális):
%          opts.x0      - kezdőérték (alapértelmezett: nullvektor)
%          opts.maxiter - maximális iterációszám (alapértelmezett: 100)
%          opts.tol     - pontossági korlát (alapértelmezett: 1e-8)
%          opts.steps   - fix lépésszám (ha meg van adva)
%
% Visszatérési értékek:
%   x    - megoldásvektor közelítése
%   info - információs struktúra (iterációs mátrix, spektrálsugár, stb.)
%
% A Gauss-Seidel iteráció: x^(k+1) = B*x^(k) + c, ahol B = -(D+L)^(-1)*U
%
% Teszteléshez:
%   A = [4 -1 0; -1 4 -1; 0 -1 4]; b = [1; 2; 3];
%   opts = struct('maxiter', 100, 'tol', 1e-8);
%   [x, info] = gaussseid(A, b, opts)
%   fprintf('Iterációk: %d\n', info.iterations);
%   % Ellenőrzés: norm(A*x - b) < tol
    % Opciós paraméterek ellenőrzése és alapértelmezett értékek beállítása
    if nargin < 3, opts = struct; end  % Ha nincs opts, üres struktúra
    if ~isfield(opts, 'x0'), opts.x0 = zeros(size(A, 2), 1); end  % Kezdőérték: nullvektor
    if ~isfield(opts, 'maxiter'), opts.maxiter = 100; end  % Max iteráció: 100
    if ~isfield(opts, 'tol'), opts.tol = 1e-8; end  % Tolerancia: 1e-8
    if ~isfield(opts, 'steps'), opts.steps = []; end  % Fix lépésszám nincs alapból

    % Gauss-Seidel iteráció mátrixainak elkészítése
    L = tril(A, -1);  % Alsó háromszög mátrix (diagonális nélkül)
    D = diag(diag(A));  % Diagonális mátrix
    U = triu(A, 1);  % Felső háromszög mátrix (diagonális nélkül)
    M = D + L;  % M = D + L kombinált mátrix
    B = -(M \ U);  % Iterációs mátrix: -(D+L)^(-1)*U
    c = M \ b;  % Transzformált jobboldal: (D+L)^(-1)*b
    % Iterációs mátrix B jellemzőinek kiszámítása
    norms = [norm(B, 1), norm(B, 2), norm(B, inf), norm(B, 'fro')];  % 1, 2, inf, Frobenius normák
    rad = max(abs(eig(B)));  % Spektrálsugár: legnagyobb sajátérték abszolútértéke

    % Kezdőérték beállítása és iteráció előkészítése
    x = opts.x0(:);  % Kezdővektor oszlopvektorként
    target = opts.maxiter;  % Cél iterációszám alapértelmezetten maxiter
    if ~isempty(opts.steps), target = opts.steps; end  % Ha van fix lépés, azt használjuk
    histR = zeros(max(1, target), 1);  % Reziduális norma történet inicializálása
    histD = zeros(max(1, target), 1);  % Különbség norma történet inicializálása
    k = 0;  % Iterációk számlálója

    % Gauss-Seidel iterációs ciklus
    while k < target  % Amíg nem értük el a cél iterációszámot
        k = k + 1;  % Iterációszám növelése
        xNew = B * x + c;  % Új közelítés: Gauss-Seidel iterációs lépés
        histR(k) = norm(b - A * xNew);  % Reziduális norma: ||b - A*x^(k+1)||
        histD(k) = norm(xNew - x);  % Különbség norma: ||x^(k+1) - x^(k)||
        x = xNew;  % Frissítjük az aktuális közelítést
        if isempty(opts.steps) && histD(k) < opts.tol, break; end  % Konvergencia-ellenőrzés
    end

    % Biztonsági ellenőrzés és hibabecslés
    if k == 0, k = 1; end  % Legalább 1 iteráció
    bounds = nan(1, 4);  % Hibakorlátok vektora
    for i = 1:4  % Mind a 4 normához
        if norms(i) < 1, bounds(i) = norms(i) / (1 - norms(i)) * histD(k); end  % Hibabecslés ha ||B|| < 1
    end

    % Info struktúra feltöltése az eredményekkel
    info.x0 = opts.x0;  % Kezdőérték tárolása
    info.iterationMatrix = B;  % Iterációs mátrix
    info.spectralRadius = rad;  % Spektrálsugár
    info.matrixNorms = norms;  % Mátrixnormák vektora
    info.iterations = k;  % Végrehajtott iterációk száma
    info.residualHistory = histR(1:k);  % Reziduális történet
    info.differenceHistory = histD(1:k);  % Különbség történet
    info.errorBounds = bounds;  % Hibabecslések
end
