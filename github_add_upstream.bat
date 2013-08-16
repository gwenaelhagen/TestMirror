@echo off
::github_add_upstream.bat %mirroredOrForkedFromUserName% %mirroredOrForkedFromRepositoryName%
::your forked or your repository is forked from or mirrored form https://github.com/%mirroredOrForkedFromUserName%/%mirroredOrForkedFromUserName%.git
::by default %mirroredOrForkedFromUserName% = steregraph
::and %mirroredOrForkedFromUserName% = <name of your repository>

:: todo set defaults here instead of in the powershell script

setlocal

for /F "tokens=* USEBACKQ" %%F in (`powershell.exe Get-ExecutionPolicy`) do (
    set executionPolicy=%%F
)
powershell.exe Set-ExecutionPolicy RemoteSigned

powershell.exe -File %~dp0\github_add_upstream.ps1 -mirroredOrForkedFromUserName %1 -mirroredOrForkedFromRepositoryName "%2.git"

powershell.exe Set-ExecutionPolicy %executionPolicy%

echo.
pause

endlocal