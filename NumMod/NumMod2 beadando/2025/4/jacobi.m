function [x, info] = jacobi(A, b, opts)
% jacobi - Jacobi-iteráció lineáris egyenletrendszer megoldására
%
% PROGRAM LEÍRÁS:
% Ez a függvény lineáris egyenletrendszereket old meg a Jacobi-iterációs módszerrel.
% Az iteráció során minden ismeretlent külön-külön frissít a többi régi értékéből.
% A módszer konvergál ha az iterációs mátrix spektrálsugara kisebb mint 1.
% Részletes információkat szolgáltat a konvergenciáról és a hibabecslésekről.
%
% Használat: [x, info] = jacobi(A, b, opts)
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
% A Jacobi-iteráció: x^(k+1) = B*x^(k) + c, ahol B = -D^(-1)*(A-D)
%
% Teszteléshez:
%   A = [4 -1 0; -1 4 -1; 0 -1 4]; b = [1; 2; 3];
%   opts = struct('maxiter', 100, 'tol', 1e-8);
%   [x, info] = jacobi(A, b, opts)
%   fprintf('Iterációk: %d, Spektrálsugár: %.4f\n', ...
%           info.iterations, info.spectralRadius);
%   % Ellenőrzés: norm(A*x - b)
    % Opciós paraméterek ellenőrzése és alapértelmezett értékek beállítása
    if nargin < 3, opts = struct; end  % Ha nincs opts, üres struktúra
    if ~isfield(opts, 'x0'), opts.x0 = zeros(size(A, 2), 1); end  % Kezdőérték: nullvektor
    if ~isfield(opts, 'maxiter'), opts.maxiter = 100; end  % Max iteráció: 100
    if ~isfield(opts, 'tol'), opts.tol = 1e-8; end  % Tolerancia: 1e-8
    if ~isfield(opts, 'steps'), opts.steps = []; end  % Fix lépésszám nincs alapból

    % Jacobi-iteráció mátrixainak elkészítése
    D = diag(diag(A));  % Diagonális mátrix: A diagonális elemei
    B = -diag(1 ./ diag(A)) * (A - D);  % Iterációs mátrix: -D^(-1)*(A-D)
    c = diag(1 ./ diag(A)) * b;  % Transzformált jobboldal: D^(-1)*b

    % Iterációs mátrix B jellemzőinek kiszámítása
    norms = [norm(B, 1), norm(B, 2), norm(B, inf), norm(B, 'fro')];  % 1, 2, inf, Frobenius normák
    rad = max(abs(eig(B)));  % Spektrálsugár: legnagyobb sajátérték abszolútértéke

    % Cél iterációszám meghatározása
    target = opts.maxiter;  % Alapértelmezetten maxiter
    if ~isempty(opts.steps), target = opts.steps; end  % Ha van fix lépés, azt használjuk
    histR = zeros(max(1, target), 1);  % Reziduális norma történet inicializálása
    histD = zeros(max(1, target), 1);  % Különbség norma történet inicializálása

    % Kezdőérték beállítása és iteráció indítása
    x = opts.x0(:);  % Kezdővektor oszlopvektorként
    k = 0;  % Iterációk számlálója nulláról indul
    while k < target  % Amíg nem értük el a cél iterációszámot
        k = k + 1;  % Iterációszám növelése
        xNew = B * x + c;  % Új közelítés: Jacobi-iterációs lépés
        histR(k) = norm(b - A * xNew);  % Reziduális norma: ||b - A*x^(k+1)||
        histD(k) = norm(xNew - x);  % Különbség norma: ||x^(k+1) - x^(k)||
        x = xNew;  % Frissítjük az aktuális közelítést
        if isempty(opts.steps) && histD(k) < opts.tol, break; end  % Konvergencia-ellenőrzés
    end
    if k == 0, k = 1; end  % Biztonsági ellenőrzés: legalább 1 iteráció

    % Hibabecslés számítása minden normához
    bounds = nan(1, 4);  % Hibakorlátok vektora (kezdetben NaN)
    for i = 1:4  % Végigmegyünk mind a 4 normán
        if norms(i) < 1, bounds(i) = norms(i) / (1 - norms(i)) * histD(k); end  % Ha ||B|| < 1, számítható a hibabecslés
    end

    % Info struktúra feltöltése az eredményekkel
    info.x0 = opts.x0;  % Kezdőérték tárolása
    info.iterationMatrix = B;  % Iterációs mátrix
    info.spectralRadius = rad;  % Spektrálsugár
    info.matrixNorms = norms;  % Mátrixnormák vektora
    info.iterations = k;  % Végrehajtott iterációk száma
    info.residualHistory = histR(1:k);  % Reziduális történet (levágva k-ra)
    info.differenceHistory = histD(1:k);  % Különbség történet (levágva k-ra)
    info.errorBounds = bounds;  % Hibabecslések a különböző normákhoz
end
