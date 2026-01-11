% Test Gauss-eliminációs programokhoz

disp('--- Teszt: gaussel1 ---');
A = [2 1; 5 7];
b = [11; 13];
x = gaussel1(A, b, true);
disp('Megoldás:');
disp(x);

disp('--- Teszt: gaussel2 (partial pivot) ---');
A = [0 2 1; 1 -2 -3; -1 1 2];
b = [3; -3; -1];
x = gaussel2(A, b, 'partial', true);
disp('Megoldás:');
disp(x);

disp('--- Teszt: gaussel2 (full pivot) ---');
x = gaussel2(A, b, 'full', true);
disp('Megoldás:');
disp(x);

disp('--- Teszt: gaussel3 ---');
A = [4 7; 2 6];
[Ainv, detA, L, U] = gaussel3(A, true);
disp('Determináns:');
disp(detA);
disp('Inverz mátrix:');
disp(Ainv);
