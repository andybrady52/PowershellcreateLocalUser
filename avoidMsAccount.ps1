
#function to get user details from CSV
function createFromCSV{
    
    $filepath = Read-Host -Prompt "Please enter filepath for the CSV file"

    $CSV = Import-Csv $filepath

    foreach($LINE in $CSV){
        $NewUser="$($LINE.USERNAME)"
        $NewPass="$($LINE.PASSWORD)" 
        $Description="$($LINE.DESCRIPTION)"
        $UserGroup="$($LINE.USERGROUP)"
        
        createUser $NewUser $UserGroup $NewPass $Description 
       
        
    }

}


#Function to enter user details manually
function manualUserDetails {
    #inititalise arrays
    $NewUser=@()
    $NewPass=@()
    $Description=@()
    $UserGroup=@()

    $numberOfUsers = read-host -Prompt "How many users would you like to create?"
    ""
    #repeat loop for the requested number of users
    for ($i=1; $i -le $numberOfUsers ; $i++){
    
        $NewUser += read-host -prompt "Please enter user name "
        ""
    
        DO{
            $pwd1 = Read-Host -Prompt "Enter Password  " -AsSecureString
            $pwd2 = Read-Host -Prompt "Confirm Password" -AsSecureString

            $pwd1_text = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($pwd1))
            $pwd2_text = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($pwd2))
        
        
            if ($pwd1_text -ne $pwd2_text){

                Write-Host "Passwords do not match, please re enter"
            }
        }while ($pwd1_text -ne $pwd2_text)
        $NewPass += $pwd2_text
        ""    
        $Description += Read-Host -Prompt "Please enter the new user description"

        ""
    ""
    Write-Host "================ Choose User Group ================"
    
    Write-Host "1: Press '1' for administrators"
    Write-Host "2: Press '2' for users."
    ""
    $selection = Read-Host "Please make a selection"
            ""
            switch ($selection)
            {
                '1' {
                    $UserGroup += "Administrators"
                } '2' {
                    $UserGroup += "Users"
                    
                } 'q' {
                    return
                }
            }
       
      
        
    }
    For ($i=0; $i -lt $NewUser.Length; $i++) {
    
        createUser $NewUser[$i] $UserGroup[$i] $NewPass[$i] $Description[$i]
    }
}

#Function to create the user
function createUser{
    param(
        [string]$NewUser,
        [string]$UserGroup,
        [string]$NewPass,
        [string]$Description
    )

    $SecurePass=ConvertTo-SecureString -AsPlainText -Force -String "$NewPass"

    
    write-host "Creating "$NewUser
    New-LocalUser -Name $NewUser -Password $SecurePass -FullName $NewUser -Description $Description
    write-host "Added user to " $UserGroup " group"
    "" 
    Add-LocalGroupMember -Group $UserGroup -Member $NewUser
    
}


#Read input from the user to decide which option to create users
$response = read-host -prompt "Would you like to create users manually or from CSV? m or c?"
""

if ($response -eq "c"){

    createFromCSV 

}else{

    manualUserDetails
}








