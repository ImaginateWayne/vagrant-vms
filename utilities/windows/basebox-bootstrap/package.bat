@echo off
set I=echo [INFO] 
%I% Starting Windows Basebox Export and Install
%I% 
set BASE_BOX=%1
set VAGRANT_BOX_NAME=%2
if "%3" == "" (
   set VAGRANT_DIR=%SYSTEMDRIVE%\vagrant
)else (
   set VAGRANT_DIR=%3
)

set VAGRANT_BOX=%VAGRANT_DIR%\%VAGRANT_BOX_NAME%.box
vagrant package --base "C:\Users\gibbonsd\VirtualBox VMs\win2008\win2008.vbox" --output c:\vagrant\win2008.box

%I% Creating new Vagrant Box "%VAGRANT_BOX%" from the Virtual Box file "%BASE_BOX%"
vagrant package --base "%BASE_BOX%" --output "%VAGRANT_BOX%"

%I% 
%I% Adding "%VAGRANT_BOX_NAME%" to Vagrant
vagrant box add "%VAGRANT_BOX_NAME%" "%VAGRANT_BOX%"

%I% 
%I% Generating Vagrant File
call set_vagrant_value MYNAME MYBOX