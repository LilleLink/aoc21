string[] lines = System.IO.File.ReadAllLines(@"input.txt");
int[] numbers = Array.ConvertAll(lines, int.Parse);
int[] comparisons = compare(windows(numbers));

public static int[] windows(int[] a) {
    int[] windows = new int[a.Length];
    for (int i = 0; i < a.Length-2; i++) {
        int window = a[i]+a[i+1]+a[i+2];
        windows[i] = window;
    }
    return windows;
}

public static int[] compare(int[] a) {
    int[] comparisons = new int[a.Length];
    for (int i = 0; i < a.Length-1; i++) {
        if (a[i] < a[i+1]) {
            comparisons[i] = 1;
        } else {
            comparisons[i] = 0;
        }
    }   
    return comparisons;
}
 

int sum = 0;
foreach (int i in comparisons) {
    sum += i;
}

Console.WriteLine(sum);