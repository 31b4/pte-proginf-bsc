package elsoo;

import java.io.IOException;
import java.text.DecimalFormat;
import java.util.List;

public class Menu {
    DecimalFormat df = new DecimalFormat("#.##");

    private List<Person> people;

    public Menu(List<Person> people) {
        this.people = people;
    }

    public void legnagyobbLegkisebbTesttomeggel() {
        Person legnagyobb = null;
        Person legkisebb = null;
        double maxWeight = Double.MIN_VALUE;
        double minWeight = Double.MAX_VALUE;

        for (Person person : people) {
            if (person.weight > maxWeight) {
                maxWeight = person.weight;
                legnagyobb = person;
            }
            if (person.weight < minWeight) {
                minWeight = person.weight;
                legkisebb = person;
            }
        }

        if (legnagyobb != null && legkisebb != null) {
            System.out.println("Legnagyobb testtömegű személy: " + legnagyobb.name + ", " + legnagyobb.weight + " kg");
            System.out.println("Legkisebb testtömegű személy: " + legkisebb.name + ", " + legkisebb.weight + " kg");
        } else {
            System.out.println("Nincs elegendő adat a meghatározáshoz.");
        }
    }

    public void legmagasabbLegalacsonyabb() {
        Person legmagasabb = null;
        Person legalacsonyabb = null;
        double maxHeight = Double.MIN_VALUE;
        double minHeight = Double.MAX_VALUE;

        for (Person person : people) {
            if (person.height > maxHeight) {
                maxHeight = person.height;
                legmagasabb = person;
            }
            if (person.height < minHeight) {
                minHeight = person.height;
                legalacsonyabb = person;
            }
        }

        if (legmagasabb != null && legalacsonyabb != null) {
            System.out.println("Legmagasabb személy: " + legmagasabb.name + ", " + legmagasabb.height + " cm");
            System.out.println("Legalacsonyabb személy: " + legalacsonyabb.name + ", " + legalacsonyabb.height + " cm");
        } else {
            System.out.println("Nincs elegendő adat a meghatározáshoz.");
        }
    }

    public void atlagEletkorFelettiSzemelyek() {
        int sumAge = 0;
        int count = 0;

        for (Person person : people) {
            sumAge += person.age;
            count++;
        }
        if (count == 0) {
            System.out.println("Nincs elegendő adat a meghatározáshoz.");
            return;
        }
        double avgAge = (double) sumAge / count;
        System.out.println("Átlagéletkor: " + avgAge);

        for (Person person : people) {
            if (person.age > avgAge) {
                double tti = Double.parseDouble(df.format(person.TTI_szamitas()));
                System.out.println(person.name + " - Életkor: " + person.age + ", TTI: " + tti + ", TI kategória: " + person.kategorializalas(tti));
            }
        }
    }

    public void sovanyKategoria() {
        boolean vanSovany = false;
        System.out.println("Sovány kategóriába tartozó személyek:");
        for (Person person : people) {
            double tti = person.TTI_szamitas();
            if (tti < 18) {
                vanSovany = true;
                tti = Double.parseDouble(df.format(person.TTI_szamitas()));
                System.out.println(person.name + " - Életkor: " + person.age + ", TTI: " + tti + ", TI kategória: " + person.kategorializalas(tti));
            }
        }
        if (!vanSovany) {
            System.out.println("Nincs sovány kategóriába tartozó személy.");
        }
    }

    public void koverKategoria() {
        boolean vanKover = false;
        System.out.println("Kövér kategóriába tartozó személyek:");
        for (Person person : people) {
            double tti = person.TTI_szamitas();
            if (tti >= 25) {
                vanKover = true;
                tti = Double.parseDouble(df.format(person.TTI_szamitas()));
                System.out.println(person.name + " - Életkor: " + person.age + ", TTI: " + tti + ", TI kategória: " + person.kategorializalas(tti));
            }
        }
        if (!vanKover) {
            System.out.println("Nincs kövér kategóriába tartozó személy.");
        }
    }

    public void tulsulyos2030() {
        boolean vanTulsulyos = false;
        System.out.println("20-30 év közötti túlsúlyos kategóriába tartozó személyek:");
        for (Person person : people) {
            if (person.age >= 20 && person.age <= 30) {
                double tti = person.TTI_szamitas();
                if (tti >= 25 && tti < 30) {
                    vanTulsulyos = true;
                    tti = Double.parseDouble(df.format(person.TTI_szamitas()));
                    System.out.println(person.name + " - Életkor: " + person.age + ", TTI: " + tti + ", TI kategória: " + person.kategorializalas(tti));
                }
            }
        }
        if (!vanTulsulyos) {
            System.out.println("Nincs 20-30 év közötti túlsúlyos kategóriába tartozó személy.");
        }
    }
}
