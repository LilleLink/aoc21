string[] lines = System.IO.File.ReadAllLines(@"input.txt");
int[,] intlines = new int[lines.Length,12];
int[] ones = new int[12];

int total = lines.Length;

for (int i = 0; i < lines.Length; i++) {
    for (int j = 0; j < lines[i].Length; j++) {
        if (lines[i][j] == '1') {
            ones[j]++;
        }
    }
}

for (int i = 0; i < ones.Length; i++) {
    Console.Write(ones[i]+"\t");
}
Console.WriteLine();

for (int i = 0; i < ones.Length; i++) {
    if (ones[i]>(total/2)) {
        ones[i] = 1;
    } else {
        ones[i] = 0;
    }
}

for (int i = 0; i < ones.Length; i++) {
    Console.Write(ones[i] + "\t");
}

int[] gammarate = ones;

int[] epsilonrate = new int[ones.Length];

Console.WriteLine();
for (int i = 0; i < ones.Length; i++) {
    if (ones[i] == 1) epsilonrate[i] = 0;
    else epsilonrate[i] = 1;

    Console.Write(epsilonrate[i] +"\t");
}

Array.Reverse(gammarate);
Array.Reverse(epsilonrate);
Console.WriteLine();
Console.WriteLine(fromBinary(gammarate)*fromBinary(epsilonrate));

public int fromBinary(int[] a) {
    int res = 0;
    for (int i = 0; i < a.Length; i++) {
        if (a[i] == 1) {
            res += (int) Math.Pow(2, i);
        }
    }
    return res;
}