
import paramiko
def ssh_connect(hostname,port = 22,username,password,command_list):



    try:
        client = paramiko.SSHClient()
        client.load_system_host_keys()
        client.set_missing_host_key_policy(paramiko.WarningPolicy)

        client.connect(hostname, port=port, username=username, password=password)

        stdin, stdout, stderr = client.exec_command(command)
        print(stdout.read(), end=' ')

    finally:
        client.close()
command =['wget','crontab']
