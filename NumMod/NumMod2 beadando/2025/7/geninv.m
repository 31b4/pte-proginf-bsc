function altalanosInverz = geninv(A)
% geninv - Mátrix általánosított inverzének kiszámítása
%
% PROGRAM LEÍRÁS:
% Ez a függvény kiszámítja egy tetszőleges mátrix általánosított (Moore-Penrose)
% inverzét. A módszer rangfaktorizciót használ, különböző képletekkel a teljesrangú
% négyzetes, túlhatározott, alulhatározott és ranghibás mátrixokra. Az A+ inverz
% teljesíti az A*A+*A = A és A+*A*A+ = A+ tulajdonságokat.
%
% Használat: altalanosInverz = geninv(A)
%
% Bemenő paraméter:
%   A - tetszőleges mátrix (m x n)
%
% Visszatérési érték:
%   altalanosInverz - A általánosított inverze (A+), Moore-Penrose inverz
%
% A módszer rangfaktorizciót használ:
%   - Teljesrangú négyzetes mátrix: A+ = A^(-1)
%   - Túlhatározott (m > n, teljesrang): A+ = (A'A)^(-1)A'
%   - Alulhatározott (n > m, teljesrang): A+ = A'(AA')^(-1)
%   - Rang hiányos: beépített pinv függvény
%
% Teszteléshez: geninv([1 0 2 -1; 2 1 5 0; 3 0 6 -3])
% A mátrix rangának ellenőrzése: teljesrangú-e?
if (rank(A) == min(size(A)))  % Ha rank(A) = min(m,n), teljesrangú
    % Négyzetes mátrix esete (m = n)
    if size(A,1) == size(A,2)  % Ha a sorok és oszlopok száma megegyezik
        altalanosInverz = inv(A);  % Hagyományos inverz: A^(-1)
    elseif size(A,1) > size(A,2)  % Túlhatározott rendszer: több sor, mint oszlop (m > n)
        altalanosInverz = (A'*A) \ A';  % Baloldali inverz: (A'A)^(-1)A'
    else  % Alulhatározott rendszer: több oszlop, mint sor (n > m)
        altalanosInverz = A'/(A*A');  % Jobboldali inverz: A'(AA')^(-1)
    end
else  % Rang hiányos mátrix esete
    altalanosInverz = pinv(A);  % Moore-Penrose pszeudoinverz (MATLAB beépített)
end

end