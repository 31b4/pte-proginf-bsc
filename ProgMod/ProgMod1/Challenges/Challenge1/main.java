import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        System.out.print("Adja meg n: ");
        int n = sc.nextInt();


        Matrix m = new Matrix(n);
        for (int i = 0; i < m.matrix.length; i++) {
            for (int j = 0; j < m.matrix[i].length; j++) {
                System.out.print(m.matrix[i][j]);
            }
            System.out.println();
        }
    }
}