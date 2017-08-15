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
  echo ���̃t�@�C���͊Ǘ��Ҍ����ł̎��s���K�v�ł�{Administrators�O���[�v�łȂ�}
   if "%1" neq "/R" goto runas
   goto exit1
)
if "%ELEVATED%" neq "yes" (
  echo ���̃t�@�C���͊Ǘ��Ҍ����ł̎��s���K�v�ł�{�v���Z�X�����i����Ă��Ȃ�}
   if "%1" neq "/R" goto runas
   goto exit1
)

:admins
  devcon disable "USB\Vid_0bdb&Pid_193e&Cdc_0d&Mi_06"
  devcon enable "USB\Vid_0bdb&Pid_193e&Cdc_0d&Mi_06"
  goto exit1

:runas
  powershell -Command Start-Process -Verb runas "%0" -ArgumentList "/R" 
:exit1
pause