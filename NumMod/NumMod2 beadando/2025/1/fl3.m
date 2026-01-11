function v = fl3(varargin)
% fl3: valós szám gépi alakja
%
% PROGRAM LEÍRÁS:
% Ez a függvény egy valós számot alakít gépi számábrázolássá (bináris vektor).
% A gépi szám lebegőpontos formátumban kerül tárolásra: előjel bit, mantissza
% bitek és karakterisztika. A normalizált alak biztosítja hogy a mantissza 0.5 és 1 között van.
%
% hívás: fl3(t, k1, k2, x)  vagy fl3(x) (ekkor default M(8,-5,5))
%
% Teszteléshez:
%   v1 = fl3(8, -5, 5, 2.0)   % Eredmény: [0, 1, 0, 0, 0, 0, 0, 0, 2]
%   x_check = fl1(v1)          % Ellenőrzés: 2.0
%   
%   v2 = fl3(3.5)              % Default M(8,-5,5) használata
%   v3 = fl3(8, -5, 5, -1.75)  % Negatív szám

% Paraméterek feldolgozása - rugalmas bemenet kezelése
if nargin == 1
    % Ha csak egy paraméter: használjuk a default M(8,-5,5) rendszert
    t = 8; k1=-5; k2=5; x = varargin{1};
elseif nargin == 4
    % Ha négy paraméter: custom gépi számrendszer
    t = varargin{1}; k1 = varargin{2}; k2 = varargin{3}; x = varargin{4};
else
    error('Hibas bemenet');  % Más esetben hiba
end

% Előjel bit meghatározása
if x >= 0
    s = 0;  % Pozitív szám: előjel bit = 0
else
    s = 1;  % Negatív szám: előjel bit = 1
    x = -x; % Továbbiakban abszolút értékkel dolgozunk
end

% Karakterisztika keresése normalizált alakhoz
% Normalizált alak: 0.5 <= mantissza < 1.0
% Ha x = mantissza * 2^k, akkor mantissza = x / 2^k
% log2(x) megadja, hogy x = 2^?, így k = floor(log2(x)) + 1
k = floor(log2(x)) + 1;
% Ellenőrizzük, hogy a karakterisztika a megengedett tartományban van-e
if k < k1 || k > k2
    error('Szám nem ábrázolható');  % Túl kicsi vagy túl nagy
end

% Mantissza normalizálása és bitekre bontása
frac = x / 2^k;  % Normalizált mantissza: 0.5 <= frac < 1.0
m = zeros(1,t-1);  % Mantissza bitek tárolója (előjel nélkül)
% Bináris tört előállítása: ismételt 2-vel szorzással és egész rész levágással
for i = 1:t-1
    frac = frac*2;         % Szorozzuk 2-vel
    m(i) = floor(frac);    % Egész rész lesz az i-edik bit
    frac = frac - m(i);    % Tört rész marad
end

% Végleges gépi szám vektor összeállítása: [előjel, mantissza_bitek, karakterisztika]
v = [s, m, k];
end
