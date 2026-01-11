function kvadInt = numint(integrandus, a, b, osztoPontok, metodus)
% numint - Numerikus integrálás klasszikus kvadratúra formákkal
%
% PROGRAM LEÍRÁS:
% Ez a függvény numerikus integrálást végez három klasszikus módszerrel:
% téglalap szabály (középpontos), trapéz szabály és Simpson szabály.
% Az [a,b] intervallumot részintervallumokra osztja és alkalmazza az összetett
% kvadratúra képleteket. A Simpson szabály páros osztópontot igényel.
%
% Használat: kvadInt = numint(integrandus, a, b, osztoPontok, metodus)
%
% Bemenő paraméterek:
%   integrandus  - integrálandó függvény karakterláncként (pl. 'x^2+2*x')
%   a, b         - integrálási intervallum végpontjai
%   osztoPontok  - osztópontok száma (Simpson-nál páros kell legyen)
%   metodus      - kvadratúra formája: 'teglalap', 'trapez', vagy 'simpson'
%
% Visszatérési érték:
%   kvadInt - az integrál közelítő értéke
%
% Támogatott módszerek:
%   - Téglalap szabály (középsőpont)
%   - Trapéz szabály
%   - Simpson szabály
%
% Teszteléshez:
%   I1 = numint('x^2+2*x', 0, 3, 10, 'teglalap')
%   I2 = numint('x^2+2*x', 0, 3, 10, 'trapez')
%   I3 = numint('x^2+2*x', 0, 3, 20, 'simpson')  % páros osztópont!
%   % Pontos: integral(@(x) x.^2+2*x, 0, 3) = 18

% Függvény létrehozása karakterláncból function handle-ként
fuggveny = str2func(['@(x) ' integrandus]);  % pl. 'x^2+2*x' -> @(x) x^2+2*x
h = (b - a) / osztoPontok;  % Részintervallum szélessége: h = (b-a)/n

% Kvadratúra módszer kiválasztása
if strcmpi(metodus, 'teglalap')  % Téglalap szabály (középpontos)
    % Összetétett téglalap formula: ∫ f(x)dx ≈ h * Σ f(xi + h/2)
    kvadInt = 0;  % Integrál kezdőértéke
    for i = 0:osztoPontok-1  % i = 0-tól n-1-ig (n részintervallum)
        xi = a + i*h;  % i-edik részintervallum bal végpontja
        midpoint = xi + h/2;  % Részintervallum középpontja
        kvadInt = kvadInt + h * fuggveny(midpoint);  % Hozzáadjuk h*f(középpont)-ot
    end
    
elseif strcmpi(metodus, 'trapez')
    % Összetett trapéz szabály
    kvadInt = fuggveny(a) + fuggveny(b);
    for i = 1:osztoPontok-1
        xi = a + i*h;
        kvadInt = kvadInt + 2*fuggveny(xi);
    end
    kvadInt = kvadInt * h / 2;
    
elseif strcmpi(metodus, 'simpson')
    % Összetett Simpson szabály
    if mod(osztoPontok, 2) ~= 0
        error('A Simpson formulához páros számú osztópont szükséges!');
    end
    kvadInt = fuggveny(a) + fuggveny(b);
    for i = 1:osztoPontok-1
        xi = a + i*h;
        if mod(i, 2) == 1
            kvadInt = kvadInt + 4*fuggveny(xi);  % Páratlan indexek
        else
            kvadInt = kvadInt + 2*fuggveny(xi);  % Páros indexek
        end
    end
    kvadInt = kvadInt * h / 3;
    
else  % Ismeretlen módszer
    error('Ismeretlen kvadratúraforma! Választható: teglalap, trapez, simpson');  % Hibakeresés
end

% Visszatérési érték: kvadInt tartalmazza az integrál közelítését

end