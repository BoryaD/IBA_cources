#!/usr/bin/python3.8
import sys
last_key = 0
count = 0
for line in sys.stdin:
    key, count_in_key = line.split("\t")
    if last_key != key and  last_key:
        print(f"{last_key}\t{count}")
        count = int(count_in_key)
        last_key = key
    else:
        count += int(count_in_key)
        last_key = key
key, count_in_key = line.split("\t")
print(f"{key}\t{count}")
