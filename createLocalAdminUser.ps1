echo "Please enter the new user name "
$userName = Read-Host
echo "Please enter the new user password "
$password = Read-Host -AsSecureString
echo "Which user group would you like to add the user to? "
$userGroup = Read-Host

echo "Please enter the new user description "
$userDescription = Read-Host

echo "Creating new user...."
New-LocalUser -Name $userName -Password $password -FullName $password -Description $userDescription
echo "Adding user to " $userGroup " group "
Add-LocalGroupMember -Group $userGroup -Member $userName