% hhgraph - Householder transzformáció grafikus megjelenítése 2D-ben
%
% PROGRAM LEÍRÁS:
% Ez a szkript interaktívan bekéri a felhasználótól egy eredeti pont és egy célpont
% koordinátáit, kiszámítja a megfelelő Householder transzformációt, majd grafikusan
% megjeleníti a tükrözési hipersíkot (2D-ben egyenes), a merőleges irányt, valamint
% az eredeti és transzformált pontokat. Segít megérteni a Householder tükrözés geometriáját.
%
% A program bekéri az adatokat, megjeleníti a tükrözési hipersíkot,
% és ábrázolja a pont képét
%
% Teszteléshez:
%   hhgraph
%   % A program interaktívan kéri:
%   % - Eredeti pont: x = 1, y = 2
%   % - Cél pont: x = 2, y = 1
%   % Grafikon megjeleníti a tükrözést

% Eredeti pont bekérése a felhasználótól
prompt = 'Kérem adja meg az eredeti pont x-koordinátáját: ';  % Promptszöveg
x1 = input(prompt);  % X koordináta beolvasása
prompt = 'Kérem adja meg az eredeti pont y-koordinátáját: ';  % Promptszöveg
y1 = input(prompt);  % Y koordináta beolvasása

% Képpont (cél pont) bekérése a felhasználótól
prompt = 'Kérem adja meg a kép pont x-koordinátáját: ';  % Promptszöveg
x2 = input(prompt);  % X koordináta beolvasása
prompt = 'Kérem adja meg a kép pont y-koordinátáját: ';  % Promptszöveg
y2 = input(prompt);  % Y koordináta beolvasása

% Vektorok összeállítása a beolvasott koordinátákból
P = [x1; y1];    % Eredeti pont oszlopvektorként: [x1; y1]
P0 = [x2; y2];   % Cél pont oszlopvektorként: [x2; y2]

% Householder transzformáció mátrixának kiszámítása
% A householder függvény visszaadja az olyan H mátrixot, amelyre H*P = P0
H = householder(P, P0);

% Tükrözött pont kiszámítása (ellenőrzésképpen)
% Elméletileg H*P = P0 kell legyen
transformed_point = H * P;

% Eredmények kiírása a konzolra (ellenőrzésképpen)
fprintf('Eredeti pont: [%.3f, %.3f]\n', P(1), P(2));  % P koordinátái
fprintf('Cél pont: [%.3f, %.3f]\n', P0(1), P0(2));  % P0 koordinátái
fprintf('Transzformált pont: [%.3f, %.3f]\n', transformed_point(1), transformed_point(2));  % H*P eredménye
fprintf('Hiba: %.6f\n', norm(transformed_point - P0));  % ||H*P - P0|| hiba

% Grafikus ábrázolás 2D-ben
figure;  % Új ábra ablak nyitása
hold on;  % Többszörös rajzolás engedélyezése (sorok nem törlődnek)
axis equal;  % Egyenlő skálázás x és y tengelyeken (arányos ábra)
grid on;  % Rács megjelenítése

% A tükrözési hipersík megjelenítése
v = P - P0;  % Különbség vektor: P és P0 között
if norm(v) > eps  % Ha v nem nulla vektor (P ≠ P0)
    v = v / norm(v);  % Normalizáljuk v-t egységvektorra
    % A tükrözési hipersík (2D-ben egyenes) a P és P0 felezőpontján megy át
    % és merőleges a v vektorra
    midpoint = (P + P0) / 2;  % Felezőpont számítása: (P+P0)/2
    
    % Hipersík ábrázolása (2D-ben ez egy egyenes)
    % Az egyenes irányvektora merőleges v-re, ezt úgy kapjuk hogy
    % v = [v1; v2] esetén merőleges vektor: [-v2; v1] (90° elforgatás)
    t_vals = linspace(-5, 5, 100);  % Paraméter értékek az egyeneshez (-5-től 5-ig)
    line_dir = [-v(2); v(1)];  % Merőleges irányvektor
    line_x = midpoint(1) + t_vals * line_dir(1);  % Egyenes x koordinátái
    line_y = midpoint(2) + t_vals * line_dir(2);  % Egyenes y koordinátái
    plot(line_x, line_y, 'b--', 'LineWidth', 1.5, 'DisplayName', 'Tükrözési hipersík');  % Szaggatott kék vonal
    
    % Merőleges vektor (v) megjelenítése nyílként
    quiver(midpoint(1), midpoint(2), v(1), v(2), 0.5, 'b', 'LineWidth', 2, ...
        'DisplayName', 'Merőleges irány', 'MaxHeadSize', 0.5);  % Kék nyíl a felezőpontból
end

% Eredeti pont megjelenítése piros teli körrel
scatter(P(1), P(2), 100, 'r', 'filled', 'DisplayName', 'Eredeti pont (P)');

% Cél/kép pont megjelenítése zöld teli körrel
scatter(P0(1), P0(2), 100, 'g', 'filled', 'DisplayName', 'Cél pont (P0)');

% Transzformált pont (ellenőrzés) megjelenítése fekete X-szel
scatter(transformed_point(1), transformed_point(2), 100, 'k', 'x', ...
    'LineWidth', 2, 'DisplayName', 'H*P (ellenőrzés)');  % Ennek P0-val kell egybeesnie

% Összekötő vonal P és P0 között (fekete pontozott vonal)
plot([P(1), P0(1)], [P(2), P0(2)], 'k:', 'LineWidth', 1);

% Ábra címkézése és beállítások
title('Householder Transzformáció - 2D Tükrözés');  % Cím
xlabel('X tengely');  % X tengely felirat
ylabel('Y tengely');  % Y tengely felirat
legend('Location', 'best');  % Jelmagyarázat (legjobb helyre)
hold off;  % Többszörös rajzolás tiltása
