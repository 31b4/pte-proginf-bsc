# Tesztelési Útmutató - Testing Guide

## Áttekintés

Mind a 31 MATLAB fájl tartalmaz magyar nyelvű tesztelési útmutatót a fejléckommentekben.
Minden fájl "Teszteléshez:" felirattal ellátott példakódokat tartalmaz.

All 31 MATLAB files contain Hungarian testing instructions in their header comments.
Each file includes example code under the "Teszteléshez:" (For testing:) label.

---

## Folder 1: Számábrázolás - Machine Numbers

### fl1.m - Lebegőpontos számábrázolás
```matlab
fl1(7, 4, 3)  % 10-es számrendszer
fl1(2, 5, 3)  % 2-es számrendszer
```

### fl2.m - Gépszámok intervalluma
```matlab
[xmin, xmax] = fl2(10, 4, 3)
[xmin, xmax] = fl2(2, 5, 3)
```

### fl3.m - Karakterisztika kiszámítása
```matlab
t = fl3(10, 4, 3, 125.7)
t = fl3(2, 5, 3, 0.125)
```

### fl4.m - Gépi összeadás
```matlab
result = fl4(2, 5, 3, 13, 6)
```

---

## Folder 2: Gauss-elimináció - Gaussian Elimination

### gaussel1.m - Alap Gauss-elimináció
```matlab
A = [2 1 -1; -3 -1 2; -2 1 2]; b = [8; -11; -3];
x = gaussel1(A, b)
% Ellenőrzés: norm(A*x - b) < eps
```

### gaussel2.m - Pivotálással
```matlab
A = [2 1 -1; -3 -1 2; -2 1 2]; b = [8; -11; -3];
x = gaussel2(A, b)
```

### gaussel3.m - LU faktorizáció
```matlab
A = [2 1 -1; -3 -1 2; -2 1 2];
[L, U] = gaussel3(A)
% Ellenőrzés: norm(L*U - A) < eps
```

---

## Folder 3: QR felbontás - QR Decomposition

### gramschmidt.m - Gram-Schmidt ortogonalizáció
```matlab
A = [1 1 0; 1 0 1; 0 1 1];
[Q, R] = gramschmidt(A)
% Ellenőrzés: Q'*Q ≈ I, Q*R ≈ A
```

### householder.m - Householder transzformáció
```matlab
v = [1; 2; 3];
[H, u] = householder(v)
% H*v első elem kivételével zérus
```

### hhalg.m - Householder QR algoritmus
```matlab
A = magic(4);
[Q, R] = hhalg(A)
% Ellenőrzés: Q'*Q ≈ I, Q*R ≈ A
```

### hhgraph.m - Householder tükrözés grafikus szemléltetés
```matlab
hhgraph([3; 4])  % Grafikus demo
```

---

## Folder 4: Iteratív módszerek - Iterative Methods

### jacobi.m - Jacobi iteráció
```matlab
A = [4 -1 0; -1 4 -1; 0 -1 4]; b = [1; 2; 3];
opts = struct('maxiter', 100, 'tol', 1e-8);
[x, info] = jacobi(A, b, opts)
fprintf('Iterációk: %d, Spektrálsugár: %.4f\n', ...
        info.iterations, info.spectralRadius);
```

### gaussseid.m - Gauss-Seidel iteráció
```matlab
A = [4 -1 0; -1 4 -1; 0 -1 4]; b = [1; 2; 3];
opts = struct('maxiter', 100, 'tol', 1e-8);
[x, info] = gaussseid(A, b, opts)
fprintf('Iterációk: %d\n', info.iterations);
```

### iteracio.m - Módszerek összehasonlítása
```matlab
results = iteracio(10, 1e-8, 200, true);
fprintf('Jacobi iterációk: %d\n', results.jacobi.info.iterations);
fprintf('GS iterációk: %d\n', results.gaussseid.info.iterations);
```

### jomega.m - SOR módszer optimális omega
```matlab
A = [4 -1 0; -1 4 -1; 0 -1 4];
data = jomega(A, [0, 2], 400, true)
fprintf('Optimális omega: %.4f\n', data.optimalOmega);
```

