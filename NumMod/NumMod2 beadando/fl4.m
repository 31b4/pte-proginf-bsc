function result = fl4(vec1, vec2)
    % Ellenőrizze, hogy a két szám azonos számhalmazból való-e
    if length(vec1) ~= length(vec2)
        error('A két szám különböző hosszúságú.');
    end
    
    % Számolja ki a mantissza hosszát
    t = length(vec1) - 1;
    
    % Ellenőrizze, hogy a mantissza elso bitje 1-e (negatív szám)
    if vec1(1) == 1 || vec2(1) == 1
        % Negatív számok esetén szükség van kivonásra
        subtract = true;
    else
        subtract = false;
    end
    
    % Ellenőrizze, hogy a karakterisztika azonos
    if vec1(t + 1) ~= vec2(t + 1)
        error('A karakterisztika nem azonos.');
    end
    
    % Számolja ki a gépi számok összegét (vagy különbségét)
    if subtract
        % Kivonás
        result = fl4_subtract(vec1, vec2);
    else
        % Összeadás
        result = fl4_add(vec1, vec2);
    end
    
    % Normalizálás
    result = fl4_normalize(result);
end

function result = fl4_add(vec1, vec2)
    % Készítse el a gépi összeadás eredményét
    t = length(vec1) - 1;
    result = zeros(1, t + 1);
    carry = 0;
    
    for i = t:-1:1
        sum = vec1(i) + vec2(i) + carry;
        if sum >= 2
            carry = 1;
            sum = sum - 2;
        else
            carry = 0;
        end
        result(i) = sum;
    end
    
    % Ha van túlcsordulás, hozzuk hozzá a túlcsordulást a karakterisztikához
    if carry == 1
        result(t + 1) = result(t + 1) + 1;
    end
end

function result = fl4_subtract(vec1, vec2)
    % Készítse el a gépi kivonás eredményét
    t = length(vec1) - 1;
    result = zeros(1, t + 1);
    borrow = 0;
    
    for i = t:-1:1
        diff = vec1(i) - vec2(i) - borrow;
        if diff < 0
            borrow = 1;
            diff = diff + 2;
        else
            borrow = 0;
        end
        result(i) = diff;
    end
    
    % Ha van alulcsordulás, hozzuk hozzá az alulcsordulást a karakterisztikához
    if borrow == 1
        result(t + 1) = result(t + 1) - 1;
    end
end

function result = fl4_normalize(vec)
    % Normalizálja a gépi számot, hogy ne legyen túlcsordulás
    t = length(vec) - 1;
    carry = 0;
    
    for i = t:-1:1
        vec(i) = vec(i) + carry;
        if vec(i) >= 2
            carry = 1;
            vec(i) = vec(i) - 2;
        else
            carry = 0;
        end
    end
    
    % Ha van túlcsordulás, hozzuk hozzá a túlcsordulást a karakterisztikához
    if carry == 1
        vec(t + 1) = vec(t + 1) + 1;
    end
    
    result = vec;  % Adjunk értéket a "result" változónak
end
