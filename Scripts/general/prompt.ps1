
function prompt { 
	$size = '32'
	$admin = 'non-Admin'
	$fg = 'DarkYellow'
	$bg = 'DarkMagenta'
	$promptChar = "☢"
	
	if ([System.IntPtr]::Size -eq 8) 
 	{$size = '64'} 
  
	
	$currentUser = [Security.Principal.WindowsIdentity]::GetCurrent() 
	$secprin = New-Object Security.Principal.WindowsPrincipal $currentUser 
	
	if ($secprin.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)) {
		$admin = 'Admin'
		$fg = 'Red'
		$bg = 'Black'
		$promptChar = "☣"
	}
  

	if ($NestedPromptLevel -gt 0) {$promptChar = $promptChar * $NestedPromptLevel; }
  
	$stack = (Get-Location -Stack).Count
	$nextCommandId = (Get-History -Count 1).Id + 1

	$host.ui.RawUI.WindowTitle = "$admin [x$size] : `($stack`) $(get-location)" 
	$promptStr = $nextCommandId.ToString().PadLeft(3, '0') + " " + $promptChar
	Write-Host $promptStr -ForegroundColor $fg -BackgroundColor $bg -NoNewLine
	return " "
}


$OutputEncoding = [System.Text.Encoding]::UTF8
[System.Console]::OutputEncoding = $OutputEncoding
$hostPD = (Get-Host).PrivateData
$hostPD.DebugForegroundColor = "Green"
$hostPD.VerboseForegroundColor = "Cyan"