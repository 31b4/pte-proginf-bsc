package elsoo;

import java.util.*;


public class Matrix {
    static int[] START = {0, 0};
    static int[] END = {2, 2};
    static int[][] matrix = {
        {0, 1, 0},
        {2, 0, 1},
        {1, 2, 0}
    };
    public void matrixKiir(){
        for (int i = 0; i < matrix.length; i++) {
            for (int j = 0; j < matrix[i].length; j++) {
                System.out.print(matrix[i][j] + " ");
            }
            System.out.println();
        }
    }
}

class Node implements Comparable<Node> {
    int x, y, cost;
    ArrayList<int[]> path;

    public Node(int x, int y, int cost, ArrayList<int[]> path) {
        this.x = x;
        this.y = y;
        this.cost = cost;
        this.path = new ArrayList<>(path);
    }

    @Override
    public int compareTo(Node other) {
        return Integer.compare(this.cost, other.cost);
    }
}

class AStar {
    static PriorityQueue<Node> heap = new PriorityQueue<>();
    static HashSet<String> visited = new HashSet<>();



    static void astar(int[][] matrix) {
        ArrayList<int[]> startPath = new ArrayList<>();
        startPath.add(new int[]{Matrix.START[0], Matrix.START[1]});
        Node startNode = new Node(0, 0, matrix[0][0], startPath);
        heap.add(startNode);

        while (!heap.isEmpty()) {
            Node current = heap.poll();

            if (current.x == Matrix.END[0] && current.y == Matrix.END[1]) {
                System.out.println("Pontszám: " + current.cost);
                System.out.println("Útvonal:");
                for (int[] point : current.path) {
                    System.out.println(Arrays.toString(point));
                }
                return;
            }

            visited.add(current.x + "-" + current.y);

            int[][] directions = {{0, 1}, {1, 0}, {-1, 0}, {0, -1}};
            for (int[] dir : directions) {
                int newX = current.x + dir[0];
                int newY = current.y + dir[1];

                if (0 <= newX && newX < 3 && 0 <= newY && newY < 3 &&
                    !visited.contains(newX + "-" + newY)) {
                    int newCost = current.cost + matrix[newX][newY];
                    ArrayList<int[]> newPath = new ArrayList<>(current.path);
                    newPath.add(new int[]{newX, newY});
                    heap.add(new Node(newX, newY, newCost, newPath));
                }
            }
        }
    }

    public static void main(String[] args) {
        Matrix matrix = new Matrix();
        matrix.matrixKiir();
        astar(matrix.matrix);
    }
}