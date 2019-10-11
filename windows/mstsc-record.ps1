
$AllUser = Get-WmiObject -Class Win32_UserAccount
foreach($User in $AllUser)
{
	$RegPath = "Registry::HKEY_USERS\"+$User.SID+"\Software\Microsoft\Terminal Server Client\Servers\"
	Write-Host "User:"$User.Name
	Write-Host "SID:"$User.SID
	Write-Host "Status:"$User.Status
	Try  
    	{ 
		$QueryPath = dir $RegPath -Name -ErrorAction Stop
	}
	Catch
	{
		Write-Host "No RDP Connections History"
		Write-Host "----------------------------------"
		continue
	}
	foreach($Name in $QueryPath)
	{   
		Try  
    		{  
    			$User = (Get-ItemProperty -Path $RegPath$Name -ErrorAction Stop).UsernameHint
    			Write-Host "User:"$User
    			Write-Host "Server:"$Name
    		}
    		Catch  
    		{
			Write-Host "No RDP Connections History"
    		}
	}
	Write-Host "----------------------------------"	
}