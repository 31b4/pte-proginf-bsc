def konverter(szam):
    if len(szam) == 9: # ha 9 jegyű a szám akkor a 36-ot nem tartalmazza
        return "(+36) {} {} {}".format(szam[:2], szam[2:5], szam[5:])
    elif len(szam) == 11 and szam.startswith("36"): # ha 11 jegyű és 36-tal kezdődik akkor csak replacelni kell a (+36)-al
        return "(+36) {} {} {}".format(szam[2:4], szam[4:7], szam[7:])
    elif len(szam) == 11 and szam.startswith("06"): # ha 11 jegyű és 06-tal akkor azrt kell ()
        return "(+36) {} {} {}".format(szam[2:4], szam[4:7], szam[7:])
    elif len(szam) == 12 and szam.startswith("+36"): # ha 12 jegyű és +36-tal akkor csak a +36-ot kell kicserélni (+36)-ra
        return "(+36) {} {} {}".format(szam[3:5], szam[5:8], szam[8:])
    else:
        return "Nem megfelelő formátumú telefonszám"

tests = ["302143657", "36301234567", "06307654321", "+36201234567"]

for test in tests:
    print(konverter(test))