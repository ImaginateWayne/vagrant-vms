@echo on
set I=echo [INFO] 
%I% Starting Windows Basebox Export and Install
%I% 
set BASE_BOX=%~1
set VAGRANT_BOX_NAME=%~2
REM TODO test if VAGRANT_HOME is set use that 
if "%3" == "" (
   set VAGRANT_DIR=%SYSTEMDRIVE%\vagrant
)else (
   set VAGRANT_DIR=%~3
)
set VAGRANT_BOX=%VAGRANT_DIR%\%VAGRANT_BOX_NAME%.box
set VAGRANT_LOG=DEBUG

%I% 
%I% Generating Vagrant File
REM TODO VAGRANT_BOX should relative to VAGRANT_HOME or should insert the path to vagrant home
call set_vagrantfile_value.bat %VAGRANT_BOX% %VAGRANT_BOX%

%I% Creating new Vagrant Box "%VAGRANT_BOX%" from the Virtual Box file "%BASE_BOX%"
call vagrant package --base "%BASE_BOX%" --output "%VAGRANT_BOX%"

%I% 
%I% Adding "%VAGRANT_BOX_NAME%" to Vagrant
call vagrant box add "%VAGRANT_BOX_NAME%" "%VAGRANT_BOX%"

