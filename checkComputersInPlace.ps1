param($ComputersFile)
#developed by some monkeys 
$number=0
$ComputersID = Import-Csv $ComputersFile | select Computers
Foreach ($ComputerID in $ComputersID) {
	Get-ADComputer $ComputerID.Computers  -Properties CanonicalName | select CanonicalName

	$number=$number +1
}
echo $number