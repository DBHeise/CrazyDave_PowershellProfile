
Get-ChildItem -Path $psScriptRoot -Recurse -Include *.ps1 | ForEach-Object { . $_.FullName }
