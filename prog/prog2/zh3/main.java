package elsoo;

import java.io.IOException;
import java.util.List;
import java.text.DecimalFormat;
import java.util.Scanner;


public class Main {
    public static void main(String[] args) throws IOException {
        Bmi analyzer = new Bmi("src/main/resources/tti.txt");
        List<Person> people = analyzer.readFile();
        DecimalFormat df = new DecimalFormat("#.##");
        for (Person person : people) {
            double magassag_meterben = Double.parseDouble(df.format(person.height/100));
            double bmi = Double.parseDouble(df.format(person.TTI_szamitas()));

            System.out.println(person.name+ "\t" + magassag_meterben + " meter\t" + person.weight + " kg\t" + person.age + " éves\t" + bmi + " bmi\t" + person.kategorializalas(bmi));
        }


        Menu menu = new Menu(people);
        Scanner scanner = new Scanner(System.in);

        int choice;
        do {
            System.out.println("Válasszon a következő lehetőségek közül:");
            System.out.println("1) Legnagyobb és legkisebb testtömegű személy adatainak lekérdezése");
            System.out.println("2) Legmagasabb és legalacsonyabb személy adatainak lekérdezése");
            System.out.println("3) Átlagéletkor feletti személyek listája");
            System.out.println("4) Sovány kategóriába tartozó személyek listája");
            System.out.println("5) Kövér kategóriába tartozó személyek listája");
            System.out.println("6) 20-30 év közötti túlsúlyos kategóriába tartozó személyek listája");
            System.out.println("7) Kilépés a menüből");

            choice = scanner.nextInt();

            switch (choice) {
                case 1:
                    System.out.println();
                    menu.legnagyobbLegkisebbTesttomeggel();
                    System.out.println();
                    break;
                case 2:
                    System.out.println();
                    menu.legmagasabbLegalacsonyabb();
                    System.out.println();
                    break;
                case 3:
                    System.out.println();
                    menu.atlagEletkorFelettiSzemelyek();
                    System.out.println();
                    break;
                case 4:
                    System.out.println();
                    menu.sovanyKategoria();
                    System.out.println();
                    break;
                case 5:
                    System.out.println();
                    menu.koverKategoria();
                    System.out.println();
                    break;
                case 6:
                    System.out.println();
                    menu.tulsulyos2030();
                    System.out.println();
                    break;
                case 7:
                    System.out.println("Kilépés...");
                    break;
                default:
                    System.out.println("Érvénytelen választás.");
                    break;
            }
        } while (choice != 7);

        scanner.close();
    }
}