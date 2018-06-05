#!/usr/bin/python

import os
import sys

test_file = "netsec1.junk"
my_mask = 777
args = len(sys.argv)

if args > 3:
    test_file = sys.argv[1]
    perms = int(sys.argv[2])
    mask = sys.argv[3]
    old_mask = os.umask (mask)
    fh1 = os.open (test_file, os.O_CREAT, perms)
elif args > 2:
    test_file = sys.argv[1]
    perms = int(sys.argv[2])
    fh1 = os.open (test_file, os.O_CREAT, perms)
elif args > 1:
    test_file = sys.argv[1]
    fh1 = os.open (test_file, os.O_CREAT)
else:
    fh1 = os.open (test_file, os.O_CREAT)

os.close(fh1)
