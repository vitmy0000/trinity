import sys

with open('vimrc') as f:
    line_num = 0
    for line in f:
        if line_num == int(sys.argv[1]):
            sys.stdout.write(line.strip())
        line_num += 1
