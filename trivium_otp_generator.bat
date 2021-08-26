@echo off
setlocal enabledelayedexpansion
title Trivium One-Time Pad Generator
rem bin2hex encoding
set _0000=0
set _0001=1
set _0010=2
set _0011=3
set _0100=4
set _0101=5
set _0110=6
set _0111=7
set _1000=8
set _1001=9
set _1010=A
set _1011=B
set _1100=C
set _1101=D
set _1110=E
set _1111=F
rem hex2bin encoding
set _0=0000
set _1=0001
set _2=0010
set _3=0011
set _4=0100
set _5=0101
set _6=0110
set _7=0111
set _8=1000
set _9=1001
set _A=1010
set _B=1011
set _C=1100
set _D=1101
set _E=1110
set _F=1111
rem alphanumeric2binary encoding
set _0_=11011110
set _1_=11001100
set _2_=00010010
set _3_=00001011
set _4_=11000010
set _5_=00010111
set _6_=11010100
set _7_=10000000
set _8_=10000100
set _9_=01001011
set _A_=10000110
set _B_=00010101
set _C_=10100111
set _D_=01011000
set _E_=10000011
set _F_=10100101
set _G_=00011010
set _H_=01101100
set _I_=01010010
set _J_=10010100
set _K_=11101101
set _L_=00001111
set _M_=01111111
set _N_=00000011
set _O_=01000000
set _P_=00001010
set _Q_=11000111
set _R_=10001100
set _S_=01110101
set _T_=00100111
set _U_=01011011
set _V_=00110011
set _W_=10010011
set _X_=01000001
set _Y_=01101010
set _Z_=00100101
set ___=01000011
set _._=01010011
rem binary2alphanumeric encoding
set _11011110_=0
set _11001100_=1
set _00010010_=2
set _00001011_=3
set _11000010_=4
set _00010111_=5
set _11010100_=6
set _10000000_=7
set _10000100_=8
set _01001011_=9
set _10000110_=A
set _00010101_=B
set _10100111_=C
set _01011000_=D
set _10000011_=E
set _10100101_=F
set _00011010_=G
set _01101100_=H
set _01010010_=I
set _10010100_=J
set _11101101_=K
set _00001111_=L
set _01111111_=M
set _00000011_=N
set _01000000_=O
set _00001010_=P
set _11000111_=Q
set _10001100_=R
set _01110101_=S
set _00100111_=T
set _01011011_=U
set _00110011_=V
set _10010011_=W
set _01000001_=X
set _01101010_=Y
set _00100101_=Z
set _01000011_=_
set _01010011_=.

:mainpart
	cls
	echo.
	echo Welcome to my Trivium OTP Generator.
	echo.
	echo Would you like to Generate a new OTP,
	echo Reconstruct an old OTP, or Use an
	echo existing OTP?
	echo.
	choice /c GRU
if %errorlevel%==1 goto otpgen
if %errorlevel%==2 goto otprecon
if %errorlevel%==3 goto useotp

