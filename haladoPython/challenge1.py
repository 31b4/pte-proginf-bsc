# Challenge 1:
# Írjunk egy logger dekorátor függvényt, ami logolja, hogy mely függvény,
# melyik modulból, mikor lett meghívva. A logolt információkat írjuk ki
# egy külső log fájlba.
# Kommenteljük a programunkat!

import functools
import logging
import datetime

# konfiguráljuk a logo file-t
logging.basicConfig(filename='fnCalls.log', level=logging.INFO)

# dekorator, ami logolja a függvény meghívásokat
def logger(func):
    @functools.wraps(func)
    def log(*args, **kwargs):
        # logoljuk a függvény nevét, a modul nevét és a meghívás időpontját
        logging.info(f' called function: {func.__name__} from module: {func.__module__} at time: {datetime.datetime.now()}')
        return func(*args, **kwargs)
    return log

# használjuk a dekorátort a függvényeken, ahol logolni szeretnénk
@logger
def fn1():
    pass

@logger
def fn2():
    pass

# Teszteljük a logolást
fn1()
fn2()

