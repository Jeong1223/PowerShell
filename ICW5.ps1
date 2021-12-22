# ICE5 - Error Handeling
# Jeong Eun Jang (w0451032)
# INET 3700 Server OS and Scripting
# George Campanis
# 2021. 11. 24


try {
    1/0
} 
catch [System.DivideByZeroException] {
    Write-Warning "Can't Divide By Zero"
}
catch [System.Management.Automation.RuntimeException] {
    Write-Warning "Can't Divide By Zero"
}
catch{
    Write-Warning "Encountered an unexpected error"
}
finally{ 
    Write-Host “Tying up all loose ends!”
}

