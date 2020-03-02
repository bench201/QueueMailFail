$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri http://cloudexch2.exchangecloud.com.au/PowerShell/ -Authentication Kerberos #-Credential $cred
Import-PSSession $Session
$QueueMail=Get-Queue|?{$_.LastError -like "*Blocked*" -or $_.NextHopDomain -eq "gmail.com" -and $_.Status -eq "Retry"}|fl Identity,Status,NextHopDomain,LastError
Remove-Item C:\scripts\QueueMailFail.txt
if ($QueueMail)
{
	$QueueMail > C:\scripts\QueueMailFail.txt
}

exit