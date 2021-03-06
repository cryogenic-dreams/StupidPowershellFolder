param($UsersFile)
#developed by some monkeys 
#Disables User's smtp(s) setting it from xxxxx@companyname.es to baja_xxxxx@companyname.es


#not neccessary if you ran it before: .\Conexion.ps1
#need csv with a column named UserID

$UsersID = Import-Csv $UsersFile -delimiter ',' | select UserID
Foreach ($UserID in $UsersID) {
    $UserEmail = get-mailbox -id $UserID.UserID | select EmailAddresses  
    if ($UserEmail.EmailAddresses -like '*smtp*') {
        #redundance control
        $UserEmail.EmailAddresses = $UserEmail.EmailAddresses -replace 'baja_', ''
        
        #actual replace
        $UserEmail.EmailAddresses = $UserEmail.EmailAddresses -replace 'SMTP:', 'SMTP:baja_'
        Set-Mailbox -id $UserID.UserID -EmailAddresses $UserEmail.EmailAddresses
        
        #debug purposes
        get-mailbox -id $UserID.UserID | select EmailAddresses
    }
}