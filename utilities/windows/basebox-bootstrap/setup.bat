@echo off
set I=echo [INFO] 
%I% Starting Windows Basebox Bootstrap

echo Disable UAC from blocking Scripts
call reg ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA /t REG_DWORD /d 0 /f

echo Set execution policy
powershell set-executionpolicy -executionpolicy remotesigned

echo Configuring winrm
call winrm quickconfig -q
call winrm set winrm/config/winrs @{MaxMemoryPerShellMB="512"}
call winrm set winrm/config @{MaxTimeoutms="1800000"}
call winrm set winrm/config/service @{AllowUnencrypted="true"}
call winrm set winrm/config/service/auth @{Basic="true"}

set LOG_DIR=%systemdrive%\logs
echo Creating logs directory at %LOG_DIR%
mkdir %LOG_DIR%
echo Installing Puppet
msiexec /i bin\puppet-3.2.1.msi /qn /l %systemdrive%\logs\puppet-install.log
echo Completed Windows Basebox Bootstrap

REM exit %errorlevel%