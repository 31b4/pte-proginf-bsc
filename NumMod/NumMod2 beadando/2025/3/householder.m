function H = householder(P, P0)
% householder - Householder transzformáció mátrixának kiszámítása
%
% PROGRAM LEÍRÁS:
% Ez a függvény kiszámítja azt a Householder (tükrözési) mátrixot, amely
% egy P pontot egy P0 pontba transzformál. A Householder mátrix egy ortogonális
% mátrix, amely tükrözést hajt végre egy hipersíkra. Tetszőleges dimenzióban működik.
%
% Használat: H = householder(P, P0)
%
% Bemenő paraméterek:
%   P  - eredeti pont koordinátái (vektor)
%   P0 - kép pont koordinátái (vektor)
%
% Visszatérési érték:
%   H - Householder transzformáció mátrixa (n x n)
%       Tulajdonság: H * P = P0 (tükrözés)
%
% Működik tetszőleges dimienzióban
%
% Teszteléshez:
%   P = [1; 2]; P0 = [2; 1];  % 2D példa
%   H = householder(P, P0)
%   result = H * P  % Kell: ~= P0
%   norm(result - P0)  % Kell: ~0
%   
%   % 3D példa:
%   P3 = [1; 0; 0]; P03 = [0; 1; 0];
%   H3 = householder(P3, P03)

    % Biztosítjuk hogy az input vektorok oszlopvektorok
    P = P(:);   % Reshape-el oszlopvektorra
    P0 = P0(:); % Reshape-el oszlopvektorra
    
    % Ellenőrizzük hogy azonos méretűek
    if length(P) ~= length(P0)
        error('A bemeneti vektorok hosszának egyeznie kell.');
    end

    % Householder tükrözés elve: P-t tükrözzük egy hipersíkra úgy hogy P0-ba kerüljön
    % A hipersík merőleges a v vektorra, ahol v = P - P0 vagy v = P + P0
    % Numerikus stabilitás érdekében a nagyobb normájút választjuk
    v1 = P - P0;  % Első lehetőség
    v2 = P + P0;  % Második lehetőség
    
    % Válasszuk a nagyobb normájú vektort (stabilabb numerikusan)
    if norm(v1) > norm(v2)
        v = v1;  % P - P0 a merőleges irány
    else
        v = v2;  % P + P0 a merőleges irány
    end
    
    % Speciális eset: ha v nulla, akkor P és P0 párhuzamosak
    if norm(v) < eps
        % Ha P = P0, akkor identitás transzformáció
        if norm(P - P0) < eps
            H = eye(length(P));  % H = I
        % Ha P = -P0, akkor negatív identitás
        else
            H = -eye(length(P));  % H = -I
        end
        return;  % Kilepüs
    end

    % Normalizáljuk v-t egység vektor hosszúságúra
    v = v / norm(v);

    % Householder mátrix képlete: H = I - 2*v*v^T
    % Ez egy ortogonális mátrix (H^T = H, H^2 = I)
    % Geometriai értelem: tükrözés a v-re merőleges hipersíkra
    H = eye(length(P)) - 2 * (v * v');
end
