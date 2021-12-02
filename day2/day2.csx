string[] lines = System.IO.File.ReadAllLines(@"input.txt");

int horizontal = 0;
int depth = 0;
int aim = 0;

foreach (string line in lines) {
    parseLine(line);
}

Console.WriteLine(horizontal*depth);

public void parseLine (string line) {
    string[] values = line.Split(' ');
    int value = Int32.Parse(values[1]);
    switch (values[0]) {
        case "forward":
            horizontal += value;
            depth += aim*value;
        break;
        case "up":
            aim -= value;
        break;
        case "down":
            aim += value;
        break;
    }
}

