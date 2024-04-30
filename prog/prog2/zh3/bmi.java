package elsoo;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
public class Bmi {
    private String filename;

    Bmi(String filename) {
        this.filename = filename;
    }

    List<Person> readFile() throws IOException {
        List<Person> people = new ArrayList<>();
        BufferedReader reader = new BufferedReader(new FileReader(filename));
        String line;
        while ((line = reader.readLine()) != null) {
            String[] parts = line.split("\t");
            String name = parts[0];
            double height = Double.parseDouble(parts[1]);
            double weight = Double.parseDouble(parts[2]);
            int age = Integer.parseInt(parts[3]);

            people.add(new Person(name, height, weight, age));
        }
        reader.close();
        return people;
    }
}