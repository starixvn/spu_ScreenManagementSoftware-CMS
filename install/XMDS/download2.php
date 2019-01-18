<?php
global $dbhost;
global $dbuser;
global $dbpass;
global $dbname;
try
{
	$dbhost = '10.70.70.213:33309';
	$dbuser = 'sms';
	$dbpass = 'sms_@1234aa';
	$dbname = 'sms';

	// Create connection
	$conn = new mysqli($dbhost, $dbuser, $dbpass, $dbname);

	// Check connection
	if ($conn->connect_error) {
		header("HTTP/1.0 400 Connection failed");
		exit;    
	}

	if(!isset($_REQUEST['key']) || empty($_REQUEST['key'])) 
	{
		header("HTTP/1.0 400 Bad Request");
		exit;
	}

	$sql = "SELECT displayid FROM sms.display where license='". $_REQUEST['key'] ."'";
	$result = $conn->query($sql);

	if ($result->num_rows === 0) {
		header("HTTP/1.0 500 Could not found hardware key");
		exit;
	}       
}
catch (Exception $e) {	
	echo $e->getMessage();
}

mysqli_close($conn);


$file_name  = $_REQUEST['file'];
$chunk_offset = $_REQUEST['chunkoffset'];

$file_path  = '../../share/data/Library/' . $file_name;

if (is_file($file_path))
{
  
}

?>