<?php
echo "212";
echo "<br/>";
function get_client_ip() {
    $ipaddress = '';
    if (isset($_SERVER['HTTP_CLIENT_IP']))
        $ipaddress = $_SERVER['HTTP_CLIENT_IP'];
    else if(isset($_SERVER['HTTP_X_FORWARDED_FOR']))
        $ipaddress = $_SERVER['HTTP_X_FORWARDED_FOR'];
    else if(isset($_SERVER['HTTP_X_FORWARDED']))
        $ipaddress = $_SERVER['HTTP_X_FORWARDED'];
    else if(isset($_SERVER['HTTP_FORWARDED_FOR']))
        $ipaddress = $_SERVER['HTTP_FORWARDED_FOR'];
    else if(isset($_SERVER['HTTP_FORWARDED']))
        $ipaddress = $_SERVER['HTTP_FORWARDED'];
    else if(isset($_SERVER['REMOTE_ADDR']))
        $ipaddress = $_SERVER['REMOTE_ADDR'];
    else
        $ipaddress = 'UNKNOWN';
    return $ipaddress;
}
$user_ip = get_client_ip();
$front_end = $_SERVER["REMOTE_ADDR"];
$back_end = $_SERVER["SERVER_ADDR"];
echo "Client IP: $user_ip"; 
echo "<br/>HAProxy Front End: $front_end";
echo "<br/>Backend: $back_end <br/>";
//var_dump($_SERVER);
//echo phpinfo();

// Show just the module information.
// phpinfo(8) yields identical results.
#phpinfo(INFO_MODULES);
$prtcol = $_SERVER["REQUEST_SCHEME"];
if(isset($_SERVER["HTTP_X_FORWARDED_PROTO"]))
{
	$prtcol = $_SERVER["HTTP_X_FORWARDED_PROTO"];
}
echo $prtcol;
while (list($var,$value) = each ($_SERVER)) {
      echo "$var => $value <br />";
   }
var_dum($_SERVER);
?>
