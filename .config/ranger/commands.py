
# https://superuser.com/questions/1048647/how-to-define-new-commands-in-the-ranger-file-manager/1048648


# This is a sample commands.py.  You can add your own commands here.
#
# Please refer to commands_full.py for all the default commands and a complete
# documentation.  Do NOT add them all here, or you may end up with defunct
# commands when upgrading ranger.

# A simple command for demonstration purposes follows.
# -----------------------------------------------------------------------------

from __future__ import (absolute_import, division, print_function)

# You can import any python module as needed.
import os

# You always need to import ranger.api.commands here to get the Command class:
from ranger.api.commands import Command
import my_functions

# Any class that is a subclass of "Command" will be integrated into ranger as a
# command.  Try typing ":my_edit<ENTER>" in ranger!
class my_edit(Command):
    # The so-called doc-string of the class will be visible in the built-in
    # help that is accessible by typing "?c" inside ranger.
    """:my_edit <filename>

    A sample command for demonstration purposes that opens a file in an editor.
    """

    # The execute method is called when you run this command in ranger.
    def execute(self):
        # self.arg(1) is the first (space-separated) argument to the function.
        # This way you can write ":my_edit somefilename<ENTER>".
        if self.arg(1):
            # self.rest(1) contains self.arg(1) and everything that follows
            target_filename = self.rest(1)
        else:
            # self.fm is a ranger.core.filemanager.FileManager object and gives
            # you access to internals of ranger.
            # self.fm.thisfile is a ranger.container.file.File object and is a
            # reference to the currently selected file.
            target_filename = self.fm.thisfile.path

        # This is a generic function to print text in ranger.
        self.fm.notify("Let's edit the file " + target_filename + "!")

        # Using bad=True in fm.notify allows you to print error messages:
        if not os.path.exists(target_filename):
            self.fm.notify("The given file does not exist!", bad=True)
            return

        # This executes a function from ranger.core.acitons, a module with a
        # variety of subroutines that can help you construct commands.
        # Check out the source, or run "pydoc ranger.core.actions" for a list.
        self.fm.edit_file(target_filename)

    # The tab method is called when you press tab, and should return a list of
    # suggestions that the user will tab through.
    # tabnum is 1 for <TAB> and -1 for <S-TAB> by default
    def tab(self, tabnum):
        # This is a generic tab-completion function that iterates through the
        # content of the current directory.
        return self._tab_directory_content()




class newcmd(Command):
    def execute(self):
        if not self.arg(1):
            self.fm.notify('Wrong number of arguments', bad=True)
            return
        # First argument. 0 is the command name.
        self.fm.notify(self.arg(1))
        # Current directory to status line.
        self.fm.notify(self.fm.thisdir)
        # Run a shell command.
        self.fm.run(['touch', 'newfile'])

# Visit frequently used directories
# https://github.com/ranger/ranger/wiki/Commands
# This command uses fasd to jump to a frequently visited directory with a given substring of its path.

class fasd(Command):
    """
    :fasd

    Jump to directory using fasd
    """
    def execute(self):
        import subprocess
        arg = self.rest(1)
        if arg:
            directory = subprocess.check_output(["fasd", "-d"]+arg.split(), universal_newlines=True).strip()
            self.fm.cd(directory)

## my fzf integration for ag
class fzf_ag_here(Command):
    """
    :fzf_select

    Find a file using fzf.

    With a prefix argument select only directories.

    See: https://github.com/junegunn/fzf
    """
    def execute(self):
        import subprocess
        import os.path
        if self.quantifier:
            # match only directories
            command="find -L . \( -path '*/\.*' -o -fstype 'dev' -o -fstype 'proc' \) -prune \
            -o -type d -print 2> /dev/null | sed 1d | cut -b3- | fzf +m"
        else:
            # match files and directories
            # command="find -L . \( -path '*/\.*' -o -fstype 'dev' -o -fstype 'proc' \) -prune \
            # -o -print 2> /dev/null | sed 1d | cut -b3- | fzf +m"
            command="ag -n .|fzy"
        fzf = self.fm.execute_command(command, stdout=subprocess.PIPE)
        stdout, stderr = fzf.communicate()
        if fzf.returncode == 0:
            fzf_file = os.path.abspath(my_functions.parse_grep_file_path(stdout.decode('utf-8').rstrip('\n')))
            if os.path.isdir(fzf_file):
                self.fm.cd(fzf_file)
            else:
                self.fm.select_file(fzf_file)

## fzf integration
class fzf_select(Command):
    """
    :fzf_select

    Find a file using fzf.

    With a prefix argument select only directories.

    See: https://github.com/junegunn/fzf
    """
    def execute(self):
        import subprocess
        import os.path
        if self.quantifier:
            # match only directories
            command="find -L . \( -path '*/\.*' -o -fstype 'dev' -o -fstype 'proc' \) -prune \
            -o -type d -print 2> /dev/null | sed 1d | cut -b3- | fzf +m"
        else:
            # match files and directories
            command="find -L . \( -path '*/\.*' -o -fstype 'dev' -o -fstype 'proc' \) -prune \
            -o -print 2> /dev/null | sed 1d | cut -b3- | fzf +m"
        fzf = self.fm.execute_command(command, stdout=subprocess.PIPE)
        stdout, stderr = fzf.communicate()
        if fzf.returncode == 0:
            fzf_file = os.path.abspath(stdout.decode('utf-8').rstrip('\n'))
            if os.path.isdir(fzf_file):
                self.fm.cd(fzf_file)
            else:
                self.fm.select_file(fzf_file)

#  https://github.com/ranger/ranger/issues/255
from subprocess import PIPE
class fzfcd(Command):
    def execute(self):
        command="find -L \( -path '*.wine-pipelight' -o -path '*.ivy2*' -o -path '*.texlive*' -o -path '*.git' -o -path '*.metadata' -o -path '*_notes' \) -prune -o -type d -print 2>/dev/null | fzf"
        fzf = self.fm.execute_command(command, stdout=PIPE)
        stdout, stderr = fzf.communicate()
        directory = stdout.decode('utf-8').rstrip('\n')
        self.fm.cd(directory)


class fzfsearch(Command):
    def execute(self):
        command="fd.sh txt"
        fzf = self.fm.execute_command(command, stdout=PIPE)
        stdout, stderr = fzf.communicate()
        directory = stdout.decode('utf-8').rstrip('\n')
        #self.fm.cd(directory)
'''
# ~/.config/ranger/commands.py
from ranger.api.commands import *
import ranger.fsobject.directory
original_accept_file = ranger.fsobject.directory.accept_file

# this was copy&pasted from ranger/fsobject/directory.py and modified
# to make filters case insensitive
def insensitive_accept_file(fname, dirname, hidden_filter, name_filter):
    if hidden_filter:
        try:
            if hidden_filter.search(fname):
                return False
        except:
            if hidden_filter in fname:
                return False
    if name_filter and name_filter.lower() not in fname.lower():
        return False
    return True

class filter(Command):
    def quick(self):
        ranger.fsobject.directory.accept_file = original_accept_file
        self.fm.set_filter(self.rest(1))
        self.fm.reload_cwd()

class filter_i(Command):
    def quick(self):
        ranger.fsobject.directory.accept_file = insensitive_accept_file
        self.fm.set_filter(self.rest(1))
        self.fm.reload_cwd()
'''
