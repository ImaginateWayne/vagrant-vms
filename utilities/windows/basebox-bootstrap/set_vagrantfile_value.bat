@echo off
setlocal enabledelayedexpansion
set INTEXTFILE=vagrantfile.template
set TEMPTEXTFILE=temp
set OUTTEXTFILE=vagrantfile
set SETBOX=BOXNAME
set REPLACEBOX=%1
set SETBOXURL=BOXURL
set REPLACEBOXURL=%2
set SEARCHTEXT=BOXNAME
set REPLACETEXT=BATNAME
if exist %OUTTEXTFILE% del %OUTTEXTFILE%

for /f "tokens=1,* delims=¶" %%A in ( '"type %INTEXTFILE%"') do (
	set string=%%A
	set modified=!string:%SETBOX%=%REPLACEBOX%!
	echo. !modified! >> %TEMPTEXTFILE%
)

for /f "tokens=1,* delims=¶" %%A in ( '"type %TEMPTEXTFILE%"') do (
	set string=%%A
	set modified=!string:%SETBOXURL%=%REPLACEBOXURL%!
	echo. !modified! >> %OUTTEXTFILE%
)
del %TEMPTEXTFILE%