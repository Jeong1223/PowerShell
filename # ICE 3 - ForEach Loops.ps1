# ICE 3 - ForEach Loops
# Jeong Eun Jang (W0451032)
# INET 3700
# George Campanis

# Create the hash table with artists' information
$artist = @{FName="Bob"; LName="Marley"; Genre="Reggae"; Grade="A"},
@{FName="Sheryl"; LName="Crow"; Genre="Pop"; Grade="B"},
@{FName="Halsey"; LName="Smith"; Genre="Pop"; Grade="A"}

# Create a ForEach loop.
Foreach($a in $artist)
{
    if($a.Grade -eq "A"){
        "{0} {1} plays {2} {3}" -f $a.FName, $a.LName, $a.Genre, "and Passes!"
    } else {
        "{0} {1} plays {2} {3}" -f $a.FName, $a.LName, $a.Genre, "and Fails!"
    }
}
