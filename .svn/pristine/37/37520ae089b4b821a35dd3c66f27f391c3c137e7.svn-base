# 具体细节参考

# https://3gstudent.github.io/3gstudent.github.io/%E6%B8%97%E9%80%8F%E6%8A%80%E5%B7%A7-%E8%8E%B7%E5%BE%97Windows%E7%B3%BB%E7%BB%9F%E7%9A%84%E8%BF%9C%E7%A8%8B%E6%A1%8C%E9%9D%A2%E8%BF%9E%E6%8E%A5%E5%8E%86%E5%8F%B2%E8%AE%B0%E5%BD%95/
# https://rcoil.me/2018/05/%E5%85%B3%E4%BA%8Ewindows%E7%9A%84RDP%E8%BF%9E%E6%8E%A5%E8%AE%B0%E5%BD%95/

```pl
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
```