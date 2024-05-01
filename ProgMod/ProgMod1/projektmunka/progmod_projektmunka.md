# A* Algoritmus

## Miert A*?
- **Hatékonyság**
- **Optimalitás**
- **Könnyen testreszabható**

## Hogyan működik az algoritmus?
1. Kezdetben a prioritási sorba (`heap`) beleteszi a kezdőpontot.
2. Amíg a prioritási sor nem üres: (`while (!heap.isEmpty())`)
    - Kivesz egy pontot a prioritási sorból, és megvizsgálja, hogy ez a pont-e a cél. 
    `if (current.x == END[0] && current.y == END[1])`
    - Ha igen, az algoritmus véget ér, és az útvonal megtalálásra került.
    - Ha nem, a pontot megjelöli bejártként, majd megvizsgálja a pont szomszédait.
    - A szomszédokat hozzáadja a prioritási sorhoz, ha még nem voltak bejárva, és kiszámítja a szomszédoktól a célhoz várható költséget, amit az adott ponttól való távolság és egy heurisztikus becslés alapján határoz meg.
3. Ha a célponthoz vezető útvonal nem található a bejárt pontok elfogyása miatt, akkor a keresés eredménye az, hogy a cél nem érhető el a kezdőpontból.

## Függvények és változók:


