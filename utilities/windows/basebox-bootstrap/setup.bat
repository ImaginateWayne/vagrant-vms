@echo off
set I=echo [INFO] 
%I% Starting Windows Basebox Bootstrap
%I% 
%I% Initialise Logs
set LOG_DIR=%systemdrive%\logs
%I% Creating logs directory at %LOG_DIR%
mkdir %LOG_DIR%
%I% 
%I% Disable UAC from blocking Scripts
call reg ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA /t REG_DWORD /d 0 /f
%I% 
%I% Disable Shutdown Event Tracker
call reg ADD HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Reliability /v ShutdownReasonUI /t REG_DWORD /d 0 /f
call reg ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Reliability /v ShutdownReasonUI /t REG_DWORD /d 0 /f
%I% 
%I% Disable the Server Manager at startup
call call reg add HKLM\SOFTWARE\Microsoft\ServerManager /v DoNotOpenServerManagerAtLogon /t REG_DWORD /d 1 /f
%I% 
REM TODO Disable Any Service You Don't Need
REM - Print Spooler
REM - Windows Time
REM - Background Inteligent Transfer Service
REM - Windows Firewall
REM - Remote Registry
REM - NGEN Services 
%I% Disable Complex Passwords and Maximum Password age
set SEC_TPLT=%WINDIR%\security\templates
call xcopy vagrant.inf %SEC_TPLT%
call secedit /import /db %SEC_TPLT%\secedit.sdb /cfg %SEC_TPLT%\vagrant.inf /log %LOG_DIR%\secedit-import.log
call secedit /configure /db %SEC_TPLT%\secedit.sdb /cfg %SEC_TPLT%\vagrant.inf /log %LOG_DIR%\secedit-configure.log
call gpupdate
rem not sure if I need this?
rem call secedit /refreshpolicy machine_policy /enforce /quiet
%I% 
%I% Create Vagrant User
call net user vagrant vagrant /add
call net localgroup administrators vagrant /add
%I% 
%I% Set execution policy
powershell set-executionpolicy -executionpolicy remotesigned
%I% 
%I% Configuring winrm
call winrm quickconfig -q
call winrm set winrm/config/winrs @{MaxMemoryPerShellMB="512"}
call winrm set winrm/config @{MaxTimeoutms="1800000"}
call winrm set winrm/config/service @{AllowUnencrypted="true"}
call winrm set winrm/config/service/auth @{Basic="true"}
%I% 
echo Installing Puppet
msiexec /i bin\puppet-3.2.1.msi /qn /l %LOG_DIR%\puppet-install.log
echo Completed Windows Basebox Bootstrap
%I% Finished with %errorlevel%"
REM exit %errorlevel%