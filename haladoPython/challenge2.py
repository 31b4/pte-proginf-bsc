# Challenge 2:
# Valósítsuk meg a prímszámok előállítását iterátor osztállyal
# és generátorral. Kommenteljük a kódunkat!

#------------------------------------ ITERÁTOR ------------------------------------
class PrimeIterator:
    def __init__(self, max_value):
        # Inicializálás: maximális és kezdő érték beállítása
        self.max_value = max_value
        self.current = 1

    def __iter__(self):
        # Az iterátor visszaadja önmagát, mint iterátor objektumot
        return self

    def __next__(self):
        self.current += 1
        while True:
            if self.current >= self.max_value:
                # Ha elértük a maximális értéket, kilépés
                raise StopIteration
            else:
                # Ellenőrizze, hogy a következő szám prím-e
                if self.is_prime(self.current):
                    # Ha prím, adja vissza és növelje a számlálót
                    prime = self.current
                    self.current += 1
                    return prime
                else:
                    # Ha nem prím, növelje a számlálót
                    self.current += 1

    # Prím ellenőrzés
    def is_prime(self, n):
        if n == 2 or n == 3: return True # 2 és 3 prím
        if n % 2 == 0 or n < 2: return False # páros számok és negatív számok nem prímek
        for i in range(3, int(n ** 0.5) + 1, 2):  # only odd numbers
            if n % i == 0:
                return False
        return True

# Prímszámok generálása 20-ig
print('Iterátor')
prime_iter = PrimeIterator(20)
for prime in prime_iter:
    print(prime)
#------------------------------------ GENERÁTOR ------------------------------------

def prime_generator(max_value):
    current = 1
    while current < max_value:
        current += 1
        if is_prime(current):
            yield current

# Prím ellenőrzés
def is_prime(n):
    if n == 2 or n == 3: return True  # 2 és 3 prím
    if n % 2 == 0 or n < 2: return False  # páros számok és negatív számok nem prímek
    for i in range(3, int(n ** 0.5) + 1, 2):  # only odd numbers
        if n % i == 0:
            return False
    return True

# Prímszámok generálása 20-ig
print('Generátor')
for prime in prime_generator(20):
    print(prime)
