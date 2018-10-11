
<html>
    <head>
    </head>
    <?php
    
    function bgcolor()
    {    
      $file = '/var/www/library/color.txt';
      // Open the file to get existing content
      $current = file_get_contents($file);
      
       if(strcmp("ff0000",$current)==0)
       {
          $current="ffff00"; 
                 
       }      
       else
       {
         $current="ff0000"; 
       }
       
    
      file_put_contents($file, $current); 
       return  $current;
    }
?>
    <body style="background:#<?php echo bgcolor(); ?>">    

    </body>
</html>