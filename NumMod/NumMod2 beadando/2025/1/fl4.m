function v_sum = fl4(v1, v2)
% fl4: gépi összeadás két vektorral (ugyanazon halmazból)
%
% PROGRAM LEÍRÁS:
% Ez a függvény két gépi számot ad össze gépi szinten, szimulálva a számítógép
% lebegőpontos összeadását. A művelet során közös karakterisztikára hozza a számokat,
% végrehajtja az előjeles összeadást, majd normalizálja az eredményt.
%
% A műveleteket gépi szinten végezzük, nem valós számokon!
%
% Teszteléshez:
%   v1 = fl3(8, -5, 5, 2.0);   % 2.0 gépi alakban
%   v2 = fl3(8, -5, 5, 1.5);   % 1.5 gépi alakban
%   v_sum = fl4(v1, v2);       % Gépi összeadás
%   x_sum = fl1(v_sum)         % Eredmény: 3.5
%   
%   % Negatív számok tesztje:
%   v3 = fl3(8, -5, 5, -1.0);
%   v_neg = fl4(v1, v3);       % 2.0 + (-1.0) = 1.0

% Ellenőrizzük hogy ugyanabból a gépi számhalmazból vannak-e
if length(v1) ~= length(v2)
    error('Nem azonos halmazból');  % Különböző t vagy k tartomány
end

% Komponensek kinyerése a vektorokból
t = length(v1) - 1;  % mantissza hossza (előjellel együtt)
k1 = v1(end); k2 = v2(end);  % Karakterisztikák
m1_orig = v1(2:end-1); s1 = v1(1);  % v1 mantissza és előjel
m2_orig = v2(2:end-1); s2 = v2(1);  % v2 mantissza és előjel

% Közös karakterisztikára hozás (nagyobbikat választjuk)
% Ez szükséges az összeadáshoz - mint fixpontos számoknál az igazítás
if k1 > k2
    % Ha v1 karakterisztikája nagyobb
    shift = k1 - k2;  % Ennyit kell v2-t jobbra shiftolni
    % Jobbra shift = nullák beszúrása elől, végéről levágás
    m2 = [zeros(1, shift), m2_orig(1:end-shift)];
    m1 = m1_orig;  % v1 változatlan marad
    k = k1;  % Közös karakterisztika = nagyobbik
elseif k2 > k1
    % Ha v2 karakterisztikája nagyobb
    shift = k2 - k1;  % Ennyit kell v1-et jobbra shiftolni
    m1 = [zeros(1, shift), m1_orig(1:end-shift)];
    m2 = m2_orig;  % v2 változatlan marad
    k = k2;  % Közös karakterisztika = nagyobbik
else
    % Ha egyenlő karakterisztikák - nincs szükség shiftre
    m1 = m1_orig;
    m2 = m2_orig;
    k = k1;  % Bármelyik jó, mert egyenlők
end

% Mantissza értékek decimális alakra konvertálása
% sum(m .* 2.^(-1:-1:-n)) = m1*2^(-1) + m2*2^(-2) + ... + mn*2^(-n)
frac1 = sum(m1 .* 2.^(-(1:length(m1))));
frac2 = sum(m2 .* 2.^(-(1:length(m2))));

% Előjeles összeadás - négy eset van
if s1 == 0 && s2 == 0
    % 1. eset: Mindkettő pozitív (+a) + (+b) = +(a+b)
    frac_sum = frac1 + frac2;
    s_sum = 0;  % Eredmény pozitív
elseif s1 == 1 && s2 == 1
    % 2. eset: Mindkettő negatív (-a) + (-b) = -(a+b)
    frac_sum = frac1 + frac2;
    s_sum = 1;  % Eredmény negatív
elseif s1 == 0 && s2 == 1
    % 3. eset: v1 pozitív, v2 negatív (+a) + (-b) = +(a-b) vagy -(b-a)
    if frac1 >= frac2
        frac_sum = frac1 - frac2;  % a >= b esetén pozitív
        s_sum = 0;
    else
        frac_sum = frac2 - frac1;  % b > a esetén negatív
        s_sum = 1;
    end
else  % s1 == 1 && s2 == 0
    % 4. eset: v1 negatív, v2 pozitív (-a) + (+b) = +(b-a) vagy -(a-b)
    if frac2 >= frac1
        frac_sum = frac2 - frac1;  % b >= a esetén pozitív
        s_sum = 0;
    else
        frac_sum = frac1 - frac2;  % a > b esetén negatív
        s_sum = 1;
    end
end

% Speciális eset: ha az eredmény pontosan nulla
if frac_sum == 0
    v_sum = zeros(size(v1));  % Nulla vektor
    return
end

% Normalizálás: frac_sum-ot [0.5, 1) tartományba hozzuk
% Két irányban is szükség lehet rá

% Ha túl nagy (>= 1.0), akkor osztjuk kettővel és növeljük a karakterisztikát
while frac_sum >= 1
    frac_sum = frac_sum / 2;  % Jobbra shift a mantisszában
    k = k + 1;                % Kompenzáljuk a karakterisztika növelésével
end

% Ha túl kicsi (< 0.5), akkor szorozzuk kettővel és csökkentjük a karakterisztikát
while frac_sum < 0.5 && frac_sum > 0
    frac_sum = frac_sum * 2;  % Balra shift a mantisszában
    k = k - 1;                 % Kompenzáljuk a karakterisztika csökkentésével
end

% Mantissza bitek előállítása a normalizált törtből
m_sum = zeros(1, t-1);  % Mantissza bitek tárolója
frac = frac_sum;        % Dolgozunk egy másolattal
% Ugyanaz az algoritmus mint fl3-ban:
for i = 1:t-1
    frac = frac * 2;         % Szorozzuk 2-vel
    m_sum(i) = floor(frac);  % Egész rész lesz az i-edik bit (0 vagy 1)
    frac = frac - m_sum(i);  % Maradék tört rész
end

% Végleges gépi szám összeállítása: [előjel, mantissza_bitek, karakterisztika]
v_sum = [s_sum, m_sum, k];
end
