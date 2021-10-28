Get-ChildItem Variable: | Format-Table Name, Value, Description, options >> C:\temp\vars.txt
$file = Get-ChildItem "C:\temp\vars.txt"
$flSizeText="The size of the file is $([Math]::Round($file.Length/1KB,3)) kilobytes."
