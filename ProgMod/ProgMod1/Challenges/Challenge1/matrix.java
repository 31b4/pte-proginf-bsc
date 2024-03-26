import java.util.Random;

public class Matrix {
    int[][] matrix = new int[10][10];

    public Matrix(int n) {
        int[][] m = new int[n][n];
        Random rand = new Random();
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                int randomNum = rand.nextInt((2 - 0) + 1) + 0;
                m[i][j] = randomNum;
            }
        }
        this.matrix = m;
    }
}
