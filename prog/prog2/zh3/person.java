package elsoo;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

class Person {
    String name;
    double height;
    double weight;
    int age;

    Person(String name, double height, double weight, int age) {
        this.name = name;
        this.height = height;
        this.weight = weight;
        this.age = age;

    }
    // vagy ugy is lehetne hogy a bmi_szamitas es kategorializalas egybol dekralalas utan tortenik meg es nem felhasznalonak kell meghivnia
    // ezzel hatekonyabb lenne hogy nem kell mindig elvegezni a szamitast ujra es ujra
    double TTI_szamitas() {
        return weight / ((height / 100) * (height / 100));
    }

    String kategorializalas(double tti) {
        if (tti < 18)
            return "Sovány";
        else if (tti < 25)
            return "Normalis";
        else if (tti < 30)
            return "Kövér";
        else
            return "Túlsúlyos";
    }
}
