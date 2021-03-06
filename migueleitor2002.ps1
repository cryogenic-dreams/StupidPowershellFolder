param($File1, $Column1, $File2, $Column2)
#for Miguel

$Rows = import-csv $File1 | select $Column1
Foreach ($Row in $Rows) {
    
    echo $Frase
    #stupid auxiliar string to add *
    $StringCaca = '*' + $Row.$Column1 + '*'
    #Coincidencias means Matches in Spanish

    if($Coincidencias = import-csv $File2 | Where-Object {$_.$Column2 -like $StringCaca}){
        #echo $Coincidencias
        foreach ($Coincidencia in $Coincidencias){
            $Frase = $Frase + $Row.$Column1 + " --> " + $Coincidencia.$Column2 + "`r`n"
        }
    }
    else{
	#Not matches found in Spanish
        $Frase = $Frase + $Row.$Column1 + " --> No se encontraron coincidencias `r`n"
    }
    $Frase = $Frase + "`r`n`r`n`r`n"
}
$Frase > coincidenciasencontradas.txt
