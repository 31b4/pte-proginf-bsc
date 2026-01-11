function data = jomega(A, omegaRange, numPoints, withPlot)
% jomega - Csillapított Jacobi-iteráció vizsgálata
%
% PROGRAM LEÍRÁS:
% Ez a függvény megvizsgálja a SOR (Successive Over-Relaxation) módszer
% omega paraméterének hatását a konvergencia sebességére. Kiszámítja az
% iterációs mátrix spektrálsugrát különböző omega értékekre, megjeleníti
% grafikusan, és meghatározza az optimális omega értéket.
%
% Használat: data = jomega(A, omegaRange, numPoints, withPlot)
%
% Bemenő paraméterek:
%   A          - együttható mátrix
%   omegaRange - omega paraméter tartománya (alapértelmezett: [0, 2])
%   numPoints  - mintavételi pontok száma (alapértelmezett: 400)
%   withPlot   - grafikon rajzolása (alapértelmezett: true)
%
% Visszatérési érték:
%   data - struktúra az omega függvényében:
%          - sajátértékek abszolútértéke
%          - spektrálsugár
%          - konvergencia intervallumok
%          - optimális omega és spektrálsugár
%
% Ábrázolja az omega paraméter függvényében a sajátértékeket
%
% Teszteléshez:
%   A = [4 -1 0; -1 4 -1; 0 -1 4];
%   data = jomega(A, [0, 2], 400, true)
%   fprintf('Optimális omega: %.4f\n', data.optimalOmega);
%   fprintf('Minimális spektrálsugár: %.4f\n', ...
%           data.optimalSpectralRadius);
    % Bemenő paraméterek alapértelmezett értékeinek beállítása
    if nargin < 2, omegaRange = [0, 2]; end  % Omega tartomány: [0, 2]
    if nargin < 3, numPoints = 400; end  % Mintavételi pontok száma: 400
    if nargin < 4, withPlot = true; end  % Alapértelmezetten rajzolunk grafikont

    % Jacobi iterációs mátrix elkészítése
    D = diag(diag(A));  % Diagonális mátrix
    B = -diag(1 ./ diag(A)) * (A - D);  % Jacobi iterációs mátrix: -D^(-1)*(A-D)
    omegas = linspace(omegaRange(1), omegaRange(end), max(3, round(numPoints)));  % Omega értékek egyenletes osztása

    % Spektrális tulajdonságok számítása minden omega értékhez
    n = size(A, 1);  % Mátrix mérete
    vals = zeros(n, numel(omegas));  % Sajátértékek abszolútértékei (n x omega_szám)
    rho = zeros(size(omegas));  % Spektrálsugár minden omega-hoz
    I = eye(n);  % Egységmátrix
    for k = 1:numel(omegas)  % Végigmegyünk minden omega értéken
        eigVals = eig((1 - omegas(k)) * I + omegas(k) * B);  % Csillapított iterációs mátrix sajátértékei
        vals(:, k) = abs(eigVals);  % Sajátértékek abszolútértékei
        rho(k) = max(abs(eigVals));  % Spektrálsugár: legnagyobb sajátérték abs. értéke
    end

    % Konvergencia intervallumok meghatározása
    mask = rho < 1;  % Konvergens omega értékek maszkja (spektrálsugár < 1)
    conv = rho;  % Konvergens rész másolata
    conv(~mask) = NaN;  % Nem konvergens részek NaN-ra állítása (nem rajzoljuk)
    if any(mask)  % Ha van konvergens rész
        edges = diff([false, mask, false]);  % Él detektálás (konvergencia kezdete/vége)
        s = find(edges == 1);  % Konvergencia intervallumok kezdőpontjai
        t = find(edges == -1) - 1;  % Konvergencia intervallumok végpontjai
        intervals = [omegas(s)', omegas(t)'];  % Intervallumok mátrixa
        [best, rel] = min(rho(mask));  % Legjobb (legkisebb) spektrálsugár a konvergens részben
        idx = find(mask);  % Konvergens indexek
        idx = idx(rel);  % Optimális omega indexe
    else  % Ha nincs konvergens rész
        intervals = zeros(0, 2);  % Üres intervallum mátrix
        [best, idx] = min(rho);  % Legjobb spektrálsugár az összes közül
    end

    % Adatok struktúra feltöltése az eredményekkel
    data.omegaValues = omegas;  % Vizsgált omega értékek
    data.absEigenvalues = vals;  % Sajátértékek abszolútértékei (mátrix)
    data.spectralRadius = rho;  % Spektrálsugár minden omega-hoz
    data.convergenceIntervals = intervals;  % Konvergencia intervallumok
    data.optimalOmega = omegas(idx);  % Optimális omega érték
    data.optimalSpectralRadius = best;  % Minimális spektrálsugár
    data.iterationMatrix = B;  % Jacobi iterációs mátrix

    % Grafikus megjelenítés ha kérték
    if withPlot  % Ha engedélyezve van a grafikon
        figure;  % Új ábra létrehozása
        plot(omegas, vals, 'Color', [0.7, 0.7, 0.7]);  % Összes sajátérték (szürke)
        hold on;  % További görbék rajzolása
        plot(omegas, rho, 'k', 'LineWidth', 1.5);  % Spektrálsugár (fekete)
        plot(omegas, conv, 'Color', [0, 0.5, 0], 'LineWidth', 2);  % Konvergens rész (zöld)
        yline(1, '--r');  % Vízszintes vonal lambda=1-nél (piros szaggatott)
        plot(data.optimalOmega, best, 'ro', 'MarkerFaceColor', 'r');  % Optimális pont (piros kör)
        xlabel('\omega'); ylabel('|\lambda|');  % Tengelyek feliratai
        title('Csillapitott Jacobi spektrum');  % Ábra címe
        legend('Eigenvalues', 'Spectral radius', 'Convergent part', '|\lambda|=1', 'Optimal \omega');  % Jelmagyarázat
        grid on; hold off;  % Rács be, hold ki
    end
end
