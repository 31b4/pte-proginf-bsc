% lagrangeip.m
% A Lagrange-interpolációt végző függvény
% 
% Bemeneti paraméterek:
%   - x_points: Az interpoláció alappontjai (vektor)
%   - y_values: A függvényértékek az alappontokban (vektor)
%
% Visszatérési érték:
%   - interpolating_polynomial: Az interpolációs polinom Lagrange alakja (vektor)
%
% A függvény először ellenőrzi, hogy az alappontok és a függvényértékek száma egyezik-e.
% Ezután kiszámolja az interpolációs polinomot Lagrange alakban az adott pontokon.
% Végül grafikusan ábrázolja az eredeti adatpontokat és az interpolációs polinomot.

function interpolating_polynomial = lagrangeip(x_points, y_values)
    % Ellenőrizzük, hogy a bemeneti adatok megfelelő méretűek-e
    if length(x_points) ~= length(y_values)
        error('Az alappontok és a függvényértékek száma nem egyezik meg.');
    end
    
    % Interpolációs polinom számítása
    n = length(x_points);
    interpolating_polynomial = zeros(size(x_points));
    
    for i = 1:n
        % Lagrange alapfüggvények szorzata
        L_i = 1;
        for j = 1:n
            if j ~= i
                L_i = L_i .* (x_points - x_points(j)) / (x_points(i) - x_points(j));
            end
        end
        
        interpolating_polynomial = interpolating_polynomial + y_values(i) * L_i;
    end
    
    % Grafikus ábrázolás
    figure;
    plot(x_points, y_values, 'o', 'MarkerSize', 8, 'MarkerFaceColor', 'r'); hold on;
    plot(x_points, interpolating_polynomial, 'b');
    title('Lagrange Interpoláció');
    xlabel('X tengely');
    ylabel('Y tengely');
    legend('Adatpontok', 'Interpolációs polinom', 'Location', 'Best');
    grid on;
    hold off;
end
