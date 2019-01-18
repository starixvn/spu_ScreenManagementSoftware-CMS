<?php 

$mc = new Memcached(); 
$mc->addServer("10.70.70.210", 11211); 

$mc->set("foo", "Hello1!"); 
$mc->set("bar", "Memcached..."); 

$arr = array( 
    $mc->get("foo"), 
    $mc->get("bar") 
); 
for ($i = 0; $i <  count($arr); $i++) {
    $key=key($arr);
    $val=$arr[$key];
    if ($val<> ' ') {
       echo $key ." = ".  $val ." <br> ";
       }
     next($arr);
    }
?>