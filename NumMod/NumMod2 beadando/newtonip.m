% newtonip.m

function interpolating_polynomial = newtonip(x_points, y_values)
    % Ha nincsenek bemeneti paraméterek, kérdezi meg a felhasználótól az adatokat
    if nargin < 2
        prompt = 'Adja meg az alappontokat (x), vesszővel elválasztva: ';
        x_points = input(prompt);
        
        prompt = 'Adja meg a függvényértékeket az alappontokban, vesszővel elválasztva: ';
        y_values = input(prompt);
    end
    
    % Ellenőrizzük, hogy a bemeneti adatok megfelelő méretűek-e
    if length(x_points) ~= length(y_values)
        error('Az alappontok és a függvényértékek száma nem egyezik meg.');
    end
    
    % Newton interpolációs polinom számítása
    n = length(x_points);
    coefficients = y_values;
    
    for j = 2:n
        coefficients(j:n) = (coefficients(j:n) - coefficients(j-1)) ./ (x_points(j:n) - x_points(j-1));
    end
    
    % Az interpolációs polinom Newton alakja
    interpolating_polynomial = coefficients(1);
    
    % Numerikus változó bevezetése
    x_numeric = linspace(min(x_points), max(x_points), 1000);
    
    for i = 2:n
        term = 1;
        for j = 1:i-1
            term = term .* (x_numeric - x_points(j));
        end
        interpolating_polynomial = interpolating_polynomial + coefficients(i) * term;
    end
    
    % Grafikus ábrázolás
    figure;
    plot(x_points, y_values, 'o', 'MarkerSize', 8, 'MarkerFaceColor', 'r'); hold on;
    plot(x_numeric, interpolating_polynomial, 'b');
    title('Newton Interpoláció');
    xlabel('X tengely');
    ylabel('Y tengely');
    legend('Adatpontok', 'Interpolációs polinom', 'Location', 'Best');
    grid on;
    hold off;
    
    % Kérd meg a felhasználót, hogy szeretne-e új alappontot hozzáadni
    prompt = 'Szeretne új alappontot hozzáadni? (Igen/Nem): ';
    add_new_point = input(prompt, 's');
    
    if strcmpi(add_new_point, 'igen')
        new_x = input('Adjon meg egy új alappontot (x): ');
        new_y = input('Adja meg a függvényértéket az új alappontban: ');
        
        % Hozzáadja az új alappontot a listához
        x_points = [x_points, new_x];
        y_values = [y_values, new_y];
        
        % Újra futtatja a függvényt a frissített adatokkal
        newtonip(x_points, y_values);
    end
end
