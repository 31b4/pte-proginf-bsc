# A* Algoritmus

## Miert A*?
- **Hatékony**
- **Optimalis**
- **Könnyen testreszabható**

## Hogyan működik az algoritmus?
1. Kezdetben a prioritási sorba (`heap`) beleteszi a kezdőpontot.
https://github.com/31b4/pte-proginf-bsc/blob/76932ec6784124dd95610aa2fe0f9126e4b3fe49/ProgMod/ProgMod1/projektmunka/Matrix.java#L43-L44
2. Amíg a prioritási sor nem üres:
    - Kivesz egy pontot a prioritási sorból, és megvizsgálja, hogy ez a pont-e a cél. 
    https://github.com/31b4/pte-proginf-bsc/blob/76932ec6784124dd95610aa2fe0f9126e4b3fe49/ProgMod/ProgMod1/projektmunka/Matrix.java#L46-L49
    - Ha igen, az algoritmus véget ér, és az útvonal megtalálásra került.
    https://github.com/31b4/pte-proginf-bsc/blob/76932ec6784124dd95610aa2fe0f9126e4b3fe49/ProgMod/ProgMod1/projektmunka/Matrix.java#L50-L55
    - Ha nem, a pontot megjelöli bejártként, majd megvizsgálja a pont szomszédait.
    - A szomszédokat hozzáadja a prioritási sorhoz, ha még nem voltak bejárva, és kiszámítja a szomszédoktól a célhoz várható költséget, amit az adott ponttól való távolság és egy heurisztikus becslés alapján határoz meg.
    https://github.com/31b4/pte-proginf-bsc/blob/76932ec6784124dd95610aa2fe0f9126e4b3fe49/ProgMod/ProgMod1/projektmunka/Matrix.java#L58-L72
3. Ha a célponthoz vezető útvonal nem található a bejárt pontok elfogyása miatt, akkor a keresés eredménye az, hogy a cél nem érhető el a kezdőpontból.

## Osztályok, Függvények és változók:

#### Osztályok:
- Fő osztályunk a `Matrix`:
    1. Dekrarálva vannak alapból a mátrixok (`matrix3x3`,`matrix4x4`,`matrix5x5`)
    1. Maga az algoritmus (`public static void astar(...)`)
    2. A tesztelés (`public static void main(String[] args)`)
    3. Illetve gyerek osztálya (` public Node(...)`) ami szükséges az algoritmushoz
- `Node` osztály:
    - Az `x`, `y`, `cost` és `path` adattagok tárolják a csomópont adatait

#### Függvények:
- `astar`:
    1. **Attribútumai**: 
        - `int[][] matrix`: A mátrix, amelyen az algoritmus futtatásra kerül.
        - `int N`: A mátrix sorainak száma.
        - `int M`: A mátrix oszlopainak száma.
        - `int[] START`: A kezdőpont koordinátái.
        - `int[] END`: A végpont koordinátái.
    2. **Lépések**:
        - `heap`: Prioritási sor a csomópontok rendezésére a költség alapján.
        - `visited`: Halmaz a látogatott csomópontok nyilvántartására.
        - `startPath`: Kezdő útvonal, amely csak a kezdőpontot tartalmazza.
        - `startNode`: A kezdő csomópont, amely tartalmazza a kezdőpont adatait és az ehhez tartozó költséget.
- `main`:
    - `Matrix matrix = new Matrix();` egy Matrix tipusu valtozoval elerhetjuk mind a 3 matrixkot (`matrix3x3`,`matrix4x4`,`matrix5x5`)
    - ahoz hogy teszteljuk ` int[] START = {0, 0};
        int[] END = {2, 2};` megadasara is szukseg van illetve a matrix mereteire (`N`, `M`) 
        **Például:**
        https://github.com/31b4/pte-proginf-bsc/blob/76932ec6784124dd95610aa2fe0f9126e4b3fe49/ProgMod/ProgMod1/projektmunka/Matrix.java#L78-L81


## Források:

- https://chat.openai.com/share/8728d606-a320-4b91-9a4d-3afd7043eeb4
- https://chat.openai.com/share/1e67c17d-2a5f-4ed5-8d68-bb3a91dd48a6
- https://chat.openai.com/share/a6a1a992-db64-4c5b-82a9-5e37d01995d8