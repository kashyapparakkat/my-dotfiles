# script_file.py to_repo/from_repo files_to_port-<installation-detail>

import getopt
import sys

action = None
file_list = None

try:
    options, remainder = getopt.getopt(sys.argv[1:], 'o:a', ['output=', 
                                                         'action',
                                                         'version=',
                                                         ])
except getopt.GetoptError:                                     
    sys.exit(2)                      

for opt, arg in options:
    if opt in ('-o', '--output'):
        file_list = arg
        print(file_list)
    elif opt in ('-a', '--action'):
        action = arg
        

if file_list is None or action is None:
    print('missing arguments')
    sys.exit()
        
import shutil
import os 

all_files=open(file_list).read().splitlines()
parent = os.path.dirname(os.path.abspath(__file__))
print ('adsasdfs')

if action=='to_repo':
    for f in all_files:
        shutil.copyfile(os.path.join(parent,'ported_files', os.path.basename(f) ),f )
else if action=='repo_to_folder':
    for f in all_files:
        shutil.copyfile(f,os.path.join(parent,'ported_files', os.path.basename(f)) )
        
        
        
        