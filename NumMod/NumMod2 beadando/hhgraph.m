% Felhasználói input: bekérés az eredeti pont és a hipersík irányvektorának megadásához
prompt = 'Kérem adja meg az eredeti pont x-koordinátáját: ';
x1 = input(prompt);
prompt = 'Kérem adja meg az eredeti pont y-koordinátáját: ';
y1 = input(prompt);

prompt = 'Kérem adja meg a hipersík irányvektorának x-koordinátáját: ';
x2 = input(prompt);
prompt = 'Kérem adja meg a hipersík irányvektorának y-koordinátáját: ';
y2 = input(prompt);

% Definiáljuk a pontokat és hívjuk meg a Householder-transzformációt
P = [x1, y1];
P0 = [x2, y2];
H = householder(P, P0);
transformed_point = H * P';

% Grafikus ábrázolás
figure;

% Hipersík ábrázolása
quiver(0, 0, P0(1), P0(2), 'b', 'LineWidth', 2);
hold on;

% Eredeti pont ábrázolása
scatter(P(1), P(2), 'r', 'filled');

% Tükrözött pont ábrázolása
scatter(transformed_point(1), transformed_point(2), 'g', 'filled');

% Ábra beállításai
axis equal;
title('Hipersík és Tükrözött Pont');
xlabel('X tengely');
ylabel('Y tengely');
legend('Hipersík', 'Eredeti Pont', 'Tükrözött Pont');
