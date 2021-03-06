param($path)

#Made by monkeys and cryogenic-dreams
#Future versions: add more kitties and modularize

Function Get-FolderSize{
    #thanks Ed Wilson for the function

    param ($path)
    $fso = New-Object -comobject Scripting.FileSystemObject

    $folder = $fso.GetFolder($path)
    $size = $folder.size

    return $size
}

#big chunk of code

$fileName = Get-Item $path | select Name 
$fileName.Name = $fileName.Name + ".txt"

"----> FOLDER NAME: " + (Get-Item $path | select Name).Name + " <----`r`n" >> $fileName.Name


$folders = Get-childitem $path | where {$_.Attributes -eq “Directory”}
$files = Get-childitem $path -force | where {$_.Attributes -ne “Directory”}

"`r`n------------SUBFOLDERS-------------" >> $fileName.Name


$foldersPath = $folders | select FullName
Foreach ($folder in $foldersPath) {
    $size = Get-FolderSize $folder.FullName
    #client didn't ask for size format, so everything is in bytes (evil laugh): $size = $size / 1,024
    $name = get-item $folder.FullName | select Name
    $date = Get-item $folder.FullName | select CreationTime, LastWriteTime | Format-list
    "`r`n FOLDER NAME: "+ $name.Name + " | SIZE: " + $size + " bytes">> $fileName.Name
    $date >> $fileName.Name
}

$noFolders = ($folders).Count
"> NUMBER OF SUBFOLDERS: " + $noFolders >> $fileName.Name


"`r`n------------ARCHIVES---------------" >> $fileName.Name

$files | select Name, Length, CreationTime, LastWriteTime  | Format-list >> $fileName.Name
$noFiles = ($files).Count
"> NUMBER OF ARCHIVES: " + $noFiles >> $fileName.Name


" ">> $fileName.Name
"-----------------------------------">> $fileName.Name
" ">> $fileName.Name


$totalSize =  Get-FolderSize $path
$date2 = Get-item $path | select CreationTime, LastWriteTime | Format-list

"TOTAL SIZE: " + $totalSize >> $fileName.Name
$date2 >> $fileName.Name


#You lost 4d6 of sanity