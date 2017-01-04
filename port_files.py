# cbn
# script_file.py -a into_this_repo -o files_to_port-cbnPC.txt
# script_file.py -a into_this_repo/from_this_repo_to_folder -o files_to_port-<installation-detail>

from distutils.dir_util import copy_tree
import getopt
import sys
import errno
 
def copy_files_and_directories(src, dest):
    try:
        shutil.copytree(src, dest)
    except OSError as e:
        # If the error was caused because the source wasn't a directory
        if e.errno == errno.ENOTDIR:
            shutil.copy(src, dest)
        else:
            print('Directory not copied. Error: %s' % e)
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
if action=='from_this_repo_to_folder':
    print('Danger: overwriting: yes?')
    a=str(input())
    if (a=='yes'): 
        for f in all_files:
            shutil.copyfile(os.path.join(parent,'ported_files', os.path.basename(f) ),f )
            print('restored from repo to ' + str(f))
elif action =='into_this_repo':
    for f in all_files:

        # copy subdirectory example
        # fromDirectory = "/a/b/c"
        # toDirectory = "/x/y/z"
        if os.path.isdir(f):
            copy_tree(f,os.path.join(parent,'ported_files', os.path.basename(f)) )
        else:
            shutil.copyfile(f,os.path.join(parent,'ported_files', os.path.basename(f)) )
        print('copied to repo from ' + str(f))

        