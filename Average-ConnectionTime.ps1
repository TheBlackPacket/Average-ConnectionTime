function Average-ConnectionTime
{
	param ([array]$IPAddressSet)
	
	$ResArr = @()
	
	$Total = $IPAddressSet.count
	$Current = 0
	
	foreach ($TestIP in $IPAddressSet)
	{
		$Current++
		$percent = ($Current / $Total) * 100
		Write-Progress -Activity "Testing IP-Addresses" -status "$Current / $Total" -PercentComplete $percent
		
		$TestResults = Test-Connection -IPAddress $TestIP
		$TotalTime = 0
		
		foreach ($result in $TestResults)
		{
			$TotalTime += $result.ResponseTime
		}
		
		$time = $TotalTime / $TestResults.count
		
		$Res = New-Object System.Management.Automation.PSObject
		$Res | Add-Member -NotePropertyName "IP Address" -NotePropertyValue $TestIP
		$Res | Add-Member -NotePropertyName "Delay" -NotePropertyValue $time
		
		$ResArr += $Res
	}
	return $ResArr
}