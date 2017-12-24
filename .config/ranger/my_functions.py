import re

def parse_grep_file_path(line):

    path = re.sub('^(..[^:]+)(.*)',r"\1",line.strip('\n'))
    return path
