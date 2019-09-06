@ECHO OFF

set SAUER_BIN=bin

IF /I "%PROCESSOR_ARCHITECTURE%" == "amd64" (
    set SAUER_BIN=bin64
)
IF /I "%PROCESSOR_ARCHITEW6432%" == "amd64" (
    set SAUER_BIN=bin64
)

FOR /f "tokens=4-7 delims=[.] " %%i IN ('ver') DO (
    IF %%i==Version (
	    set major_version=%%j
	    set minor_version=%%k
	    set patch_version=%%l
    ) ELSE (
        set major_version=%%i
	    set minor_version=%%j
	    set patch_version=%%k
    )
)

IF %major_version% GTR 10 (
    set SAUER_BIN=bin
) else (
    IF %major_version% EQU 10 (
	    IF %minor_version% GTR 0 (
		    set SAUER_BIN=bin
	    ) else (
            IF %patch_version% GEQ 16299 (
			    set SAUER_BIN=bin
			)
		)
	)
)
set SAUER_BIN=bin64

start %SAUER_BIN%\sauerbraten.exe "-q$HOME\My Games\Sauerbraten" -glog.txt %*
