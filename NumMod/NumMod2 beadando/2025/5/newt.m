function gyok = newt(fuggveny, x0, lepes)
% newt - Newton-módszer zérushely keresésre
%
% PROGRAM LEÍRÁS:
% Ez a függvény egy függvény zérushelyét keresi a Newton-módszerrel (Newton-Raphson).
% Az iteráció: x_{n+1} = x_n - f(x_n)/f'(x_n). A deriváltat numerikusan számítja
% különbségi hányados segítségével. Kvadratikus konvergenciájú, nagyon gyors
% ha jó a kezdőérték, de divergens is lehet rossz kezdőértéknél.
%
% Használat: gyok = newt(fuggveny, x0, lepes)
%
% Bemenő paraméterek:
%   fuggveny - függvény karakterláncként (pl. 'x^2-2')
%   x0       - kezdőérték
%   lepes    - iterációk száma
%
% Visszatérési érték:
%   gyok - a zérushely közelítése
%
% A Newton-módszer: x_{n+1} = x_n - f(x_n)/f'(x_n)
% A derivált számításához szimbolikus diff függvényt használunk
%
% Teszteléshez:
%   gyok = newt('x^2-2', 1.5, 10)
%   fprintf('Gyök: %.10f, sqrt(2): %.10f\n', gyok, sqrt(2));
%   % Vagy: gyok = newt('x^3-x-2', 1.5, 10) % gyök ≈ 1.5214

% Függvény létrehozása karakterláncból function handle-ként
f = str2func(['@(x)' fuggveny]);  % Karakterláncból anonim függvény: '@(x)x^2-2'

% Numerikus derivált képzése (centrális diff.-különbség)
epsilon = 1e-8;  % Kis lépésköz a deriváláshoz
df = @(x) (f(x + epsilon) - f(x - epsilon)) / (2 * epsilon);  % f'(x) ≈ (f(x+h)-f(x-h))/(2h)

% Newton-iteráció indítása kezdőértékből
x = x0;  % Aktuális közelítés inicializálása
for k = 1:lepes  % k = 1-től lépés-ig
    fx = f(x);  % Függvényérték kiszámítása: f(x_k)
    dfx = df(x);  % Derivált kiszámítása: f'(x_k)
    
    % Ellenőrizzük, hogy a derivált nem túl kicsi-e (nullaoszthatóság elkerülése)
    if abs(dfx) < 1e-12  % Ha |f'(x)| < 1e-12
        warning('A derivált túl kicsi, iteráció leállítva.');  % Figyelmeztetés
        break;  % Ciklus megszakítása
    end
    
    % Newton-iterációs lépés: x_{k+1} = x_k - f(x_k)/f'(x_k)
    x = x - fx / dfx;  % Új közelítés kiszámítása
end  % for ciklus vége

gyok = x;  % A megközelített gyök értéke (utolsó x)
end