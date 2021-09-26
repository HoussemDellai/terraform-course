# not complete !

Get-ChildItem -Path C:\Test\

$content = Get-Content -Path 'C:\file.txt'

((Get-Content -path C:\ReplaceDemo.txt -Raw) -replace 'brown','white') | Set-Content -Path C:\ReplaceDemo.txt