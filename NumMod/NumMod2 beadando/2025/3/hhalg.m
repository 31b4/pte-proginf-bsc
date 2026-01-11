function [Q, R] = hhalg(A)
% hhalg - QR-felbontás Householder transzformációval
%
% PROGRAM LEÍRÁS:
% Ez a függvény QR felbontást végez Householder transzformációk segítségével.
% Sorozatos tükrözésekkel fokozatosan felső háromszög mátrixszá alakítja az A mátrixot.
% Numerikusan stabilabb mint a Gram-Schmidt módszer. Az eredmény: A = Q * R,
% ahol Q ortogonális és R felső háromszög mátrix.
%
% Használat: [Q, R] = hhalg(A)
%
% Bemenő paraméter:
%   A - négyzetes mátrix vagy m x n mátrix, ahol m >= n
%
% Visszatérési értékek:
%   Q - ortogonális mátrix (m x m)
%   R - felső háromszög mátrix (m x n)
%   Tulajdonság: A = Q * R
%
% A megoldás során Householder transzformációkat használunk
%
% Teszteléshez:
%   A = [12 -51 4; 6 167 -68; -4 24 -41];
%   [Q, R] = hhalg(A)
%   % Ellenőrzések:
%   % norm(A - Q*R)  % Kell: ~0
%   % norm(Q'*Q - eye(3))  % Kell: ~0
%   % triu(R) - R  % Kell: ~0 (felső háromszög)

    % Mátrix méretének lekérdezése
    [m, n] = size(A);  % m sorok, n oszlopok

    % Ellenőrizzük hogy m >= n (legalább annyi sor mint oszlop)
    if m < n
        error('A mátrixnak legalább annyi sora kell legyen, mint oszlopa.');
    end

    % Q és R inicializálása
    Q = eye(m);  % Q kezdetben egységmátrix, ezt fogjuk transzformálni
    R = A;       % R kezdetben A, ezt alakítjuk felső háromszögűvé

    % Householder transzformációk alkalmazása minden oszlopra
    % min(m-1, n) -ig mert az utolsó elem már felső háromszögű
    for k = 1:min(m-1, n)
        % Kiveszük a k-adik oszlop k-tól m-ig tartó részét
        % Ezt fogjuk az [||x||, 0, 0, ..., 0]^T alakra transzformálni
        x = R(k:m, k);
        
        % Cél: x-et az első bázis vektor irányába transzformáljuk
        % e1 = [||x||, 0, 0, ..., 0]^T
        e1 = zeros(length(x), 1);
        e1(1) = norm(x);  % Első elem = x normája, többi 0
        
        % Numerikus stabilitás: az előjelet úgy választjuk, hogy
        % elkerüljük a nagy kiküszöbölést (cancellation)
        % Ha x[1] negatív, akkor e1[1]-et is negatívra választjuk
        if x(1) < 0
            e1(1) = -e1(1);
        end
        
        % Householder mátrix számítása: x -> e1 transzformációhoz
        % A Householder vektor: v = x - e1
        v = x - e1;
        
        % Ha v nulla, akkor x már e1 alakú, nincs szükség transzformációra
        if norm(v) < eps
            continue;  % Ugorjuk át ezt az iterációt
        end
        
        % Normalizáljuk v-t egység vektor hosszúságúra
        v = v / norm(v);
        
        % Képezzük a Householder mátrixot: H_k = I - 2*v*v^T
        % Ez csak a k:m részre vonatkozik (length(x) x length(x) méretű)
        H_k = eye(m - k + 1) - 2 * (v * v');
        
        % Ágyazzuk be H_k-t egy teljes méretű mátrixba
        % Az első k-1 sor/oszlop változatlan (egységmátrix)
        H = eye(m);
        H(k:m, k:m) = H_k;  % Behelyettesítjük a k:m részt
        
        % Alkalmazzuk a Householder transzformációt
        R = H * R;      % R-et balról szorozzuk H-val (sorok transzformálása)
        Q = Q * H';     % Q-t jobbról szorozzuk H^T-vel (oszlopok transzformálása)
                        % Q = H1^T * H2^T * ... * Hk^T (kumulatívan)
    end
end
