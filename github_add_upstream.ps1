param (
    [string]$mirroredOrForkedFromUserName = "stereograph",
    [string]$mirroredOrForkedFromRepositoryName = "$5"#,
    #[string]$username = $(throw "-username is required."),
    #[string]$password = $( Read-Host "Input password, please" )
)

. (Resolve-Path "$env:LOCALAPPDATA\GitHub\shell.ps1")

#. $env:github_posh_git\profile.example.ps1
Import-Module $env:github_posh_git\posh-git

$cur = (get-location)
Write-host $cur

#$scriptpath = $MyInvocation.MyCommand.Path
#$dir = Split-Path $scriptpath

#cd $dir

$remotes = (git remote -v)
#Write-host $remotes

# must be single quotes
$exp = '(.*origin\s+)(https://github.com/)(.+)(/)(.+)(\s+\(fetch\).*)'

$url = ""

foreach($remote in $remotes)
{
    if ($remote -match $exp)
    {
        $tmp = '$2' + $mirroredOrForkedFromUserName + '$4' + $mirroredOrForkedFromRepositoryName 
        $url = $remote -replace $exp, $tmp
        break
    }
}
#Write-host $url

if ($url -eq "")
{
    Write-host "ERROR: could not determine repository url."
}
else
{
    Write-host "SUCCESS: " $url "has been set as upstream remote branch."
    git remote add $mirroredOrForkedFromUserName $url
}

#cd $cur