---

## Folder 5: Nemlineáris egyenletek - Nonlinear Equations

### intfel.m - Intervallumfelezés (Bisection)
```matlab
f = @(x) x.^2 - 2;  % sqrt(2) keresése
gyok = intfel(f, 1, 2, 1e-8)
% Vagy: gyok = intfel(f, 1, 2, 20)  % 20 lépés
```

### hurm.m - Húrmódszer (Regula Falsi)
```matlab
gyok = hurm(@(x) x.^2-2, 1, 2, 10, 1)  % ábrával
% Vagy: hurm(@(x) x.^2-2, 1, 2, 15)  % ábra nélkül
```

### newt.m - Newton-módszer
```matlab
gyok = newt('x^2-2', 1.5, 10)
% Vagy: gyok = newt('x^3-x-2', 1.5, 10)
```

---

## Folder 6: Interpoláció - Interpolation

### newtonip.m - Newton-interpoláció
```matlab
ntmeg = newtonip([1 4 9], [2 3 4], 1)  % f(x) = sqrt(x) + 1
% Vagy: ntmeg = newtonip([0 1 2], [1 2 5], 0)  % ábra nélkül
```

### bsplinedraw.m - B-Spline megjelenítés
```matlab
bsplinedraw([8 4 6 1 2])
% Vagy: bsplinedraw(1:10)  % első 10 B-Spline függvény
```

### lnmaprox.m - Legkisebb négyzetek approximáció
```matlab
approxPolinom = lnmaprox(2, [-2,-1,0,1,2], [-4, -2, 1, 2, 4], 1)
```

---

## Folder 7: Általánosított inverz és integrálás

### geninv.m - Moore-Penrose inverz
```matlab
A = [1 0 2 -1; 2 1 5 0; 3 0 6 -3];
Aplus = geninv(A)
% Ellenőrzés: A*Aplus*A ≈ A
```

### numint.m - Numerikus integrálás
```matlab
I1 = numint('x^2+2*x', 0, 3, 10, 'teglalap')
I2 = numint('x^2+2*x', 0, 3, 10, 'trapez')
I3 = numint('x^2+2*x', 0, 3, 20, 'simpson')  % páros osztópont!
% Pontos: integral(@(x) x.^2+2*x, 0, 3) = 18
```

---

## Folder 8: Affin transzformációk - Affine Transformations

### affin1.m - Origót fixáló affin transzformáció
```matlab
T = affin1([1,2],[3,4])  % eredmény: [1 3; 2 4]
% Ellenőrzés: T * [1;0] = [1;2], T * [0;1] = [3;4]
% Vagy grafikus mód: affin1()
```

### affin2.m - Tetszőleges affin transzformáció
```matlab
a=[0,0]; b=[1,0]; c=[0,1];
A=[10,10]; B=[20,10]; C=[10,20];
T = affin2(a,b,c,A,B,C)
% Ellenőrzés: T*[a;1] = [A;1]
% Vagy grafikus mód: affin2()
```

---

## Általános tesztelési megjegyzések - General Testing Notes

### Függőségek
- MATLAB R2016b vagy újabb (ajánlott R2020a+)
- Octave 5.0+ (a legtöbb fájl kompatibilis)
- Symbolic Math Toolbox (newt.m, newtonip.m használja)

### Hibaellenőrzés
Minden függvény tartalmaz:
- Bemeneti paraméterek validálását
- Hibás adatok esetén értelmes hibaüzeneteket
- Konvergencia ellenőrzést (iteratív módszereknél)

### Grafikus megjelenítés
Sok függvény támogat grafikus kimenetet:
- `graf = 1` vagy `grafikon = 1` paraméterrel
- Vagy paraméter nélküli hívással interaktív módban

### Teljesítmény
- Kis tesztmátrixok: n ≤ 10
- Közepes problémák: n ≤ 100
- Nagy problémák: n ≤ 1000 (ritkás mátrixok ajánlottak)

---

*Dokumentáció készítve: 2024*
*Minden fájl tesztelt és dokumentált*
