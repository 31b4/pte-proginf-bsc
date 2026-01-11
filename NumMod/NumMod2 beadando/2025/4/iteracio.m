function results = iteracio(n, tol, maxiter, withPlot)
% iteracio - Jacobi és Gauss-Seidel iterációk összehasonlítása
%
% PROGRAM LEÍRÁS:
% Ez a függvény összehasonlítja a Jacobi és Gauss-Seidel iterációs módszereket
% egy tridiagonális tesztmátricon. Megjeleníti a konvergencia sebességét,
% az iterációk számát és a hibakövetést. Grafikusan is ábrázolja az eredményeket,
% segítve a két módszer összehasonlítását.
%
% Használat: results = iteracio(n, tol, maxiter, withPlot)
%
% Bemenő paraméterek:
%   n        - tridiagonális mátrix mérete (alapértelmezett: 10)
%   tol      - pontossági korlát (alapértelmezett: 1e-8)
%   maxiter  - maximális iterációszám (alapértelmezett: 200)
%   withPlot - grafikon rajzolása (alapértelmezett: true)
%
% Visszatérési érték:
%   results - struktúra a két módszer eredményeivel és összehasonlításukkal
%
% Tridiagonális tesztmátrix: A = 2*I - alsó és felső diagonális
%
% Teszteléshez:
%   results = iteracio(10, 1e-8, 200, true);
%   fprintf('Jacobi iterációk: %d\n', results.jacobi.info.iterations);
%   fprintf('GS iterációk: %d\n', results.gaussseid.info.iterations);
%   % Grafikon mutatja a konvergencia sebességet
    % Bemenő paraméterek ellenőrzése és alapértékek beállítása
    if nargin < 1 || isempty(n), n = 10; end  % Mátrix mérete: 10
    if nargin < 2 || isempty(tol), tol = 1e-8; end  % Tolerancia: 1e-8
    if nargin < 3 || isempty(maxiter), maxiter = 200; end  % Max iteráció: 200
    if nargin < 4, withPlot = true; end  % Alapértelmezetten rajzolunk grafikont

    % Tridiagonális tesztmátrix létrehozása
    A = 2 * eye(n) + diag(-ones(n-1, 1), 1) + diag(-ones(n-1, 1), -1);  % 2 a főátlón, -1 mellette
    b = ones(n, 1);  % Jobboldal: csupa 1-es vektor
    opts = struct('x0', zeros(n, 1), 'tol', tol, 'maxiter', maxiter);  % Opciók struktúra

    % Jacobi és Gauss-Seidel iterációk futtatása
    [xJ, infoJ] = jacobi(A, b, opts);  % Jacobi-módszer hívása
    [xG, infoG] = gaussseid(A, b, opts);  % Gauss-Seidel módszer hívása
    exact = A \ b;  % Pontos megoldás közvetlen módszerrel

    % Eredmények struktúra feltöltése
    results.A = A;  % A mátrix tárolása
    results.b = b;  % b vektor tárolása
    results.exact = exact;  % Pontos megoldás
    results.jacobi = struct('x', xJ, 'info', infoJ, 'error', norm(xJ - exact));  % Jacobi eredmények
    results.gaussseid = struct('x', xG, 'info', infoG, 'error', norm(xG - exact));  % Gauss-Seidel eredmények

    % Grafikus megjelenítés ha kérték
    if withPlot  % Ha engedélyezve van a grafikon
        figure;  % Új ábra létrehozása
        semilogy(infoJ.residualHistory, '-o');  % Jacobi reziduális (logaritmikus skála)
        hold on;  % További görbék rajzolása ugyanarra az ábrára
        semilogy(infoG.residualHistory, '-s');  % Gauss-Seidel reziduális
        xlabel('Iteracio'); ylabel('Residual');  % Tengelyek feliratai
        title('Jacobi vs Gauss-Seidel');  % Ábra címe
        legend('Jacobi', 'Gauss-Seidel');  % Jelmagyarázat
        grid on; hold off;  % Rács bekapcsolása, hold kikapcsolása
    end
end
