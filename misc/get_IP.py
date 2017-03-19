def getWinIP(version = 'IPv4'):
    import subprocess
    if version not in ['IPv4', 'IPv6']:
        print ('error - protocol version must be "IPv4" or "IPv6"')
        return None
    ipconfig = subprocess.check_output('ipconfig')
    my_ip = []
    for line in ipconfig.decode("utf-8").split('\n'):
        # print(line)
        if 'Address' in line and version in line:
            my_ip.append(line.split(' : ')[1].strip())

    return my_ip
# print (getWinIP())

# Another great function to get IP
# http://code.activestate.com/recipes/577191/