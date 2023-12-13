function A = affin2(varargin)
    % Bemeneti paraméterek kezelése
    if nargin == 0
        % Ha nincs bemeneti paraméter, lehetőség van a grafikus megadásra
        disp('Grafikus pontmegadás módban vagy. Válassz három csúcsot a háromszögön.');
        figure;
        axis([-1 1 -1 1]); % Grafikus ablak beállítása
        xlabel('X tengely');
        ylabel('Y tengely');
        vertices = ginput(3)'; % Transzponáljuk az eredményt, hogy oszlopos vektor legyen
        disp('Csúcsok grafikus megadása kész.');
        
        disp('Most válassz három transzformációbeli képet az előbbi három pontnak.');
        transformedVertices = ginput(3)'; % Transzponáljuk az eredményt, hogy oszlopos vektor legyen
        disp('Transzformációbeli képek grafikus megadása kész.');
    elseif nargin == 6
        % Ha hat bemeneti paraméter van megadva
        vertices = [varargin{1:2}, varargin{3:4}, varargin{5:6}]; % Pontokat és képeket összefűzi
        transformedVertices = [varargin{7:8}, varargin{9:10}, varargin{11:12}]; % Transzformációs képeket összefűzi
    else
        error('Helytelen számú bemeneti paraméter.');
    end

    % Eredeti és transzformált csúcsokat összefűző mátrixok
    P = [vertices; ones(1, 3)]; % Eredeti csúcsok
    Q = [transformedVertices; ones(1, 3)]; % Transzformált csúcsok

    % Affin transzformáció mátrixának meghatározása
    A = Q / P;

    % Eredmény kiírása
    disp('Az affin transzformáció mátrixa:');
    disp(A);
end
