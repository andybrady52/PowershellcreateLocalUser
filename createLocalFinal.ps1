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





echo "Please enter the new user name "
$userName = Read-Host
echo "Please enter the new user password "
$password = Read-Host -AsSecureString

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

echo "Creating new user...."
New-LocalUser -Name $userName -Password $password -FullName $password -Description $userDescription
echo "Adding user to " $userGroup " group "
Add-LocalGroupMember -Group $userGroup -Member $userName