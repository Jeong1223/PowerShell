

try {
    1/0
} 
catch [System.DivideByZeroException] {
    Write-Warning "Can't Divide By Zero"
}
catch [System.Management.Automation.RuntimeException] {
    Write-Warning "Can't Divide By Zero"
}
finally{ 
    Write-Host “Tying up all loose ends!”
}

#   "Encountered an unexpected error"

$one = 1
$zero = 0

try {
    $one/$zero
} 
catch [System.DivideByZeroException] {
    Write-Warning "Can't Divide By Zero"
}