function result = fl1(input_vector)
    % Ellenőrizze, hogy a bemenő vektor legalább egy elemet tartalmaz
    if isempty(input_vector)
        error('Az input vektor nem lehet üres.');
    end
    
    % Ellenőrizze, hogy a mantissza kordinátái {0,1} halmazból kerülnek-e ki
    if any(input_vector(1:end-1) ~= 0 & input_vector(1:end-1) ~= 1)
        error('A mantissza kordinátáinak {0,1} halmazból kell származnia.');
    end
    
    % Ellenőrizze, hogy az előjelbit értéke 0 vagy 1
    if input_vector(end) ~= 0 && input_vector(end) ~= 1
        error('Az utolsó elem a vektorban az előjelbitnek kell lennie (0 vagy 1).');
    end
    
    % Számolja ki a mantissza hosszát
    mantissa_length = length(input_vector) - 1 - 1;
    
    % Számolja ki az expoenst
    exponent = mantissa_length - 1;
    
    % Számolja ki a gépiszámot az előjellel és az expoenstől függően
    if input_vector(end) == 0
        % Pozitív szám esetén
        result = 2^exponent * bin2dec(['1' num2str(input_vector(1:end-1))]);
    else
        % Negatív szám esetén
        result = -2^exponent * bin2dec(['1' num2str(input_vector(1:end-1))]);
    end
end
