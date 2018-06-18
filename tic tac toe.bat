@echo off
title Tick Tac Toe Game

:preset variables
::board
SET s1=1
SET s2=2
SET s3=3
SET s4=4
SET s5=5
SET s6=6
SET s7=7
SET s8=8
SET s9=9
::checks and controls
SET valid=FALSE
SET winner=FALSE
SET keyYES=y
SET keyNO=n
SET keyQUIT=q
SET pMove=10
SET free=%s1% %s2% %s3% %s4% %s5% %s6% %s7% %s8% %s9% 

:start
SET /P first="Are you going first? (%keyYES%/%keyNO%/%keyQUIT%) "
IF %first%==%keyQUIT% (EXIT)
::conferm selection and start
IF NOT "%first%"=="%keyNO%" (IF NOT "%first%"=="%keyYES%" (echo Please only use %keyYES%, %keyNO%, or %keyQUIT% && pause && goto preset variables))
CLS
echo|set /p="You are "
If "%first%"=="%keyNO%" (echo|set /p="not ")
echo going first!
pause
If "%first%"=="%keyNO%" (goto compMove)

:aab
::draw board
CLS
echo  %s1% ^| %s2% ^| %s3% 
echo ---^|---^|---
echo  %s4% ^| %s5% ^| %s6% 
echo ---^|---^|---
echo  %s7% ^| %s8% ^| %s9%
echo.
::array of board
SET free=%s1% %s2% %s3% %s4% %s5% %s6% %s7% %s8% %s9% 
::for %%a in (%free%) do (
::	echo %%a
::)

::get player move
SET /P pMove="Select a free postition "
::conferm player move
FOR %%b in (%free%) do (
	if %pMove%==%%b (SET valid=TRUE)
)
if %pMove%==X (SET valid=FALSE)
if %pMove%==O (SET valid=FALSE)
IF %valid%==FALSE (echo Invalid Space)
IF %valid%==FALSE (pause && goto aab)
IF %valid%==TRUE (SET s%pMove%=X&& SET valid=FALSE)
goto winCheck

:winCheck
call:victory X winner
::checks all possible win locations
::IF %s1%==X (IF %s2%==X (IF %s3%==X (SET winner=P)))
::IF %s4%==X (IF %s5%==X (IF %s6%==X (SET winner=P)))
::IF %s7%==X (IF %s8%==X (IF %s9%==X (SET winner=P)))
::IF %s1%==X (IF %s4%==X (IF %s7%==X (SET winner=P)))
::IF %s2%==X (IF %s5%==X (IF %s8%==X (SET winner=P)))
::IF %s3%==X (IF %s6%==X (IF %s9%==X (SET winner=P)))
::IF %s1%==X (IF %s5%==X (IF %s9%==X (SET winner=P)))
::IF %s7%==X (IF %s5%==X (IF %s3%==X (SET winner=P)))
IF %winner%==TRUE (CLS && echo You Won! && pause && goto preset variables )
goto tieCheckP

:loseCheck
::checks all possible lose locatons
::IF %s1%==O (IF %s2%==O (IF %s3%==O (SET winner=C)))
::IF %s4%==O (IF %s5%==O (IF %s6%==O (SET winner=C)))
::IF %s7%==O (IF %s8%==O (IF %s9%==O (SET winner=C)))
::IF %s1%==O (IF %s4%==O (IF %s7%==O (SET winner=C)))
::IF %s2%==O (IF %s5%==O (IF %s8%==O (SET winner=C)))
::IF %s3%==O (IF %s6%==O (IF %s9%==O (SET winner=C)))
::IF %s1%==O (IF %s5%==O (IF %s9%==O (SET winner=C)))
::IF %s7%==O (IF %s5%==O (IF %s3%==O (SET winner=C)))
call:victory O winner
IF %winner%==C (CLS && echo You Lose! && pause && goto preset variables )
goto tieCheckC

:tieCheckP
::checks if whole board is full after players move
IF NOT %s1%==1 (IF NOT %s2%==2 (IF NOT %s3%==3 (IF NOT %s4%==4 (IF NOT %s5%==5 (IF NOT %s6%==6 (IF NOT %s7%==7 (IF NOT %s8%==8 (IF NOT %s9%==9 (CLS && echo Draw! && pause && goto preset variables )))))))))
goto compMove

:tieCheckC
::checks if whole board is full after computers move
IF NOT %s1%==1 (IF NOT %s2%==2 (IF NOT %s3%==3 (IF NOT %s4%==4 (IF NOT %s5%==5 (IF NOT %s6%==6 (IF NOT %s7%==7 (IF NOT %s8%==8 (IF NOT %s9%==9 (CLS && echo Draw! && pause && goto preset variables )))))))))
goto aab

:compMove
::generates random numbers until one is a valid move
call:rand 9 comSpace
FOR %%b in (%free%) do (
	if %comSpace%==%%b (SET valid=TRUE)
)
if %comSpace%==X (SET valid=FALSE)
if %comSpace%==O (SET valid=FALSE)
if %comSpace%==%pMove% (SET valid=FALSE)
IF %valid%==FALSE (goto compMove)
IF %valid%==TRUE (SET s%comSpace%=O&& SET valid=FALSE)
goto loseCheck

:::::::::::::
::Functions::
:::::::::::::
:rand
::1=upper limit
::2=return
SET /a %~2=(%RANDOM% %% %~1)+1
goto:EOF

:victory
::1=piece to check
::2=return
IF %s1%==%~1 (IF %s2%==%~1 (IF %s3%==%~1 (SET %~2=TRUE)))
IF %s4%==%~1 (IF %s5%==%~1 (IF %s6%==%~1 (SET %~2=TRUE)))
IF %s7%==%~1 (IF %s8%==%~1 (IF %s9%==%~1 (SET %~2=TRUE)))
IF %s1%==%~1 (IF %s4%==%~1 (IF %s7%==%~1 (SET %~2=TRUE)))
IF %s2%==%~1 (IF %s5%==%~1 (IF %s8%==%~1 (SET %~2=TRUE)))
IF %s3%==%~1 (IF %s6%==%~1 (IF %s9%==%~1 (SET %~2=TRUE)))
IF %s1%==%~1 (IF %s5%==%~1 (IF %s9%==%~1 (SET %~2=TRUE)))
IF %s7%==%~1 (IF %s5%==%~1 (IF %s3%==%~1 (SET %~2=TRUE)))
goto:EOF