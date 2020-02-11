import requests, threading, time, re
# --------------------------------
r = '\033[31m'
g = '\033[32m'
y = '\033[33m'
b = '\033[34m'
m = '\033[35m'
c = '\033[36m'
w = '\033[37m'
# --------------------------------
domains = [
    'ac', 'ad', 'ae', 'af', 'ag', 'ai', 'al', 'am', 'an', 'ao',
    'aq', 'ar', 'as', 'at', 'au', 'aw', 'ax', 'az', 'ba', 'bb',
    'bd', 'be', 'bf', 'bg', 'bh', 'bi', 'bj', 'bm', 'bn', 'bo',
    'br', 'bs', 'bt', 'bv', 'bw', 'by', 'bz', 'ca', 'cc', 'cd',
    'cf', 'cg', 'ch', 'ci', 'ck', 'cl', 'cm', 'cn', 'co', 'cr',
    'cu', 'cv', 'cx', 'cy', 'cz', 'de', 'dj', 'dk', 'dm', 'do',
    'dz', 'ec', 'ee', 'eg', 'eh', 'er', 'es', 'et', 'eu', 'fi',
    'fj', 'fk', 'fm', 'fo', 'fr', 'ga', 'gb', 'gd', 'ge', 'gf',
    'gg', 'gh', 'gi', 'gl', 'gm', 'gn', 'gp', 'gq', 'gr', 'gs',
    'gt', 'gu', 'gw', 'gy', 'hk', 'hm', 'hn', 'hr', 'ht', 'hu',
    'id', 'ie', 'il', 'im', 'in', 'io', 'iq', 'is', 'it', 'com'
    'je', 'jm', 'jo', 'jp', 'ke', 'kg', 'kh', 'ki', 'km', 'kn',
    'kp', 'kr', 'kw', 'ky', 'kz', 'la', 'lb', 'lc', 'li', 'lk',
    'lr', 'ls', 'lt', 'lu', 'lv', 'ly', 'ma', 'mc', 'md', 'me',
    'mg', 'mh', 'mk', 'ml', 'mm', 'mn', 'mo', 'mp', 'mq', 'mr',
    'ms', 'mt', 'mu', 'mv', 'mw', 'mx', 'my', 'mz', 'na', 'nc',
    'ne', 'nf', 'ng', 'ni', 'nl', 'no', 'np', 'nr', 'nu', 'nz',
    'om', 'pa', 'pe', 'pf', 'pg', 'ph', 'pk', 'pl', 'pm', 'pn',
    'pr', 'ps', 'pt', 'pw', 'py', 'qa', 're', 'ro', 'rs', 'ru',
    'rw', 'sa', 'sb', 'sc', 'sd', 'se', 'sg', 'sh', 'si', 'sj',
    'sk', 'sl', 'sm', 'sn', 'so', 'sr', 'st', 'su', 'sv', 'sy',
    'sz', 'tc', 'td', 'tf', 'tg', 'th', 'tj', 'tk', 'tl', 'tm',
    'tn', 'to', 'tp', 'tr', 'tt', 'tv', 'tw', 'tz', 'ua', 'ug',
    'uk', 'um', 'us', 'uy', 'uz', 'va', 'vc', 've', 'vg', 'vi',
    'vn', 'vu', 'wf', 'ws', 'ye', 'yt', 'za', 'zm', 'zw', 'pro',
    'net', 'org', 'biz', 'gov', 'mil', 'edu', 'info', 'int', 'tel',
    'name', 'aero', 'asia', 'cat', 'coop', 'jobs', 'mobi', 'museum', 'travel'
]
# --------------------------------
Headers = {
    'User-Agent': 'Mozilla/5.0 (Linux; Android 4.2.2; QMV7A Build/JDQ39) AppleWebKit/537.36'
                  ' (KHTML, like Gecko) Chrome/39.0.2171.59 Safari/537.36'
}

urls = []
ProxyDAta = []


def CheckProxy(proxy):
    print('TEsting {}'.format(proxy))
    proxy = {'http': proxy,
             'https': proxy}
    try:
        Check = requests.get('http://www.bing.com/?toWww=1', timeout=3, proxies=proxy, headers=Headers)
        print(Check.status_code)
        if 'making it faster and easier to go from searching to doing.' in str(Check.content):
            ProxyDAta.append(proxy)
            print(proxy)
    except:
        pass

def BingDorker(Dork, domain, Num):
    global urls
    try:
        url = 'http://www.bing.com/search?q=' + Dork + ' site:' + domain + '&first=' + str(
            Num) + '&FORM=PORE'
        cnn = requests.get(url, timeout=5, headers=Headers)
        try:
            finder = re.findall('<h2><a href="((?:https://|http://)[a-zA-Z0-9-_]+\.*[a-zA-Z0-9]'
                                '[a-zA-Z0-9-_]+\.[a-zA-Z]{2,11})', str(cnn.content))
            for u in finder:
                if u.startswith('http://'):
                    u = u.replace('http://', '')
                elif u.startswith('https://'):
                    u = u.replace('https://', '')
                if u.startswith('www.'):
                    u = u.replace('www.', '')
                if 'go.microsoft.com' in u:
                    pass
                elif '.wordpress.' in u:
                    pass
                elif '.blogspot.' in u:
                    pass
                else:
                    urls.append(u)
        except:
            pass
    except:
        BingDorker(Dork, domain, Num)

def GoDorking(Dork, dom):
    thread = []
    pages = []
    i = 0
    print(' Start Dorking : {} site:{}'.format(Dork, dom))
    while i <= 500:
        pages.append(str(i))
        i += 10
    for page in pages:
        t = threading.Thread(target=BingDorker, args=(Dork, dom, page))
        t.start()
        thread.append(t)
        time.sleep(0.6)
    for j in thread:
        j.join()

def STarTDorking(Dork):
    thread = []
    for domain in domains:
        t = threading.Thread(target=GoDorking, args=(Dork, domain))
        t.start()
        thread.append(t)
        time.sleep(0.6)
    for j in thread:
        j.join()

