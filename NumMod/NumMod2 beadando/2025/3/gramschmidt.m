function [Q, R] = gramschmidt(A)
% gramschmidt - QR-felbontás Gram-Schmidt ortogonalizációval
%
% PROGRAM LEÍRÁS:
% Ez a függvény QR felbontást végez a klasszikus Gram-Schmidt ortogonalizációs
% módszerrel. A mátrix oszlopait fokozatosan ortogonalizálja és normalizálja,
% létrehozva egy ortogonális Q mátrixot és egy felső háromszög R mátrixot,
% amelyekre A = Q * R.
%
% Használat: [Q, R] = gramschmidt(A)
%
% Bemenő paraméter:
%   A - négyzetes mátrix vagy m x n mátrix, ahol m >= n
%
% Visszatérési értékek:
%   Q - ortogonális mátrix (m x n)
%   R - felső háromszög mátrix (n x n)
%   Tulajdonság: A = Q * R
%
% Hibát dob, ha A oszlopai lineárisan függők
%
% Teszteléshez:
%   A = [1 1 0; 1 0 1; 0 1 1];
%   [Q, R] = gramschmidt(A)
%   % Ellenőrzések:
%   % norm(A - Q*R)    % Kell: ~0
%   % norm(Q'*Q - eye(3))  % Kell: ~0 (ortogonális)

    % Mátrix méretének lekérdezése
    [m, n] = size(A);  % m = sorok, n = oszlopok

    % Ellenőrizzük hogy m >= n (legalább annyi sor mint oszlop)
    if m < n
        error('A mátrixnak legalább annyi sora kell legyen, mint oszlopa.');
    end
    
    % Oszlopok lineáris függetlenségének ellenőrzése
    % QR felbontás csak teljes rangú mátrixra működik
    if rank(A) < n
        error('A mátrix oszlopai lineárisan függők, a QR-felbontás nem megvalósítható.');
    end

    % Q és R mátrixok inicializálása
    Q = zeros(m, n);  % Ortogonális mátrix (m x n)
    R = zeros(n, n);  % Felső háromszög mátrix (n x n)

    % Klasszikus Gram-Schmidt ortogonalizáció
    % Minden oszlopot ortogonalizálunk a már feldolgozott oszlopokra
    for j = 1:n  % Végigmegyünk A minden oszlopán
        v = A(:, j);  # Jelenlegi oszlop másolata
        
        % Ortogonalizáció: kivonjuk v-ből a már meglévő bázisvektorokra való vetítéseket
        for i = 1:j-1  % Minden már feldolgozott oszlop
            % R[i,j] = Q[:,i] skaláris A[:,j] (projekció hossza)
            R(i, j) = Q(:, i)' * A(:, j);
            % Kivonjuk a projekciót: v -= R[i,j] * Q[:,i]
            v = v - R(i, j) * Q(:, i);
        end
        
        % Normalizálás: v-t egység vektor hosszúságúra hozzuk
        R(j, j) = norm(v);  % A normalizálás előtti hossz -> R[j,j]
        % Ha v hossza túl kicsi, numerikus probléma van
        if abs(R(j, j)) < eps
            error('Numerikus instabilitás: az oszlopok közel lineárisan függők.');
        end
        % Q j-edik oszlopa = normalizált v
        Q(:, j) = v / R(j, j);
    end
end