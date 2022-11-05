#Define menu
function Show-Menu
{
    param (
        [string]$Title = 'My Menu'
    )
    Clear-Host
    Write-Host "================ Choose User Group ================"
    
    Write-Host "1: Press '1' for administrators"
    Write-Host "2: Press '2' for users."
    
}




#Include option to create users from CSV file

$CSV? = Read-Host -Prompt "Would you like to create users from a CSV file? y/n"

if ($CSV? -eq "y")
{

    

    $filepath = Read-Host -Prompt "Please enter filepath for the CSV file"

    $CSV = Import-Csv $filepath


    foreach($LINE in $CSV)
    {
        $NewUser="$($LINE.USERNAME)"
        $NewPass="$($LINE.PASSWORD)" 
        $SecurePass=ConvertTo-SecureString –AsPlainText -Force -String "$NewPass"
        New-LocalUser -Name $NewUser -Password $SecurePass
        write-host $NewUser" Created"
    }
}else {

    #Enter user details 

    $userName = Read-Host -Prompt "Please enter the new user name "
    DO{
        $pwd1 = Read-Host -Prompt "Enter Password" -AsSecureString
        $pwd2 = Read-Host -Prompt "Confirm Password" -AsSecureString

        $pwd1_text = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($pwd1))
        $pwd2_text = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($pwd2))
        if ($pwd1_text -eq $pwd_text2){
            $pwd_final = $pwd2
        }

        if ($pwd1_text -ne $pwd2_text){

            Write-Host "Passwords do not match, please re enter"
        }
    }while ($pwd1_text -ne $pwd2_text)





    Show-Menu –Title 'My Menu'
    $selection = Read-Host "Please make a selection"
    switch ($selection)
    {
        '1' {
            $userGroup = "Administrators"
        } '2' {
            $userGroup = "Users"
            
        } 'q' {
            return
        }
    }


    echo "Please enter the new user description "
    $userDescription = Read-Host

    write-host "Creating "$userName
    New-LocalUser -Name $userName -Password $pwd2 -FullName $userName -Description $userDescription
    write-host "Added user to " $userGroup " group "
    Add-LocalGroupMember -Group $userGroup -Member $userName
    "";""
    }