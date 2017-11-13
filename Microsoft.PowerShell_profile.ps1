set-alias vim "C:/Program Files (x86)/Vim/vim80/vim.exe"
set-alias v "C:/Program Files (x86)/Vim/vim80/vim.exe"
set-alias open "Invoke-Item"

Function zip($source, $dest)
{
     [io.compression.zipfile]::CreateFromDirectory($source, $dest)
}

# To edit the Powershell Profile
Function Edit-Profile
{
    vim $profile
}

# To edit Vim settings
Function Edit-Vimrc
{
    vim $HOME\_vimrc
}

Function CloudTest($setpt, $range, $state)
{    
     adb shell am broadcast -a TetraScience_Command --es "heater" $state  --es "output_range" $range
     if($setpt -ne '\0') {
          adb shell am broadcast -a TetraScience_Command --ef "setpoint" $setpt
     }
}

# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}
