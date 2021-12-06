using System.Collections;
string[] lines = System.IO.File.ReadAllLines(@"input.txt");
int[] ones = new int[12];
int[] mostCommon = new int[12];
List<string> alternatives = new List<string>();
int total = lines.Length;

// Adds each one first time
foreach (string line in lines) {
    char currentChar = line[0];
    if ((int)(currentChar-'0') == getMostCommon(lines, 0)) {
        alternatives.Add(line);
    }
}

for (int i = 1; i < 12; i++) {
    int mostCommon = getMostCommon(alternatives.ToArray(), i);
    for (int j = 0; j < alternatives.Count; j++) {
        int currentNum = (int)alternatives.ElementAt(j)[i]-'0';
        if (currentNum != mostCommon) {
            alternatives.RemoveAt(j);
            j--;
        }
    }
    Console.WriteLine(alternatives.Count + " | "+getMostCommon(alternatives.ToArray(),i));
}

string oxygen = alternatives.ElementAt(0);
Console.WriteLine("Oxygen: " + oxygen);
Console.WriteLine(lines.Length);

List<string> alternatives2 = new List<string>();
foreach (string line in lines) {
    char currentChar = line[0];
    if ((int)(currentChar-'0') == getLeastCommon(lines, 0)) {
        alternatives2.Add(line);
    }
}

Console.WriteLine(alternatives2.Count);

for (int i = 1; i < 12; i++) {
    if (alternatives2.Count == 1) {
        break;
    }
    int leastCommon = getLeastCommon(alternatives2.ToArray(), i);
    for (int j = 0; j < alternatives2.Count; j++) {
        int currentNum = (int)alternatives2.ElementAt(j)[i]-'0';
        Console.WriteLine(leastCommon + " : " + currentNum);
        if (currentNum != leastCommon) {
            alternatives2.RemoveAt(j);
            j--;
        }
    }
    Console.WriteLine(alternatives2.Count + " | " + getMostCommon(alternatives2.ToArray(),i));
    //foreach (string line in alternatives2) {
    //    Console.WriteLine(line);
    //}
}

string c02 = alternatives2.ElementAt(0);

int[] oxint = Array.ConvertAll(c02.ToCharArray(), c => (int)Char.GetNumericValue(c));
int[] c02int = Array.ConvertAll(oxygen.ToCharArray(), c => (int)Char.GetNumericValue(c));
Array.Reverse(oxint);
Array.Reverse(c02int);

Console.WriteLine(fromBinary(oxint)*fromBinary(c02int));

public int getMostCommon(string[] a, int b) { 
    int zeroes = 0;
    int ones = 0;
    for (int i = 0; i < a.Length; i++) {
        if (a[i][b] == '0') {
            zeroes++;
        } else {
            ones++;
        }
    }
    if (zeroes > ones) {
        return 0;
    } else if (ones > zeroes) {
        return 1;
    } else {
        return 1;
    }
}

public int getLeastCommon(string[] a, int b) { 
    int zeroes = 0;
    int ones = 0;
    for (int i = 0; i < a.Length; i++) {
        if (a[i][b] == '0') {
            zeroes++;
        } else {
            ones++;
        }
    }
    if (zeroes > ones) {
        return 1;
    } else if (ones > zeroes) {
        return 0;
    } else {
        return 0;
    }
}

public int fromBinary(int[] a) {
    int res = 0;
    for (int i = 0; i < a.Length; i++) {
        if (a[i] == 1) {
            res += (int) Math.Pow(2, i);
        }
    }
    return res;
}