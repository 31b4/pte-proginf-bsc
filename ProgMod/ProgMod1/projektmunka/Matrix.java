package elsoo;

import java.util.*;


public class Matrix {
    int[][] matrix3x3 = {
            {0, 1, 0},
            {2, 0, 1},
            {1, 2, 0}
    };
    int[][] matrix4x4 = {
        {0, 2, 0, 0},
        {2, 2, 1, 0},
        {1, 2, 0, 0},
        {0, 0, 0, 0}
    };
    int[][] matrix5x5 = {
        {0, 1, 2, 0, 0},
        {2, 0, 0, 0, 0},
        {2, 2, 2, 2, 0},
        {2, 2, 0, 2, 0},
        {2, 2, 0, 2, 0}
    };
    static class Node {
        int x, y, cost;
        ArrayList<int[]> path;

        public Node(int x, int y, int cost, ArrayList<int[]> path) {
            this.x = x;
            this.y = y;
            this.cost = cost;
            this.path = new ArrayList<>(path);
        }
    }

    public static void astar(int[][] matrix, int N, int M, int[] START, int[] END) {
        PriorityQueue<Node> heap = new PriorityQueue<>(Comparator.comparingInt(a -> a.cost));
        HashSet<String> visited = new HashSet<>();

        ArrayList<int[]> startPath = new ArrayList<>();
        startPath.add(new int[]{START[0], START[1]});
        Node startNode = new Node(START[0], START[1], matrix[START[0]][START[1]], startPath);
        heap.add(startNode);

        while (!heap.isEmpty()) {
            Node current = heap.poll();

            if (current.x == END[0] && current.y == END[1]) {
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
                if (0 <= newX && newX < N && 0 <= newY && newY < M &&
                    !visited.contains(newX + "-" + newY) && matrix[newX][newY] != -1) {
                    int newCost = current.cost + matrix[newX][newY];
                    ArrayList<int[]> newPath = new ArrayList<>(current.path);
                    newPath.add(new int[]{newX, newY});
                    heap.add(new Node(newX, newY, newCost, newPath));
                }
            }
        }

        System.out.println("Nincs megoldás.");
    }

    public static void main(String[] args) {
        Matrix matrix = new Matrix();
        int[] START = {0, 0};
        int[] END = {2, 2};
        astar(matrix.matrix3x3, 3, 3, START, END);

        START = new int[]{0, 0};
        END = new int[]{3, 3};
        astar(matrix.matrix4x4, 4, 4, START, END);

        START = new int[]{0, 0};
        END = new int[]{4, 4};
        astar(matrix.matrix5x5, 5, 5, START, END);
    }
}
