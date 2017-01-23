import get_IP
from pyftpdlib.authorizers import DummyAuthorizer
from pyftpdlib.handlers import FTPHandler
from pyftpdlib.servers import FTPServer
import time
import logging
import threading

class FtpThread(threading.Thread):
    def __init__(self, user_list):
        self.user_list = user_list
        self.killswitch = 0
        threading.Thread.__init__(self)
    def run(self,*args,**kwargs):
    
        authorizer = DummyAuthorizer()
        authorizer.add_user("user", "12345", "C:/users/cibin/Downloads", perm="elradfmw")
        # authorizer.add_anonymous("/home/nobody")

        handler = FTPHandler
        handler.authorizer = authorizer

        wifi_ip=str(get_IP.getWinIP()[1]) # first IP is mostly LAN IP
        print("Access at url ftp://" + wifi_ip + ":21")
        # logging.basicConfig(filename='F:/CBN/misc/fdm dwnlds/ftp.log', level=logging.INFO)
        handler.banner = "pyftpdlib based ftpd ready."
        address = (wifi_ip, 21)
        self.server = FTPServer(address, handler)
        self.server.max_cons = 3
        self.server.max_cons_per_ip = 5
        self.server.serve_forever()

    def stop(self):
        self.server.close_all()
    
    
if __name__ == '__main__':
    ftp_server = FtpThread("")
    ftp_server.start()

    time.sleep(600)
    ftp_server.stop()
    print("Shut down")
