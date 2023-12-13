function fl2(t, k1, k2)
    % Ellenőrizze, hogy a bemenő adatok megfelelő formátumúak-e
    if ~isnumeric(t) || ~isnumeric(k1) || ~isnumeric(k2) || ...
            ~isscalar(t) || ~isscalar(k1) || ~isscalar(k2) || ...
            t < 0 || k1 >= k2
        error('Érvénytelen bemenő adatok. Ellenőrizze a formátumot és az értékeket.');
    end

    % Kiszámítja a gépi számhalmaz elemszámát
    n = 2^t;

    % Kiszámítja a "0" és "1" nevezetes elemeket
    M0 = fl1([zeros(1, t), 0]);
    M1 = fl1([zeros(1, t), 1]);

    % Számolások a szimmetria kihasználásával
    % Számolja ki az interval szélességét
    interval_width = (M1 - M0) / n;

    % Kezdőpont az M0-ban
    current_point = M0;

    % Ábrázolja a gépi számhalmaz elemeit
    fprintf('Gépi számhalmaz elemei:\n');
    for i = 1:n
        fprintf('%d: [%f, %f]\n', i, current_point, current_point + interval_width);
        current_point = current_point + interval_width;
    end
end
