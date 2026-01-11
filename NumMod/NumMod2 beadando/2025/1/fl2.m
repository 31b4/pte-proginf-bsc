function [X, M_inf, eps0, eps1] = fl2(t, k1, k2)
% fl2: gépi számhalmaz elemeinek ábrázolása a valós számegyenesen
%
% PROGRAM LEÍRÁS:
% Ez a függvény egy adott gépi számrendszer összes lehetséges számát generálja.
% Meghatározza a gépi végtelenséget (legnagyobb ábrázolható szám), valamint
% a minimális és maximális távolságot két szomszédos gépi szám között (gépi epsilon).
%
% t = mantissza hossza (előjel + törtrészek)
% k1, k2 = karakterisztika intervallum
%
% Teszteléshez:
%   [X, M_inf, eps0, eps1] = fl2(4, -2, 2);
%   fprintf('Elemszám: %d\n', length(X));
%   fprintf('M_inf: %.4f\n', M_inf);
%   fprintf('Gépi epsilon (min): %.6f\n', eps0);
%   fprintf('Max lépésköz: %.6f\n', eps1);
%   plot(X, zeros(size(X)), 'o'); % Ábrázolás

% Bemeneti paraméterek ellenőrzése
if ~isscalar(t) || t<=0 || floor(t)~=t
    error('t hibás');  % t-nek pozitív egésznek kell lennie
end
if ~(isscalar(k1) && isscalar(k2) && k1<k2)
    error('k1,k2 hibás');  % k1 < k2 kell, hogy legyen
end

% Gépi számhalmaz összes elemének generálása
X = [];  % Üres tömb inicializálása
for k = k1:k2  % Végigmegyünk az összes karakterisztikán
    for s = 0:1  % Mindkét előjelre (0=pozitív, 1=negatív)
        % Végigmegyünk az összes lehetséges mantissza kombinációra
        % 2^(t-1) lehetőség van (t-1 mert az első bit az előjel)
        for m_bits = 0:(2^(t-1)-1)
            % Konvertáljuk a számot bináris bitvektor
            % bitget(m_bits, i) visszaadja az i-edik bitet
            mvec = [s, bitget(m_bits,t-1:-1:1)];
            % Konvertáljuk gépi számból valós számra fl1 segítségével
            val = fl1([mvec, k]);
            % Hozzáadjuk az értéket a halmazhoz
            X(end+1) = val;
        end
    end
end

% Csak az egyedi elemeket tartjuk meg (ismétlődések eltávolítása)
X = unique(X);
% Legnagyobb abszolút érték (gépi végtelenség)
M_inf = max(abs(X));
% Legkisebb távolság két szomszédos elem között (minimális gépi epsilon)
eps0 = min(diff(sort(X)));
% Legnagyobb távolság két szomszédos elem között (maximális lépésköz)
eps1 = max(diff(sort(X)));
end
