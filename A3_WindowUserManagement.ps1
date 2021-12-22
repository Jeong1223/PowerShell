<#
Jeong Eun Jang (w0451032)
INET 3700 Server OS and Scripting
George Campanis
2021. 11. 28

*** Assignment 3 - MS Windows User Management Scripting and Functions ***

Description
: This script includes creating and managing user account and group in Windows10 PowerShell. 
It also includes Event logs to write events on the computer.
#>

# Creating a new event log
New-EventLog -LogName myApp -Source "INET3700AS3" 

#1.Add a local user

function AddWindowsUser {

    [CmdletBinding()]  # advanced function, pass mutiple parameters
    param (
    [Parameter(Mandatory=$True)][string] $UserName,
    [Parameter(Mandatory=$True)][SecureString] $Password,
    [Parameter(Mandatory=$True)][string] $LocalGroup       
)

    try {

        $psd = (ConvertTo-SecureString $Password -AsPlainText -Force)
        New-LocalUser -Name $UserName -Password $psd -ErrorAction Stop
        New-LocalGroup -Name $LocalGroup -ErrorAction Stop  
        Write-EventLog -LogName myApp -ComputerName "$env:computername" -Source "INET3700AS3" -EntryType SuccessAudit -EventId 7001 -Message "Windows User Created"
    
    } catch {
    
        $message = $_
        Write-Warning "Oops, this username already exists. $message"
        Write-EventLog -LogName myApp -ComputerName "$env:computername" -Source "INET3700AS3" -EntryType FailureAudit -EventId 7002 -Message "Creating a Windows User failed."
    }    
}



#2. Change password

function ChangeUserPassword {

    [CmdletBinding()] 
    param (
    [Parameter(Mandatory=$True)][string] $UserName,
    [Parameter(Mandatory=$True)][SecureString] $Password
    )

    try {

        # Set-LocalUser -Name $UserName -Password $Password -Description "Password updated.    
        $Newpsd = (ConvertTo-SecureString $Password -AsPlainText -Force)
        $UserAccount = Get-LocalUser -Name $UserName
        $UserAccount | Set-LocalUser -Password $Newpsd -ErrorAction Stop
        Write-EventLog -LogName myApp -ComputerName "$env:computername" -Source "INET3700AS3" -EntryType SuccessAudit -EventId 7003 -Message "User password Updated."
    
    } catch {
    
        $message = $_
        Write-Warning "This username does not exist. $message"
        Write-EventLog -LogName myApp -ComputerName "$env:computername" -Source "INET3700AS3" -EntryType FailureAudit -EventId 7004 -Message "Changing password failed."
    
    }
}


#3. Add a user to an existing local group

function AddToLocalGroup {
    
    param (  

    [Parameter(Mandatory=$True)][string] $UserName,
    [Parameter(Mandatory=$True)][string] $LocalGroup
    )

    try {

        Add-LocalGroupMember -Group $LocalGroup -Member $UserName -ErrorAction Stop
        Write-EventLog -LogName myApp -ComputerName "$env:computername" -Source "INET3700AS3" -EntryType SuccessAudit -EventId 7005 -Message "User added to Local Group."
    
    } catch {
    
        $message = $_
        Write-Warning "Oops, check a group and a username again. $message"
        Write-EventLog -LogName myApp -ComputerName "$env:computername" -Source "INET3700AS3" -EntryType FailureAudit -EventId 7006 -Message "Adding a user to local group failed."
    
    }
}



#4. Remove a user

function RemoveWindowsUser {
    [CmdletBinding()]  # It turns a regular function into an advanced function for what if
    param (
        [Parameter(Mandatory=$True)][string] $UserName        
    )

    try {

        Remove-LocalUser -Name $UserName -WhatIf  -ErrorAction Stop
        Remove-LocalUser -Name $UserName -Confirm -ErrorAction Stop
        Write-EventLog -LogName myApp -ComputerName "$env:computername" -Source "INET3700AS3" -EntryType SuccessAudit -EventId 7007 -Message "Window User removed."
    
    } catch {
    
        $message = $_
        Write-Warning "Something happened.Check a username again! $message"
        Write-EventLog -LogName myApp -ComputerName "$env:computername" -Source "INET3700AS3" -EntryType FailureAudit -EventId 7008 -Message "Removing Window User failed."
    
    }     
}


#5. Remove a user from a local group

function RemoveFromLocalGroup {
    [CmdletBinding()]  
    param (  
    [Parameter(Mandatory=$True)][string] $UserName,
    [Parameter(Mandatory=$True)][string] $LocalGroup
    )
    
    try {

        Remove-LocalGroupMember -Member $UserName -Group $LocalGroup -WhatIf -ErrorAction Stop
        Remove-LocalGroupMember -Member $UserName -Group $LocalGroup -Confirm -ErrorAction Stop
        Write-EventLog -LogName myApp -ComputerName "$env:computername" -Source "INET3700AS3" -EntryType SuccessAudit -EventId 7009 -Message "A User removed from a group."
    
    } catch {
    
        $message = $_
        Write-Warning "An unexpected error occured. Check a group and a username again! $message"
        Write-EventLog -LogName myApp -ComputerName "$env:computername" -Source "INET3700AS3" -EntryType FailureAudit -EventId 7010 -Message "Removing a User from a group failed."
    
    }    
}

  