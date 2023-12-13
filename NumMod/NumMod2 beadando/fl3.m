function result = fl3(varargin)
    % Ellenőrizze, hogy legalább egy bemenő paramétert megadtak
    if nargin < 1
        error('Nincs megadva bemenő paraméter.');
    end
    
    % Alapértelmezett gépi számhalmaz (M(8;-5;5))
    t_default = 8;
    k1_default = -5;
    k2_default = 5;
    
    % Ellenőrizze, hány bemenő paramétert kapott
    if nargin == 1
        % Ha csak egy bemenő paramétert kapott, használja az alapértelmezett halmazt
        t = t_default;
        k1 = k1_default;
        k2 = k2_default;
    elseif nargin == 3
        % Ha három bemenő paramétert kapott, használja a megadott értékeket
        t = varargin{1};
        k1 = varargin{2};
        k2 = varargin{3};
    else
        error('Helytelen bemenő paraméterek száma. Használja: fl3(t, k1, k2) vagy fl3(x).');
    end
    
    % Ellenőrizze, hogy a szám ábrázolható-e a megadott halmazon
    if t < 1 || k1 >= k2
        error('A megadott halmaz érvénytelen.');
    end
    
    % Számolja ki a mantissza hosszát
    mantissa_length = t - 1;
    
    % Számolja ki a karakterisztikát
    exponent = log2(abs(k2 - k1));
    
    % Számolja ki az elojeles mantisszát
    if k1 < 0
        sign_bit = 1;
    else
        sign_bit = 0;
    end
    
    % Állítsa össze a gépi alakot a vektorban
    result = zeros(1, t + 1);
    result(1:mantissa_length) = sign_bit;
    result(t + 1) = exponent;
    
    % Ábrázolja az eredményt 10-es számrendszerben
    fprintf('Gépi alak: [');
    for i = 1:t
        fprintf('%d', result(i));
    end
    fprintf('; %d]\n', result(t + 1));
end
