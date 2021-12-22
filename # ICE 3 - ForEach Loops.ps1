# ICE 3 - ForEach Loops
# Jeong Eun Jang (W0451032)
# INET 3700
# George Campanis

# Create the hash table with artists' information
$artist = @{FName="Bob"; LName="Marley"; Genre="Reggae"; Grade="A"},
@{FName="Sheryl"; LName="Crow"; Genre="Pop"; Grade="B"},
@{FName="Halsey"; LName="Frangipane"; Genre="Pop"; Grade="A"}

# Create a ForEach loop
Foreach($a in $artist)
{
    if($a.Grade -eq "A"){
        "$($a.FName) $($a.LName) plays $($a.Genre) and Passes!"
    } else {
        "$($a.FName) $($a.LName) plays $($a.Genre) and Fails!"
    }
} 



Foreach($p in $presidents) # grab each one of this
{
    if($p.LName -eq "Obama")
    {
        "This president: {0} {1} {2}" -f $p.FName, $p.LName, "was awesome!"
    } else {
        "This president: {0} {1} {2}" -f $p.FName, $p.LName, "was good, but not awesome!"
    }
}
