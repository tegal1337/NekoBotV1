# coding=utf-8
import requests
r = '\033[31m'
g = '\033[32m'
y = '\033[33m'
b = '\033[34m'
m = '\033[35m'
c = '\033[36m'
w = '\033[37m'
Headers = {'User-Agent': 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:28.0) Gecko/20100101 Firefox/28.0'}


def DetectCMS(site):
    Joomla = 'http://{}/administrator/help/en-GB/toc.json'.format(site)    # "COMPONENTS_BANNERS_BANNERS"
    Joomla2 = 'http://{}/administrator/language/en-GB/install.xml'.format(site)   # <author>Joomla!
    Joomla3 = 'http://{}/plugins/system/debug/debug.xml'.format(site)  # <author>Joomla!
    Joomla4 = 'http://{}/administrator/'.format(site)
    Wordpress = 'http://{}'.format(site)  # /wp-content/ or /wp-inclues
    Wordpress2 = 'http://{}/wp-includes/js/jquery/jquery.js'.format(site)  # (c) jQuery Foundation
    drupal = 'http://{}/misc/ajax.js'.format(site)  # Drupal.ajax
    drupal2 = 'http://{}'.format(site)  # /sites/default/files
    Opencart = 'http://{}/admin/view/javascript/common.js'.format(site)  # getURLVar(key)
    osCommerce = 'http://{}/admin/includes/general.js'.format(site)  # function SetFocus()
    vBulletin = 'http://{}/images/editor/separator.gif'.format(site)
    vBulletin2 = 'http://{}/js/header-rollup-554.js'.format(site)  # /js/header-rollup-554.js
    try:
        CheckWp = requests.get(Wordpress, timeout=10, headers=Headers).content
        if '/wp-content/' in str(CheckWp) or '/wp-inclues/' in str(CheckWp):
            try:
                with open('cms/Wordpress.txt', 'a') as XW:
                    XW.write(site + '\n')
            except:
                pass
            return 'wordpress'
        CheckWp2 = requests.get(Wordpress2, timeout=10, headers=Headers).content
        if '(c) jQuery Foundation' in str(CheckWp2):
            try:
                with open('cms/Wordpress.txt', 'a') as XW:
                    XW.write(site + '\n')
            except:
                pass
            return 'wordpress'
        CheckJom = requests.get(Joomla, timeout=10, headers=Headers).content
        if '"COMPONENTS_BANNERS_BANNERS"' in str(CheckJom):
            try:
                with open('cms/joomla.txt', 'a') as XW:
                    XW.write(site + '\n')
            except:
                pass
            return 'joomla'
        CheckJom2 = requests.get(Joomla2, timeout=10, headers=Headers).content
        if '<author>Joomla!' in str(CheckJom2):
            try:
                with open('cms/joomla.txt', 'a') as XW:
                    XW.write(site + '\n')
            except:
                pass
            return 'joomla'
        CheckJom3 = requests.get(Joomla3, timeout=10, headers=Headers).content
        if '<author>Joomla!' in str(CheckJom3):
            try:
                with open('cms/joomla.txt', 'a') as XW:
                    XW.write(site + '\n')
            except:
                pass
            return 'joomla'
        CheckJom4 = requests.get(Joomla4, timeout=10, headers=Headers).content
        if 'content="Joomla!' in str(CheckJom4):
            try:
                with open('cms/joomla.txt', 'a') as XW:
                    XW.write(site + '\n')
            except:
                pass
            return 'joomla'
        CheckDrupal = requests.get(drupal, timeout=10, headers=Headers).content
        if 'Drupal.ajax' in str(CheckDrupal):
            try:
                with open('cms/drupal.txt', 'a') as XW:
                    XW.write(site + '\n')
            except:
                pass
            return 'drupal'
        CheckDrupal2 = requests.get(drupal2, timeout=10, headers=Headers).content
        if '/sites/default/files' in str(CheckDrupal2):
            try:
                with open('cms/drupal.txt', 'a') as XW:
                    XW.write(site + '\n')
            except:
                pass
            return 'drupal'
        CheckOpencart = requests.get(Opencart, timeout=10, headers=Headers).content
        if 'getURLVar(key)' in str(CheckOpencart):
            try:
                with open('cms/opencart.txt', 'a') as XW:
                    XW.write(site + '\n')
            except:
                pass
            return 'opencart'
        CheckOsCommerce = requests.get(osCommerce, timeout=10, headers=Headers).content
        if 'function SetFocus()' in str(CheckOsCommerce):
            try:
                with open('cms/oscommerce.txt', 'a') as XW:
                    XW.write(site + '\n')
            except:
                pass
            return 'oscommerce'
        Checkvb = requests.get(vBulletin, timeout=10, headers=Headers).content
        if 'GIF89a' in str(Checkvb):
            try:
                with open('cms/vBulletin.txt', 'a') as XW:
                    XW.write(site + '\n')
            except:
                pass
            return 'vBulletin'
        Checkvb2 = requests.get(vBulletin2, timeout=10, headers=Headers).content
        if 'js.compressed/modernizr.min.js' in str(Checkvb2):
            try:
                with open('cms/vBulletin.txt', 'a') as XW:
                    XW.write(site + '\n')
            except:
                pass
            return 'vBulletin'
        if 'content="vBulletin' in str(CheckDrupal2):
            try:
                with open('cms/vBulletin.txt', 'a') as XW:
                    XW.write(site + '\n')
            except:
                pass
            return 'vBulletin'
        if 'var prestashop =' in str(CheckDrupal2):
            try:
                with open('cms/prestashop.txt', 'a') as XW:
                    XW.write(site + '\n')
            except:
                pass
            return 'prestashop'
        else:
            try:
                with open('cms/unknown.txt', 'a') as XW:
                    XW.write(site + '\n')
            except:
                pass
            return 'unknown'
    except:
        return 'deadTarget'