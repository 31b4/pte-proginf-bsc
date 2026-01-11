function x = fl1(v)
% fl1: gépi szám vektorból valós számot számol
%
% PROGRAM LEÍRÁS:
% Ez a függvény egy gépi számábrázolást (bináris vektor) alakít át valós számmá.
% A gépi szám lebegőpontos formátumban van tárolva: mantissza bitekkel és
% karakterisztikával. A mantissza első bitje az előjel (0=pozitív, 1=negatív).
%
% v = [mantissza_bits..., karakterisztika]
% első mantissza bit = előjel (0 pozitív, 1 negatív)
%
% Teszteléshez:
%   v1 = [0, 1, 0, 0, 0, 0, 0, 0, 2];  % 0.5 * 2^2 = 2.0
%   x1 = fl1(v1)  % Eredmény: 2.0
%   
%   v2 = [1, 1, 1, 0, 0, 0, 0, 0, 0];  % -0.75 * 2^0 = -0.75
%   x2 = fl1(v2)  % Eredmény: -0.75

% Vektor szétvágása komponensekre
m = v(1:end-1); % mantissza (előjel + törtrészek) - utolsó elem nélkül
k = v(end);     % karakterisztika - az utolsó elem

% Előjel kiszámítása az első bitből
s = (-1)^m(1);  % ha m(1)=0 akkor +1, ha m(1)=1 akkor -1

% Mantissza törtrész számítása (bináris tört)
% Képlet: 0.b1*2^(-1) + b2*2^(-2) + ... + bn*2^(-n)
frac = 0;
for i = 2:length(m)  % Első bit az előjel, 2-től kezdjük
    % Ellenőrizzük hogy csak 0 vagy 1 lehet
    if m(i) ~= 0 && m(i) ~= 1
        error('Mantissza hibás (nem 0/1).');
    end
    % Hozzáadjuk az i-edik bit értékét: m(i) * 2^(-(i-1))
    frac = frac + m(i)*2^(-(i-1));
end

% Végleges szám: előjel * mantissza * 2^karakterisztika
x = s * frac * 2^k;
end
