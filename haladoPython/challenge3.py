# Challenge 3:
#-------------
# Hozzunk létre egy osztályt, ami a PÉLDÁNYOSÍTÁSKOR visszaad egy
# n x n-es mátrixot (n legyen az osztály attribútuma), feltöltve
# 0, 1 és 2 értékekkel random.

# Az NEM JÓ megoldás, ha írunk egy metódust az osztályba, ami
# legenerálja a mátrixot!

# A feladatot több szinten is meg lehet oldani,
# ha úgy írjuk meg az osztályt, hogy a belőle származó példány
# önmaga egy iterálható, kétdimenziós adatszerkezet, az plusz egy
# pontot ér, tehát 2 challenge megoldásával ér fel a feladat.

import random

class RandomMatrix:
    def __init__(self, n):
        self.n = n  # Mátrix mérete
        self.current_row = 0  # Aktuális sor indexe

    def __iter__(self):
        # Visszaadjuk az iterátor objektumot (önmagát)
        return self

    def __next__(self):
        if self.current_row < self.n:
            # Generáljuk a következő sort
            row = [random.randint(0, 2) for _ in range(self.n)]
            self.current_row += 1
            return row
        else:
            # Ha már nem kell több sort generálni, adunk egy StopIteration kivételt
            raise StopIteration

# Példányosítás és iteráció a mátrixon
random_matrix = RandomMatrix(5)
for row in random_matrix:
    print(row)
