@echo on
setlocal enabledelayedexpansion
rem we're gunna convert user messages into a binary string.

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

:main
	cls
	choice /c BMN /m "Record Mode:Byte file/Message File/None"
	if not %errorlevel%==3 (
		set /p recname=Record File name: 
	)
	if %errorlevel%==1 set rtype=stream
	if %errorlevel%==2 set rtype=msg
	set /p usermsg=Message("0"-"9", "A"-"B", "_", "." ^& keep it under 2,048 characters): 
	call :strlen0 usermsg msglen
	if /i %msglen% geq 2048 (
		set "msglen="
		set "usermsg="
		echo.
		echo Message is longer than 2,048 characters!
		echo.
		pause>nul
		goto main
	)
	set cch=0
	set "msgbin="
	:breakup
		set currchar=!usermsg:~%cch%,1!
		set currbyte=!_%currchar%_!
		if "%rtype%" == "stream" echo %currbyte%>>%recname%.txt
		set msgbin=%msgbin%%currbyte%
		set /a cch+=1
	if /i %cch% lss %msglen% goto breakup
	if "%rtype%" == "msg" echo %msgbin%>%recname%.txt
	echo.
	echo.
	echo %msgbin%
	pause>nul
exit
	
	
	
	

rem call :strlen0  StrVar  [RtnVar]
:strlen0
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






























