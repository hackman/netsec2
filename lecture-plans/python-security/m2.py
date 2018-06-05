#!/usr/bin/python

import os
import sys

fh1 = os.open ("py-0333-3", os.O_CREAT, 0777)

os.close(fh1)
