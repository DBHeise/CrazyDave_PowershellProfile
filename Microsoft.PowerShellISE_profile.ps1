
Import-Module ProfileCommon
Initialize-Profile

Import-Module CopyModule
Import-Module PowerShellISEModule
Import-Module SnippetModule
Import-Module MenuModule

Import-Module ShowUI
Import-Module Pipeworks
Import-Module ScriptCop
Import-Module EZOut
Import-Module IsePackV2

$validateBlock = {
    if ($psISE.CurrentFile.Editor.SelectedText) {
        $filePath = "${Env:Temp}\temp.xml"
        Set-Content -PassThru $filePath -Value $psISE.CurrentFile.Editor.SelectedText
        $cleanUp = $true
    } else {
        if ($psISE.CurrentFile.IsSaved) {
            $filePath = $psISE.CurrentFile.FullPath
        } else {
            $filePath = "${Env:Temp}\temp.xml"
            Set-Content -PassThru $filePath -Value $psISE.CurrentFile.Editor.Text
            $cleanUp = $true
        }
    }

    if (Test-XML $filePath) {
        [System.Windows.Forms.MessageBox]::Show("XML document is valid.")
    } else {
        [System.Windows.Forms.MessageBox]::Show("Invalid XML document. Refer to console output!")
    }

    if ($cleanUp) {
        Remove-Item -Path "${Env:Temp}\temp.xml" -Force
        $cleanUp = $false
    }
}

$psISE.CurrentPowerShellTab.AddOnsMenu.Submenus.Add("Validate _XML",$validateBlock,"Ctrl+Alt+X")

$formatBlock = {
    if ($psISE.CurrentFile.Editor.SelectedText) {
        $filePath = "${Env:Temp}\temp.xml"
        Set-Content -PassThru $filePath -Value $psISE.CurrentFile.Editor.SelectedText
        $cleanUp = $true
    } else {
        if ($psISE.CurrentFile.IsSaved) {
            $filePath = $psISE.CurrentFile.FullPath
        } else {
            $filePath = "${Env:Temp}\temp.xml"
            Set-Content -PassThru $filePath -Value $psISE.CurrentFile.Editor.Text
            $cleanUp = $true
        }
    }

    if (Test-XML $filePath) {
        $psISE.CurrentFile.Editor.Text = Format-XML (Get-Content $filePath)
    } else {
        [System.Windows.Forms.MessageBox]::Show("Invalid XML document. Refer to console output!")
    }

    if ($cleanUp) {
        Remove-Item -Path "${Env:Temp}\temp.xml" -Force
        $cleanUp = $false
    }
}

$psISE.CurrentPowerShellTab.AddOnsMenu.Submenus.Add("Format _XML",$formatBlock,"Alt+X")
