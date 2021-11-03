# Get-Process | Sort-Object -Property CPU | Select-Object -First 5

# help Get-Process


#Creating the array
$array = 25, 35, 55, 65, 85, 100
$passingGrade = 65

#Switch Statement
Switch ($array) #ICE Build Func
{
    {$_ -ge $passingGrade} {"$_, you passed."} # passed, more than 65
    {$_ -lt $passingGrade} {"$_, you failed."} # failed, equal to or less than 65
}

# Creating the hash tables with each student's information
$a=@{"FName"="Bob";"LName"="Marley";"Genre"="Reggae"; "Grade"="A"}
$b=@{"FName"="Sheryl";"LName"="Crow";"Genre"="Pop"; "Grade"="B"}
$c=@{"FName"="Halsey";"LName"="Smith";"Genre"="Pop"; "Grade"="A"}
$array = $a, $b, $c

# Loop and Conditions
Foreach ($e in $array.GetEnumerator()) {
    if ($e.Grade -ieq "A") {
        "$($e.FName) $($e.LName), $($e.Genre), PASS"
        }
    else {
        "$($e.FName) $($e.LName), $($e.Genre), FAIL"
    }
}

# Description: Create a PowerShell script that will perform the following tasks:
# 1.	Create a Scheduled Task called: “Scheduled Backup” (10 pts)
# 2.	Run the “BackupMyFiles.ps1” script  (3 pts)
# 3.	On a schedule every 12 hours (2 pts)
# 4.	The “BackupMyFiles.ps1” script should take in two parameters (10 pts)
# a.	Files to backup
# b.	Destination of the backups
# c.	The number of backups that must be saved before overwritten

$principal = New-ScheduledTaskPrincipal -UserID "SYSTEM" -LogonType ServiceAccount -RunLevel Highest
$Sta = New-ScheduledTaskAction -Execute "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" –Argument '-ExecutionPolicy Bypass -Command "C:\Users\Asus\OneDrive - Nova Scotia Community College\INET3700 Server_Operating_Systems_and_Scripting\Powershell Scripts\BackupMyFiles.ps1"
-Destination C:\TempBkp2\ -BackupDirs C:\temp\,C:\temp1\  -Versions 1; exit $LASTEXITCODE"'

$Stt = New-ScheduledTaskTrigger -Once -At $(get-date)-RepetitionInterval $([timespan]::FromHours("12")) 

Register-ScheduledTask -TaskName "Scheduled Backup" -Action $Sta -Trigger $Stt -Principal $principal

