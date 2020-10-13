#!/usr/bin/env python3
import os, sys
from fileinput import input as read

current = 'CoverLetter.tex'

properties = {
    'CompanyName':'Full, Name',
    'CompanyAddress_0': 'Line 1',
    'CompanyAddress_1':  'Line 2',
    'howDoIMeetDemands':'Line1',
    'howWillIContribute':'Line2'
}

def replacing(set=True, file = current):
    with read(current, inplace=True) as foil:
        for line in foil:
            for key,value in properties.items():
                prop_prep = "<?"+key+"?>"
                if set:
                    if prop_prep in line:
                        line = line.replace(prop_prep, value)
                else:
                    if value in line:
                        line = line.replace(value, prop_prep)
            print(line, end='')


if __name__ == "__main__":
    if (len(sys.argv) != 2):
        print('Usage 1: ./SCRIPT.py x')
        print('\tx :=')
        print('\tset ~ Inject Company Specific Attributes')
        print('\treset ~ Reset the CoverLetter')
        sys.exit()

    if sys.argv[1] == 'set':
        replacing()

    elif sys.argv[1] == 'reset':
        replacing(False)