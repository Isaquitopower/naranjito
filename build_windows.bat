@echo off
echo ===================================================
echo   Compilando Naranjito para Windows (.exe Release)
echo ===================================================
call flutter pub get
call flutter build windows --release
echo.
echo Listo! El ejecutable y sus archivos estan en:
echo build\windows\x64\runner\Release\naranjito.exe
pause
