# cbn
# script_file.py to_repo/from_repo files_to_port-<installation-detail>

import getopt
import sys

action = None
file_list = None

try:
    options, remainder = getopt.getopt( sys.argv[1:], 'o:a:h', ['output=', 'action=', 'help']
                                       )
except getopt.GetoptError:
    print('error')
    sys.exit(2)                      
print (options)
for opt, arg in options:
    print(opt, arg)
    if opt in ('-o', '--output'):
        file_list = arg
        print(file_list)
    elif opt in ('-a', '--action'):
        action = arg
        print(arg)

if file_list is None or action is None:
    print('missing arguments')
    sys.exit()
        
import shutil
import os 

all_files=open(file_list).read().splitlines()
parent = os.path.dirname(os.path.abspath(__file__))

print(action)
if action=='repo_to_folder':
    print('Danger: overwriting')
    a=input()
    for f in all_files:
        shutil.copyfile(os.path.join(parent,'ported_files', os.path.basename(f) ),f )
        print('restored from repo to ' + str(f))
elif action =='to_repo':
    for f in all_files:
        shutil.copyfile(f,os.path.join(parent,'ported_files', os.path.basename(f)) )
        print('copied to repo from ' + str(f))

        
        
        