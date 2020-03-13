#!/usr/bin/env python
import mutagen
from pathlib import Path
import os
import sys
from mutagen import m4a
from mutagen.id3 import ID3
from shutil import copy2

pwd = Path(os.path.dirname(os.path.abspath(__file__)))

doit = False
if len(sys.argv) >= 2:
    arg1 = sys.argv[1]
    print("Path: {}".format(arg1))
    if len(sys.argv) == 3:
        if sys.argv[2] == 'doit':
            doit = True
else:
    print("Arg missing.")
    raise SystemExit(1)

extension = 'm4a'
path = Path(arg1)
for au_file in path.glob('*.{}'.format(extension)):
    print("File: {}".format(au_file))
    muta_file = mutagen.File(au_file)
    #print("LOOP through all values():")
    #for val in muta_file.values():
    #    if val == '©Nam' 
    #    print("Tag value: {}".format(val[0]))
    #for tag in muta_file.tags:
    #    print("Tag: {}".format(tag))
    if '©nam' in muta_file.tags.keys():
        name_in_tag = muta_file.tags['©nam'][0]
        name_in_tag = name_in_tag.lstrip().rstrip()
        print("Tag:  {}".format(name_in_tag))
        #print('copy "{}" to "{}"'.format(au_file, name_in_tag))
        if doit:
            copy2(au_file, '{}.{}'.format(name_in_tag, extension))
    else:
        print('ERROR: !!! NO NAME TAG !!!')
    #print("Tag: cmt by name: {}".format(muta_file.tags['©cmt'][0]))
    #print("Tag: too: {}".format(muta_file.tags['©too'][0]))
    #print("Value by index 1: {}".format(muta_file.values()[1][0]))
    #print("Value by index 2: {}".format(muta_file.values()[2][0]))
    print("")
    print("")


#print("")
#print("Tag: cmt: {}".format(file.tags['©cmt']))
#print("Tag: too: {}".format(file.tags['©too']))
#print("Tag: Nam: {}".format(file.tags['©Nam']))

#print("file.keys: {}".format(file.keys()))
#print("")
#print("file.pprint: {}".format(file.pprint()))
#print("")
