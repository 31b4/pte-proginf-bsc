function Aplus = geninv(A)
    % Aplus: Az általánosított inverz (A+)

    % Rangfaktorizáció
    r = rank(A);

    % Az A mátrix méretei
    [m, n] = size(A);

    % Ranghiány esetén hiba
    if r < min(m, n)
        error('A mátrix nem teljes rangú, nincs általánosított inverze.');
    end

    % QR faktorizáció
    [Q, R] = qr(A);

    % Az általánosított inverz kiszámítása
    Aplus = R \ Q';

    % Kiíratás, ha szükséges
    disp('Az általánosított inverz:');
    disp(Aplus);
end
