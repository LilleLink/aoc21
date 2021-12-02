horizontal = 0;
depth = 0;
aim = 0;

f = open("input.txt");
content = f.read().splitlines();

# Part B
for line in content :
    line = line.split(' ');
    instruction = line[0];
    value = line[1];
    if instruction == "forward":
        horizontal += int(value);
        depth += aim * int(value);
    elif instruction == "up":
        aim -= int(value);
    elif instruction == "down":
        aim += int(value);

''' 
Part A
for line in content :
    line = line.split(' ');
    instruction = line[0];
    value = line[1];
    if instruction == "forward":
        horizontal += int(value);
    elif instruction == "up":
        depth -= int(value);
    elif instruction == "down":
        depth += int(value);
'''

print(horizontal*depth);
