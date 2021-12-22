# Assignment 4 - Task Scheduling and PowerShell
# Jeong Eun Jang (W0451032)
# INET 3700 Server OS and Scripting
# George Campanis
# Description: This script will create a scheduled task called 'scheduled Backup' and it will be run the 'BackupMyFiles.ps1' script on every 12 hours.


$principal = New-ScheduledTaskPrincipal -UserID "SYSTEM" -LogonType ServiceAccount -RunLevel Highest
$Sta = New-ScheduledTaskAction -Execute "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" -Argument '-ExecutionPolicy Bypass -Command "C:\temp\BackupMyFiles.ps1 -Backupdirs C:\Temp1, C:\Temp2 -Destination C:\TempBackup -Versions 2; exit $LASTEXITCODE"'
$Stt = New-ScheduledTaskTrigger -Once -At $(get-date)-RepetitionInterval $([timespan]::FromMinutes("1"))

Register-ScheduledTask -Taskname "Scheduled Backup" -Action $Sta -Trigger $Stt -Principal $principal