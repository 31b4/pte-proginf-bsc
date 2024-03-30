# Challenge 4:

# Írjon egy osztályt ami egy attribútummal rendelkezik, az attribútumnak
# adjunk egy kezdeti értéket.
# Deszkriptor (osztály) segítségével valósítsuk meg azt, hogy az
# attribútum értéke csak akkor legyen módosítható, ha a megadott érték
# nagyobb, mint az addigi érték.
# Kommentek!!!

class MaxValueDescriptor:
    def __init__(self, initial_value=None):
        # Inicializáljuk a deszkriptort
        self.initial_value = initial_value

    def __get__(self, instance, owner):
        # Visszaadja az attribútum aktuális értékét
        return instance.__dict__.get('value', self.initial_value)

    def __set__(self, instance, value):
        # Beállítja az attribútum értékét, ha az új érték nagyobb
        if value > instance.__dict__.get('value', self.initial_value):
            instance.__dict__['value'] = value
        else:
            print("Nagyobb szamot adjon meg.")

class TrickyValue:
    value = MaxValueDescriptor(0)  # Deszkriptor használata az attribútumhoz

# Példa használatra:
obj = TrickyValue()
print(obj.value)  # Alapértelmezett érték: 0

obj.value = 5  # Érték módosítása
print(obj.value)  # Mostmár 5

obj.value = 3  # Érvénytelen módosítás, mivel 3 nem nagyobb, mint 5
print(obj.value)  # Az érték nem változott

obj.value = 10  # Érték módosítása
print(obj.value)  # Mostmár 10