function result = numint(integrand, a, b, n, type)
    % integrand: Az integrandus függvény (stringként)
    % a, b: Az integrálás intervallumának végpontjai
    % n: Osztópontok száma
    % type: Kvadratúra formula típusa ('téglalap', 'trapéz', 'simpson')

    % Függvény átalakítása inline függvénnyé
    f = inline(integrand, 'x');

    % Osztópontok létrehozása
    x = linspace(a, b, n + 1);

    % Kvadratúra formula típusának ellenőrzése és integrálás
    switch lower(type)
        case 'téglalap'
            result = rectangleRule(f, x);
        case 'trapéz'
            result = trapezoidalRule(f, x);
        case 'simpson'
            result = simpsonsRule(f, x);
        otherwise
            error('Érvénytelen kvadratúra formula típus.');
    end
end

% Téglalap szabály integrálási módszer
function result = rectangleRule(f, x)
    h = x(2) - x(1);
    result = h * sum(f(x(1:end-1)));
end

% Trapéz szabály integrálási módszer
function result = trapezoidalRule(f, x)
    h = x(2) - x(1);
    result = h * (sum(f(x(1:end-1))) + 0.5 * (f(x(end)) + f(x(end-1))));
end

% Simpson szabály integrálási módszer
function result = simpsonsRule(f, x)
    h = x(2) - x(1);
    result = h / 3 * (f(x(1)) + 4 * sum(f(x(2:2:end-2))) + 2 * sum(f(x(3:2:end-2))) + f(x(end)));
end
