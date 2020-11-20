#!/usr/bin/python3.8
import sys
for line in sys.stdin:
    for i in range(3, len(line), 3):
        print(line[i-3: i], "\t1") #Why do we write 1 there if it's always 1? Can we just keep in mind in this case?

