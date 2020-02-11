#!/usr/bin/env python

import sys
import threading
import requests, urllib3
from datetime import datetime

class Cl:
	end	= '\033[0m'
	red	= '\033[1;31m'
	grn	= '\033[1;32m'
	ylw	= '\033[1;33m'
	wht	= '\033[1;37m'
	
def check_shell(url):
	if url[:4] != "http":
		url = "http://{}".format(url)
	
	try:	
		req	= session.get(url, headers=head, verify=False, timeout=10)
		res = req.url.lower().replace("%0d", "").replace("%0a", "")
					
		if req.status_code == 200 and res == url.replace("\r", ""):
			s_200.write(url+"\n")
			s_200.flush()
			print "{}[{}{}{}][{}{}{}] {}{}{}".format(Cl.wht, Cl.grn, req.status_code, Cl.wht, Cl.grn, datetime.now().strftime('%H:%M:%S'), Cl.wht, Cl.grn, url, Cl.end)
			
		elif req.status_code == 403 and res == url.replace("\r", ""):
			s_403.write(url+"\n")
			s_403.flush()
			print "{}[{}{}{}][{}{}{}] {}{}{}".format(Cl.wht, Cl.ylw, req.status_code, Cl.wht, Cl.ylw, datetime.now().strftime('%H:%M:%S'), Cl.wht, Cl.ylw, url, Cl.end)
			
		elif req.status_code >= 500 and res == url.replace("\r", ""):
			s_500.write(url+"\n")
			s_500.flush()
			print "{}[{}{}{}][{}{}{}] {}{}{}".format(Cl.wht, Cl.red, req.status_code, Cl.wht, Cl.red, datetime.now().strftime('%H:%M:%S'), Cl.wht, Cl.red, url, Cl.end)
		else:
			pass
	
	except requests.exceptions.ConnectionError:
		pass
	except requests.exceptions.Timeout:
		pass
	except KeyboardInterrupt:
		print "\n[!] Close Scanning..."
		s_200.close()
		s_403.close()
		s_500.close()
		exit(0)
	except Exception as e:
		print "[!][Error] {}".format(e)
			
	return True
	
def main():
	global head, session
	global s_200, s_403, s_500
	
	urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)
	
	s_200	= open("live.txt", "w")
	s_403	= open("forbidden.txt", "w")
	s_500	= open("server_error.txt", "w")
	session	= requests.Session()
	head	= { 
		"User-Agent" : "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:67.0) Gecko/20100101 Firefox/67.0",
		"Connection" : "Keep-Alive"
	}
	
	try :
		target	= [i for i in open(sys.argv[1]).read().split("\n") if i != ""]
	except IOError:
		print "[!][Error] No such file or directory: '{}'".format(sys.argv[1])
	except:
		print 	"[+] Usage: python file.py list.txt"
		exit(0)	
	
	for i in target:
		try:
			t = threading.Thread(target=check_shell, args=(i,))
			t.start()	
			#check_shell(i)
		except KeyboardInterrupt:
			print "\n[!] Close Scanning..."
			s_200.close()
			s_403.close()
			s_500.close()
			exit(0)
		except Exception as e:
			print "[!][Error] {}".format(e)
			
	return True
	
if __name__ == "__main__":
	try:
		main()
	except KeyboardInterrupt:
		print "\n[!] Close Scanning..."
		s_200.close()
		s_403.close()
		s_500.close()
		exit(0)
	except Exception as e:
		print "[!][Error] {}".format(e)