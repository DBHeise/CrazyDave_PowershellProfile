Import-Module -Name Pscx
Import-Module -Name BitLocker
Import-Module -Name BitsTransfer
Import-Module -Name Dism
Import-Module -Name DnsClient
Import-Module -Name Hyper-V
Import-Module -Name IISAdministration
Import-Module -Name NetAdapter
Import-Module -Name NetConnection
Import-Module -Name NetEventPacketCapture
Import-Module -Name NetNat
Import-Module -Name NetSecurity
Import-Module -Name NetSwitchTeam
Import-Module -Name NetTCPIP
Import-Module -Name PKI
Import-Module -Name PlatformIdentifier
Import-Module -Name RemoteDesktop
Import-Module -Name ScheduledTasks
Import-Module -Name SecureBoot
Import-Module -Name SecurityCmdlets
Import-Module -Name ServerCore
Import-Module -Name ServerManager
Import-Module -Name ServerManagerTasks
Import-Module -Name Storage
Import-Module -Name TLS
Import-Module -Name TrustedPlatformModule
Import-Module -Name WebAdministration
Import-Module -Name WindowsDeveloperLicense
Import-Module -Name WindowsErrorReporting
Import-Module -Name WindowsUpdate

$scriptRoot = Join-Path $PSScriptRoot 'Scripts'

# Initialization
$initScript = Join-Path $scriptRoot 'init.ps1'
if (Test-Path $initScript) {
  . $initScript
}

# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

# Machine Specific Initialization
$computerScript = Join-Path $scriptRoot ('init-' + $env:computername + '.ps1')
if (Test-Path $computerScript) {
  . $computerScript
}

#Updating Type & Format
Update-TypeData -PrependPath $Env:USERPROFILE\Documents\WindowsPowershell\CustomTypes.ps1xml
Update-FormatData -PrependPath $Env:USERPROFILE\Documents\WindowsPowershell\FileFormat.format.ps1xml


cd $home