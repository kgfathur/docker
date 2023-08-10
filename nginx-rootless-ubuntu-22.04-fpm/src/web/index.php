<?php

$userAgent = $_SERVER['HTTP_USER_AGENT'];
$ipAddress = $_SERVER['SERVER_ADDR'];
$remoteAddress = $_SERVER['REMOTE_ADDR'];
$instanceID = getenv('HOSTNAME'); 
if(empty($instanceID)){
  $instanceID = gethostname();
}
if(strpos($userAgent, 'curl') !== false){
	$newLine = PHP_EOL;
} else {
	$newLine = "<br>";
}

print 'Client Address: ' . $remoteAddress . $newLine;
print 'Server Address: ' . $ipAddress . $newLine;
print 'Server Hostname: ' . $instanceID . $newLine;
?>