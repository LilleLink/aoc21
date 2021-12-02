horizontal = 0;
depth = 0;
aim = 0;

f = open("input.txt");
content = f.read().splitlines();

for line in content :
    splitted = line.split(' ');
    print(splitted);
    if splitted[0] == "forward":
        horizontal += int(splitted[1]);
        depth += aim * int(splitted[1]);
    elif splitted[0] == "up":
        aim -= int(splitted[1]);
    elif splitted[0] == "down":
        aim += int(splitted[1]);
    

print(horizontal*depth);