:otpgen
	cls
	echo.
	set /p outfname=Output File Name: 
	set /p entries=Number of Entries: 
	if /i not %entries% leq 2000000000 (
		echo User input too large. Can't generate...
		echo or rather batch is a little bitch ^& refuses
		echo to work with bigger numbers. so yeah, tone it down
		echo.
		pause
		goto mainpart
	)
	set /p entsize=How Alphanumeric Characters per Entry: 
	if /i not %entsize% leq 2000000000 (
		echo User input too large. Can't generate...
		echo or rather batch is a little bitch ^& refuses
		echo to work with bigger numbers. so yeah, tone it down.
		echo.
		pause
		goto mainpart
	)
	echo.
	set /p userkey=Key(will be reduced to an internal 80b key):	
	call :strlen userkey ukeylen
	if /i %ukeylen% lss 32 (
		cls
		echo.
		echo Key too short!
		echo Make sure that your key is at least 32 characters long.
		echo While Trivium does use an 80-bit internal key your passwords
		echo should optimalally be at least 50 characters to ensure security.
		echo A good strategy for coming up with good ^& easy to remember
		echo passwords is to choose 4 moderately long words, 7-12 letters
		echo each, to concatenate together with a random 4-digit number.
		echo Be mindful that encryption is only as good as your passwords.
		echo.
		pause
		goto mainpart
	)
	echo Setting up key ^& IV...
	set kblk=0
	:userkeydecomp
		set /a kblk+=1
		set ukcb%kblk%=%userkey:~0,10%
		set userkey=!userkey:~10,%ukeylen%!
	if not "%userkey%"=="" goto userkeydecomp
	call :strlen ukcb%kblk% lblocklen
	if not %lblocklen%==10 (
		set /a padd=10-%lblocklen%
	) else (
		goto afterpadd
	)
	:keypadding
		set ukcb%kblk%=!ukcb%kblk%!P
		set /a padd-=1
	if /i %padd% gtr 0 goto keypadding
	set kblk2=%kblk%
	set kblk3=%kblk%
	:afterpadd
		set kch0=!ukcb%kblk2%:~0,1!
		set kch1=!ukcb%kblk2%:~1,1!
		set kch2=!ukcb%kblk2%:~2,1!
		set kch3=!ukcb%kblk2%:~3,1!
		set kch4=!ukcb%kblk2%:~4,1!
		set kch5=!ukcb%kblk2%:~5,1!
		set kch6=!ukcb%kblk2%:~6,1!
		set kch7=!ukcb%kblk2%:~7,1!
		set kch8=!ukcb%kblk2%:~8,1!
		set kch9=!ukcb%kblk2%:~9,1!
		set kbin%kblk2%=!_%kch0%_!!_%kch1%_!!_%kch2%_!!_%kch3%_!!_%kch4%_!!_%kch5%_!!_%kch6%_!!_%kch7%_!!_%kch8%_!!_%kch9%_!
		set /a kblk2-=1
	if not %kblk2%==0 goto afterpadd
	for /l %%i in (0,1,9) do set set "kch%%i="
	set keystate=00000000000000000000000000000000000000000000000000000000000000000000000000000000
	:keyxorcompact
		for /l %%i in (0,1,79) do call :xorbits !keystate:~%%i,1! !kbin%kblk%:~%%i,1!
		set keystate=%xorres%
		set "xorres="
		set /a kblk-=1
	if not %kblk%==0 goto keyxorcompact
	for /l %%i in (1,1,%kblk3%) do set "kbin%%i="
	set "kblk="
	set "kblk2="
	set breg=%keystate%0000
	rem the IV setup
	set "keystate="
	set ivblk=%time::=%
	set ivblk=%ivblk:.=%%random%%random%%random%
	set ivblk=%ivblk: =%
	set ivblk=%ivblk:~0,10%
	rem ivblk now contains the numeric IV
	set biniv=!_%ivblk:~0,1%_!!_%ivblk:~1,1%_!!_%ivblk:~2,1%_!!_%ivblk:~3,1%_!!_%ivblk:~4,1%_!!_%ivblk:~5,1%_!!_%ivblk:~6,1%_!!_%ivblk:~7,1%_!!_%ivblk:~8,1%_!!_%ivblk:~9,1%_!
	set areg=%biniv%0000000000000
	set "biniv="
	set creg=000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
	rem time for the warmup phase
	echo Warming up Trivium...
	for /l %%i in (0,1,1152) do call :triviumcycle 0
	echo Generating OTP...
	echo %ivblk% > A-%outfname%_%ivblk%.txt
	rem and the actual OTP generation
	for /l %%i in (1,1,%entries%) do (
		for /l %%j in (1,1,%entsize%) do (
			call :triviumcycle 1
			call :nibblemaker %kout%
		)
		call :entryout %%i-
	)
	copy A-%outfname%_%ivblk%.txt B-%outfname%_%ivblk%.txt>nul
	set "entsize="
	set "entries="
	set "ivblk="
	set "outfname="
	
	echo Done.
	echo.
	echo.
	pause
goto mainpart

:otprecon
	
goto mainpart

:useotp
	
goto mainpart







rem operates on a 93, 84, & 111-bit binary strings respectively.
rem all regs starte at []reg0
rem call :triviumcycle [0/1]
rem 0=no output/1=output
:triviumcycle
	set /a aout=%areg:~92,1% ^^ %areg:~65,1% ^^ (%areg:~90,1% ^& %areg:~91,1%)
	set /a bout=%breg:~83,1% ^^ %breg:~68,1% ^^ (%breg:~81,1% ^& %breg:~82,1%)
	set /a cout=%creg:~110,1% ^^ %creg:~65,1% ^^ (%creg:~108,1% ^& %creg:~109,1%)
	set /a ain=%cout% ^^ %areg:~68,1%
	set /a bin=%aout% ^^ %breg:~77,1%
	set /a cin=%bout% ^^ %creg:~86,1%
	set areg=%ain%%areg:~0,92%
	set breg=%bin%%breg:~0,83%
	set creg=%cin%%creg:~0,110%
	if %1==1 set /a kout=%aout% ^^ %bout% ^^ %cout%
goto :eof

rem call :strlen  StrVar  [RtnVar]
:strlen
  set "s=#!%~1!"
  set "len=0"
  for %%N in (4096 2048 1024 512 256 128 64 32 16 8 4 2 1) do (
    if "!s:~%%N,1!" neq "" (
      set /a "len+=%%N"
      set "s=!s:~%%N!"
    )
  )
  set %~2=%len%
goto :eof

rem to xor two binary strings:
rem for /l %%i in (0,1,[strlen-1]) do call :xorbits ![strA]:~%%i! ![strB]:~%%i,1!
rem result will be stored in an ev called "xorres" so make sure to clear it before using
rem xorbits again. otherwise new result will just be concatenated onto xorres.
:xorbits
	set /a nbit=%1 ^^ %2
	set xorres=%xorres%%nbit%
goto :eof

:nibblemaker
	set cnib=%cnib%%kout%
	set /a bits+=1
	if %bits%==4 (
		set currentry=%currentry%!_%cnib%!
		set bits=0
		set "cnib="
	)
goto :eof


:entryout
	echo %~1 %currentry% >>A-%outfname%_%ivblk%.txt
	set "currentry="
goto :eof