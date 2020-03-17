@echo off
TITLE ApkTools V0.1        By Edsuns@qq.com
color b

set apktool=apktool_2.4.1.jar

if "%~1"=="" goto addSortcut
if exist "%~1\bootinfo.txt" goto img
if exist "%~1\apktool.yml" goto B
if exist "%~f1\" goto eorr
if %~x1==.zip goto E
if %~x1==.ZIP goto E
if %~x1==.apk goto apk
if %~x1==.APK goto apk
if %~x1==.jar goto apk
if %~x1==.JAR goto apk
if %~x1==.img goto img
if %~x1==.IMG goto img
goto eorr

:apk
cls
echo.
echo.                   ѡ�����
echo.__________________________________________________
echo.
echo.   [1]���  [2]ǩ��  [3]��װ���  [4]ɾ�����
echo.
echo.
echo.   [0]α����
echo.__________________________________________________
echo.
echo.
set /p Ed=������Ų��س�ȷ��[1]:
cls
if "%Ed%"=="1" goto D
if "%Ed%"=="2" goto signer
if "%Ed%"=="3" goto F
if "%Ed%"=="4" goto F2
if "%Ed%"=="0" goto E
goto D
:F
echo.
java -jar "%~dp0bin\%apktool%" if %1
echo.I����װ�����ɣ�
echo.__________________________________________________________
echo.
set /p Ed=������ر�...<nul& pause>nul& exit
:F2
cls
echo.
rd /s /q "%USERPROFILE%\apktool\framework">nul 2>nul
echo.    framework�����ɾ����
echo.__________________________________________________________
echo.
set /p Ed=������ر�...<nul& pause>nul& exit
:D
echo.
echo.I�������ʼ��
java -jar "%~dp0bin\%apktool%" d -f -o "%~dpn1" %1
echo.I�����%~1���
echo.I������������Ƿ��д���
echo.__________________________________________________________
echo.
set /p Ed=������ر�...<nul& pause>nul& exit
:B
echo.
echo.[ ����%~1 ]
echo.
echo �Ƿ���ԭǩ����AndroidManifest.xml(y/n)
echo.__________________________________________________________
echo.
set /p Ed=���벢�س�ȷ��(y):
cls
echo.
echo.I�����뿪ʼ...
rd /s/q %~1\build>nul 2>nul
rd /s/q %~1\dist>nul 2>nul
if "%Ed%"=="n" (
java -jar "%~dp0bin\%apktool%" b -f %1
goto n
)
java -jar "%~dp0bin\%apktool%" b -f -c %1
goto y
:n
echo.I������ǩ��...
for /f "tokens=1* delims= " %%a in ('type "%~1\apktool.yml" ^|find "apkFileName: "') do (set Ed=%%b)
cd %~1\dist
java -jar "%~dp0bin\signapk.jar" "%~dp0bin\testkey.x509.pem" "%~dp0bin\testkey.pk8" "%Ed%" "Signed_%Ed%"
:y
echo.I��������ɣ�
explorer "%~1\dist\"
echo.I�����Զ������Ŀ¼
echo.I������������Ƿ��д���
echo.__________________________________________________________
echo.
set /p Ed=������ر�...<nul& pause>nul& exit
:signer
mode con cols=60 lines=15
color a1
cls
echo.
echo.  ����ǩ��%~1
java -jar "%~dp0bin\signapk.jar" "%~dp0bin\testkey.x509.pem" "%~dp0bin\testkey.pk8" %1 "%~n1_signed%~x1"
echo.  ǩ����ɣ�
echo.
echo.  ����ļ�:%~n1_signed%~x1
echo.
set /p Ed=������ر�...<nul& pause>nul& exit
:E
echo.
echo. �ļ�:%~nx1
echo.
echo. ����:[1]α���� [2]���� [3]ǩ��
echo._______________________________________ Edsuns@qq.com
echo.
echo.
set /p Ed=���벢�س�: 
cls
if "%Ed%"=="1" goto E1
if "%Ed%"=="2" goto E2
if "%Ed%"=="3" goto signer
goto E
:E1
echo.
echo.     α������...
java -jar "%~dp0bin\ZipCenOp.jar" e %1
echo._______________________________________ Edsuns@qq.com
echo.
echo.     ���Դ�����ʾ
echo.
echo.     α�������!
echo.
set /p Ed=������ر�...<nul& pause>nul& exit
:E2
echo.
echo.      ������...
java -jar "%~dp0bin\ZipCenOp.jar" r %1
echo._______________________________________ Edsuns@qq.com
echo.
echo.     ���Դ�����ʾ
echo.
echo.      �������!
echo.
set /p Ed=������ر�...<nul& pause>nul& exit

:img
mode con cols=64 lines=26
::cleandir
del /s/q "%~dp0cache">nul 2>nul
rd /s/q "%~dp0cache">nul 2>nul
md "%~dp0cache"
%~d0
cd "%~p0cache"
xcopy "%~dp0bin\bootimg.exe" "%cd%">nul
echo.
echo    ����������ڴ�Ӣ��·��ʹ��
echo _________________________________
echo.
if exist "%~1\" goto Repack

:Unpack
echo [ ��� %~1 ]
echo.
set /p Ed=���������...<nul& pause>nul
cls
echo.
xcopy "%~f1" "%cd%">nul
ren "%~nx1" "boot.img">nul
bootimg.exe --unpack-bootimg
del boot-old.img>nul
del boot.img>nul
del bootimg.exe >nul
del /s/q "%~dpn1">nul 2>nul
rd /s/q "%~dpn1">nul 2>nul
xcopy /e/i "%~dp0cache" "%~dpn1">nul
cd %~dp0
rd /s/q cache>nul
echo.
echo ���img��ɣ�
echo.
set /p Ed=������ر�...<nul& pause>nul& exit

:Repack
if not exist "%~1\initrd\" goto eorr
echo.
echo [ ��� %~1 ]
echo.
set /p Ed=���������...<nul& pause>nul
cls
echo.
xcopy /e/i "%~1" "%cd%">nul
bootimg.exe --repack-bootimg
ren "boot-new.img" "%~nx1-new.img">nul
xcopy /y "%~nx1-new.img" "%~dp1">nul
cd %~dp0
rd /s/q cache>nul
echo.
echo ���img��ɣ�
echo.
set /p Ed=������ر�...<nul& pause>nul& exit

:addSortcut
mode con cols=60 lines=15
echo.
echo. [1] �����Ҽ������͵�����ݷ�ʽ
echo.
echo. [0] ɾ���Ҽ������͵�����ݷ�ʽ
echo.
set /p Ed=���벢�س�(1): 
if "%Ed%"=="0" goto delSortcut
cls
echo.
cd %~dp0bin
mkSortcut /target:%~0 /shortcut:%USERPROFILE%\AppData\Roaming\Microsoft\Windows\SendTo\ApkTools
echo.�������
echo.
echo.������˳�...
pause>nul& exit
:delSortcut
cls
echo.
del "%USERPROFILE%\AppData\Roaming\Microsoft\Windows\SendTo\ApkTools.lnk"
echo.��ɾ��
echo.
echo.������˳�...
pause>nul& exit

:eorr
mode con cols=32 lines=12
color 4f
echo.
set /p Ed=Դ����֧�֣�������ر�...<nul& pause>nul& exit
