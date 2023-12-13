function coefficients = lnmaprox(degree, nodes)
    % degree: Az approximációs polinom fokszáma
    % nodes: A csomópontok koordinátái [x1, y1; x2, y2; ...]

    % Csomópontok számának ellenőrzése
    if size(nodes, 2) ~= 2
        error('Csomópontok formátuma nem megfelelő. Két oszlop szükséges.');
    end
    
    % Az approximációs polinom fokszámának ellenőrzése
    if degree < 0 || degree ~= round(degree)
        error('Az approximációs polinom fokszámának egész pozitív számnak kell lennie.');
    end
    
    % Csomópontok koordinátáinak szétválasztása
    x = nodes(:, 1);
    y = nodes(:, 2);

    % Vandermonde mátrix létrehozása
    A = vander(x);

    % Csökkentett normál egyenletrendszer létrehozása
    AtA = A' * A;
    AtY = A' * y;

    % Egyenletrendszer megoldása
    coefficients = AtA \ AtY;

    % Grafikon készítése, ha a felhasználó azt kéri
    prompt = 'Szeretnél grafikont készíteni? (Igen: 1, Nem: 0): ';
    createPlot = input(prompt);

    if createPlot
        % Függvény értékeinek kiszámítása az approximációs polinom alapján
        xValues = linspace(min(x), max(x), 1000);
        yValues = polyval(flip(coefficients), xValues);

        % Grafikon megjelenítése
        figure;
        scatter(x, y, 'o', 'DisplayName', 'Csomópontok');
        hold on;
        plot(xValues, yValues, 'r-', 'DisplayName', 'Approximációs polinom');
        title('Legkisebb négyzetek módszerével approximált polinom');
        xlabel('x');
        ylabel('y');
        legend('show');
        grid on;
        hold off;
    end
end
