<?php error_reporting(E_ALL ^ E_NOTICE);?>
<?php
if (!ini_get('display_errors')) {
    ini_set('display_errors', 1);
}
$SmtpServer="mailnex.nexcel.vn";
$SmtpPort="25"; //default
$SmtpUser="";
$SmtpPass="";

class SMTPClient
{

function SMTPClient ($SmtpServer, $SmtpPort, $SmtpUser, $SmtpPass, $from, $to, $subject, $body)
{

$this->SmtpServer = $SmtpServer;
//$this->SmtpUser = base64_encode ($SmtpUser);
//$this->SmtpPass = base64_encode ($SmtpPass);
$this->from = $from;
$this->to = $to;
$this->subject = $subject;
$this->body = $body;

if ($SmtpPort == "") 
{
$this->PortSMTP = 25;
}
else
{
$this->PortSMTP = $SmtpPort;
}
}

function SendMail ()
{
if ($SMTPIN = fsockopen ($this->SmtpServer, $this->PortSMTP)) 
{
fputs ($SMTPIN, "helo ".$HTTP_HOST."\r\n"); 
$talk["hello"] = fgets ( $SMTPIN, 1024 ); 
//fputs($SMTPIN, "auth login\r\n");
//$talk["res"]=fgets($SMTPIN,1024);
//fputs($SMTPIN, $this->SmtpUser."\r\n");
//$talk["user"]=fgets($SMTPIN,1024);
//fputs($SMTPIN, $this->SmtpPass."\r\n");
//$talk["pass"]=fgets($SMTPIN,256);
fputs ($SMTPIN, "MAIL FROM: <".$this->from.">\r\n"); 
$talk["From"] = fgets ( $SMTPIN, 1024 ); 
fputs ($SMTPIN, "RCPT TO: <".$this->to.">\r\n"); 
$talk["To"] = fgets ($SMTPIN, 1024); 
fputs($SMTPIN, "DATA\r\n");
$talk["data"]=fgets( $SMTPIN,1024 );
fputs($SMTPIN, "To: <".$this->to.">\r\nFrom: <".$this->from.">\r\nSubject:".$this->subject."\r\n\r\n\r\n".$this->body."\r\n.\r\n");
$talk["send"]=fgets($SMTPIN,256);
//CLOSE CONNECTION AND EXIT ... 
fputs ($SMTPIN, "QUIT\r\n"); 
fclose($SMTPIN); 
// 
} 
return $talk;
} 
}

?>

<?php

if($_SERVER["REQUEST_METHOD"] == "POST")
{
//for($i=0;$i<100;$i++){ //spam mail 
$to = $_POST['to'];
$from = $_POST['from'];
$subject = $_POST['sub'];
$body = $_POST['message'];
$SMTPMail = new SMTPClient ($SmtpServer, $SmtpPort, $SmtpUser, $SmtpPass, $from, $to, $subject, $body);
$SMTPChat = $SMTPMail->SendMail();
//back to main page
header("location:sendmail.php");
//}
}

?>

<form name="contactform" method="post" action="">
<table width="450px">
<h1>Send mail from SMTP server</h1>
<tr>
 <td valign="top">
  <label for="to">To: </label>
 </td>
 <td valign="top">
  <input  type="text" name="to" maxlength="50" size="30" value='<?php echo $to;?>' />
 </td>
</tr>
<tr>
 <td valign="top"">
  <label for="from">From: </label>
 </td>
 <td valign="top">
  <input  type="text" name="from" maxlength="50" size="30" value='<?php echo $from;?>' />
 </td>
</tr>
<tr>
 <td valign="top">
  <label for="sub">Subject:</label>
 </td>
 <td valign="top">
  <input  type="text" name="sub" maxlength="80" size="30" value='<?php echo $subject;?>' />
 </td>
</tr>
<tr>
 <td valign="top">
  <label for="message">Comments:</label>
 </td>
 <td valign="top">
  <textarea  name="message" maxlength="100000" cols="25" rows="6"><?php echo $body;?></textarea>
 </td>
</tr>
<tr>
 <td colspan="2" style="text-align:center">
  <input type="submit" value=" Send " />
  <input type="reset" value="Reset" /> 	
 </td>
</tr>
</table>
</form>
