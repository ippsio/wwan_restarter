@echo off
cd %~dp0
:checkMandatoryLevel
for /f "tokens=1 delims=," %%i in ('whoami /groups /FO CSV /NH') do (
  if "%%~i"=="BUILTIN\Administrators" (
    set ADMIN=yes
  )
  if "%%~i"=="Mandatory Label\High Mandatory Level" (
    set ELEVATED=yes
  )
)

if "%ADMIN%" neq "yes" (
  echo このファイルは管理者権限での実行が必要です{Administratorsグループでない}
   if "%1" neq "/R" goto runas
   goto exit1
)
if "%ELEVATED%" neq "yes" (
  echo このファイルは管理者権限での実行が必要です{プロセスが昇格されていない}
   if "%1" neq "/R" goto runas
   goto exit1
)

:admins
  "C:\Users\i\Desktop\devcon" disable "USB\Vid_0bdb&Pid_193e&Cdc_0d&Mi_06"
  "C:\Users\i\Desktop\devcon" enable "USB\Vid_0bdb&Pid_193e&Cdc_0d&Mi_06"
  goto exit1

:runas
  powershell -Command Start-Process -Verb runas "%0" -ArgumentList "/R" 
:exit1
