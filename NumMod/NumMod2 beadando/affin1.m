function A = affin1(varargin)
    % Bemeneti paraméterek kezelése
    if nargin == 0
        % Ha nincs bemeneti paraméter, lehetőség van a grafikus megadásra
        disp('Grafikus pontmegadás módban vagy. Kattints két pontot a grafikonon.');
        figure;
        axis([-1 1 -1 1]); % Grafikus ablak beállítása
        xlabel('X tengely');
        ylabel('Y tengely');
        xy = ginput(2)'; % Transzponáljuk az eredményt, hogy oszlopos vektor legyen
        disp('Pontok grafikus megadása kész.');
    elseif nargin == 2
        % Ha két bemeneti pont van megadva
        xy = [varargin{1}; varargin{2}]; % Kettős pontozás a sorok szétválasztásához
    else
        error('Helytelen számú bemeneti paraméter.');
    end

    % Pontok és képek összerendelése
    P = [0 1; 1 0]; % Eredeti pontok mátrixa
    Q = [xy(1, 1), xy(2, 1); xy(1, 2), xy(2, 2)]; % Képek mátrixa

    % Affin transzformáció mátrixának meghatározása
    A = Q / P;

    % Eredmény kiírása
    disp('Az affin transzformáció mátrixa:');
    disp(A);
end
