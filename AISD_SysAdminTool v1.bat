@echo off
title AISD SysAdminTool v1
net session >nul 2>&1
if %ERRORLEVEL% neq 0 (
    color 04
    echo [ERROR] Please run this script as Administrator!
    pause > nul
    exit /b
)
rem Term Agreement -----------------------------------------------------------
 :agreement
 color 08
 echo.
 echo            db    88     Yb    dP 88 88b 88     88 .dP"Y8 8888b. 
 echo           dPYb   88      Yb  dP  88 88Yb88     88 `Ybo."  8I  Yb
 echo          dP__Yb  88  .o   YbdP   88 88 Y88     88 o.`Y8b  8I  dY
 echo         dP""""Yb 88ood8    YP    88 88  Y8     88 8bodP' 8888Y"
 echo.
 echo                                                ++++ 
 echo                                             ++++++  
 echo                                          +++++++    
 echo                                        ++++++++     
 echo                                       +++++++++     
 echo                                      +++++++++      
 echo                                    +++++++++++      
 echo                          ++       +++++  ++++       
 echo                          ++++++++++++++++++++       
 echo                            ++++++++++++++++++       
 echo                              +++++++++  +++++     + 
 echo                   +           ++++++   +++++      ++
 echo                   ++        +++++++    ++++++     ++
 echo                   +++++   ++++++++     ++++++    +++
 echo                    ++++++++++++++       ++++++++++++
 echo                      +++++++++++        +++++++++++ 
 echo                        +++++++            ++++++++  
 echo.
 echo  888888 888888  dP""b8 88  88 88b 88  dP"Yb  88      dP"Yb   dP""b8 Yb  dP
 echo    88   88__   dP   `" 88  88 88Yb88 dP   Yb 88     dP   Yb dP   `"  YbdP 
 echo    88   88""   Yb      888888 88 Y88 Yb   dP 88  .o Yb   dP Yb  "88   8P  
 echo    88   888888  YboodP 88  88 88  Y8  YbodP  88ood8  YbodP   YboodP  dP 
 echo.
 powershell Write-Host ' This script was intended for sysadmin use only, continue? (y/n)?:~$' -ForegroundColor Blue
 choice /c NYVWS /n
 if %errorlevel%==1 goto end
 if %errorlevel%==2 goto selection
 if %errorlevel%==3 goto version
 if %errorlevel%==4 (
    start https://github.com/txdylan/AISD-SysAdminTool/releases
    cls
    goto agreement
 )
 if %errorlevel%==5 goto ttsecurity
 rem Version Info -------------------------------------------------------------
     :version
     cls
     color 0f
     echo  OS Build: 
     powershell Write-Host '  - Minimum: Windows 10 22H2' -ForegroundColor red
     powershell Write-Host '  - Recommended: Windows 11 23H2 or later' -ForegroundColor DarkGreen
     echo.
     echo  Build Version: v1.0 Lite
     echo  Created By: TXDYLAN
     echo.
     powershell Write-Host -NoNewline ' Please reference ' -ForegroundColor White
     powershell Write-Host -NoNewline 'README.txt ' -ForegroundColor Blue
     powershell Write-Host 'for any issues you encounter.' -ForegroundColor White
     powershell Write-Host -NoNewline ' For further assistance or questions, please contact TXDYLAN at ' -ForegroundColor White
     powershell Write-Host 'affiliates@txdylan.com' -ForegroundColor Blue
     pause > nul
     cls
     goto agreement
 rem Main Selection -----------------------------------------------------------
     :selection
     cls
     color 0f
     powershell Write-Host ' Main Menu' -ForegroundColor Blue
     echo.
     echo   [0] Exit
     echo   [1] Domain Tools - For Domain Joined Devices
     echo   [2] Intune Commands
     echo   [3] Online Installs
     echo   [4] System Information
     echo   [5] Windows Commands
     echo.
     choice /c 012345 /n /m ":~$"
     if %errorlevel%==1 goto end
     if %errorlevel%==2 goto domain
     if %errorlevel%==3 goto intune
     if %errorlevel%==4 goto msstore
     if %errorlevel%==5 goto wininfo
     if %errorlevel%==6 goto wincommand
     rem Domain Tools -------------------------------------------------------------
         :domain
         cls
         color 0f
         powershell Write-Host ' Domain Tools is selected.' -ForegroundColor Blue
         echo.
         echo   [0] Back
         echo   [1] Message - Send messages to machines
         echo   [2] Remote Power - Restart or power down a computer remotely
         echo.
         choice /c 012 /n /m ":~$"
         if %errorlevel%==1 goto Selection
         if %errorlevel%==2 goto choosetarget
         if %errorlevel%==3 goto rmpower
         rem Send Message -------------------------------------------------------------
             :choosetarget
             cls
             setlocal enabledelayedexpansion
             color 0f
             powershell Write-Host ' LAN Messenger - Choose Host' -ForegroundColor Blue
             echo.
             set /p target=Enter target computer name or IP (or type "exit" to exit): 
             if /i "%target%"=="exit" goto domain
             if "%target%"=="" (
             powershell Write-Host ' You must enter a target.' -ForegroundColor Red
             timeout /t 2 >nul
             goto choosetarget
             )
             :chatMode
             cls
             powershell Write-Host ' Sending messages to: %target%' -ForegroundColor Blue
             echo.
             echo  Type "/change" to pick another host, "/exit" to exit.
             echo.
             :inputLoop
             set /p msg=Message: 
             if /i "!msg!"=="/exit" goto domain
             if /i "!msg!"=="/change" goto choosetarget
             if "!msg!"=="" goto inputLoop
             REM Send to all sessions on target. Replace * with a username if desired.
             msg /SERVER:%target% * "!msg!" 2>nul
             if errorlevel 1 (
             echo.
             powershell Write-Host ' Failed to send message. Common causes:' -ForegroundColor Red
             echo  - target unreachable, wrong name/IP
             echo  - port 445 blocked or Server service disabled on target
             echo  - permission/UAC/domain issues (admin credentials needed)
             echo.
             echo Press any key to continue...
             pause >nul
             )
             goto inputLoop
         rem Remote Power Options -----------------------------------------------------
             :rmpower
             cls
             setlocal enabledelayedexpansion
             color 0f
             powershell Write-Host ' Remote Power - Choose Host' -ForegroundColor Blue
             echo.
             set /p target=Enter target computer name or IP (or type "exit" to exit): 
             if /i "%target%"=="exit" goto domain
             if "%target%"=="" (
             powershell Write-Host ' You must enter a target.' -ForegroundColor Red
             timeout /t 2 >nul
             goto rmpower
             )
             cls
             powershell Write-Host ' Remote Power Menu - Computer: %TARGET%' -ForegroundColor Blue
             echo.
             echo   [0] Back
             echo   [1] Restart immediately
             echo   [2] Shutdown immediately
             echo   [3] Schedule restart (ask seconds)
             echo   [4] Abort pending shutdown/restart
             echo   [5] Display shutdown help on target (test connectivity)
             echo.
             choice /c 012345 /n /m ":~$"
             if %errorlevel%==1 goto rmpower
             if %errorlevel%==2 goto restart
             if %errorlevel%==3 goto shutdown
             if %errorlevel%==4 goto scheduled
             if %errorlevel%==5 goto abort
             if %errorlevel%==6 goto helpcheck
             :restart
             echo Restarting %TARGET% now...
             shutdown /m \\%TARGET% /r /t 0 /f
             goto rmpower
             :shutdown
             echo Shutting down %TARGET% now...
             shutdown /m \\%TARGET% /s /t 0 /f
             goto rmpower
             :scheduled
             set /p sec=Enter delay in seconds before restart (e.g. 60):
             if "%sec%"=="" set sec=60
             echo Scheduling restart on %TARGET% in %sec% seconds...
             shutdown /m \\%TARGET% /r /t %sec% /c "Scheduled by RemotePowerMenu" /f
             goto rmpower
             :abort
             echo Sending abort to %TARGET%...
             shutdown /m \\%TARGET% /a
             goto rmpower
             :helpcheck
             echo Running "shutdown /?" locally to show syntax...
             shutdown /?
             echo.
             echo Checking basic connectivity to \\%TARGET%...
             ping -n 2 %TARGET%
             echo If ping fails, remote commands will likely fail.
             goto rmpower
     rem Intune -------------------------------------------------------------------
         :intune
         cls
         color 0f                                                                                                                                               
         echo  vmi     mmm  Nd                                  RNI           
         echo  dINi    NNW                                     mN   dN        dN          vI 
         echo  dI N   N NW  Nr vII6N vNNWd0NR6NI  IW R  NI6INv1NNI66INI1      dN  NN0IIr 0NNNW N   IN  I IIR   0IIR           
         echo  dI 6I N6 IW  Nr Id    vN   Nr   NW IN1  NR   WI mN   dN        dN  NI  iN  mN   N   NR  Nv  I1 NW  iN           
         echo  dI  NNI  NW  Nr II    vN   IR   Nr   vN NI   IR mN   dN        dN  IR  rN  mN   N   NN  N   I1 Nd          
         echo  iW   W   W0  1v  rRI1  W    iNI1   RIR    RIW   r1    1N0      dN  NR  rN   NIR INNINN  N   I1 vNNNNi          
         echo -------------------------------------------------------------------------------------------------------
         powershell Write-Host 'Intune is Currently Selected.' -ForegroundColor Blue
         echo.
         echo   [0] Back
         echo   [1] Check Intune Management Status (MDM enrollment)
         echo   [2] Check Intune Management Extension Status
         echo   [3] Restart Intune Management Extension
         echo   [4] Resync
         echo.
         choice /c 01234 /n /m ":~$"
         if %errorlevel%==1 goto selection
         if %errorlevel%==2 goto idsregcmd
         if %errorlevel%==3 goto iime
         if %errorlevel%==4 goto iimer
         if %errorlevel%==5 goto isync
         rem Check Intune management status
             :idsregcmd
             dsregcmd /status
             pause > nul
             goto intune
         rem Intune Management Extension (IME)
             :iime
             sc query IntuneManagementExtension
             pause > nul
             goto intune
         rem Restart Intune Management Extension
             :iimer
             net stop IntuneManagementExtension
             rd /s /q "C:\ProgramData\Microsoft\IntuneManagementExtension\Content" >nul 2>&1
             rd /s /q "C:\ProgramData\Microsoft\IntuneManagementExtension\Policies" >nul 2>&1
             net start IntuneManagementExtension
             schtasks /run /tn "\Microsoft\Windows\EnterpriseMgmt\*"
             echo Task Completed.
             pause > nul
             goto intune
         rem Resync
             :isync
             dsregcmd /refreshprt
             start ms-settings:workplace
             goto intune
     rem Online Installs ----------------------------------------------------------
         :msstore
         cls
         color 0f
         powershell Write-Host ' Software Installs:' -ForegroundColor Blue
         echo.
         echo   [0] Back
         echo   [A] Adobe Acrobat PDF Reader
         echo   [C] Adobe Creative Cloud - Adobe Suite
         echo   [G] GitBash
         echo   [I] IPEVO Visualizer App
         echo   [1] Microsoft Company Portal App
         echo   [2] Microsoft Office 365 Suit
         echo   [3] Microsoft Outlook App
         echo   [4] Microsoft PC Manager
         echo   [5] Microsoft PowerToys
         echo   [6] Microsoft Quick Assist
         echo   [7] Microsoft Surface App
         echo   [T] Microsoft Teams
         echo   [D] Microsoft Wireless Display Adapter App
         echo   [8] Microsoft Whiteboard App
         echo   [9] Minecraft Education
         echo   [L] Logitech Unifying Software
         echo   [U] Update - Will Update all Applications
         echo   [V] VLC Player App
         echo   [P] Third Party Installs
         echo.
         choice /c 0ACGI1234567TD89LUVP /n /m ":~$"
         if %errorlevel%==1 goto selection
         if %errorlevel%==2 goto aar
         if %errorlevel%==3 goto acc
         if %errorlevel%==4 goto gitbash
         if %errorlevel%==5 goto ipevo
         if %errorlevel%==6 goto mscp
         if %errorlevel%==7 goto office365
         if %errorlevel%==8 goto outlook
         if %errorlevel%==9 goto pcmanager
         if %errorlevel%==10 goto powertoys
         if %errorlevel%==11 goto quickassist
         if %errorlevel%==12 goto surface
         if %errorlevel%==13 goto teams
         if %errorlevel%==14 goto wd
         if %errorlevel%==15 goto mswhiteboard
         if %errorlevel%==16 goto minecraftedu
         if %errorlevel%==17 goto unifying
         if %errorlevel%==18 goto msupdate
         if %errorlevel%==19 goto vlc
         if %errorlevel%==20 goto 3pi
         rem Adobe Acrobat Reader DC --------------------------------------------------
             :aar
             "%LOCALAPPDATA%\Microsoft\WindowsApps\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe\winget.exe" install XPDP273C0XHQH2
             echo Task Completed.
             pause > nul
             goto msstore 
         rem Adobe Creative Cloud -----------------------------------------------------
             :acc
             "%LOCALAPPDATA%\Microsoft\WindowsApps\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe\winget.exe" install Adobe.CreativeCloud
             echo Task Completed.
             pause > nul
             goto msstore 
         rem GitBash ------------------------------------------------------------------
             :gitbash
             "%LOCALAPPDATA%\Microsoft\WindowsApps\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe\winget.exe" install Git.Git
             echo Task Completed.
             pause > nul
             goto msstore 
         rem IPEVO Visualizer App -----------------------------------------------------
             :ipevo
             "%LOCALAPPDATA%\Microsoft\WindowsApps\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe\winget.exe" install 79PFXWFL0PB4S
             echo Task Completed.
             pause > nul
             goto msstore
         rem Microsoft Company Portal App ---------------------------------------------
             :mscp
             "%LOCALAPPDATA%\Microsoft\WindowsApps\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe\winget.exe" install 9WZDNCRFJ3PZ
             echo Task Completed.
             pause > nul
             goto msstore
         rem Microsoft Office 365 Suit ------------------------------------------------
             :office365
             "%LOCALAPPDATA%\Microsoft\WindowsApps\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe\winget.exe" install Microsoft.Office
             echo Task Completed.
             pause > nul
             goto msstore
         rem Microsoft Outlook App ----------------------------------------------------
             :outlook
             "%LOCALAPPDATA%\Microsoft\WindowsApps\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe\winget.exe" install 9NRX63209R7B
             echo Task Completed
             pause > nul
             goto msstore
         rem Microsoft PC Manager -----------------------------------------------------
             :pcmanager
             "%LOCALAPPDATA%\Microsoft\WindowsApps\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe\winget.exe" install 9PM860492SZD
             echo Task Completed.
             pause > nul
             goto msstore
         rem Microsoft PowerToys ------------------------------------------------------
             :powertoys
             "%LOCALAPPDATA%\Microsoft\WindowsApps\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe\winget.exe" install Microsoft.PowerToys
             echo Task Completed.
             pause > nul
             goto msstore
         rem Microsoft Quick Assist ---------------------------------------------------
             :quickassist
             "%LOCALAPPDATA%\Microsoft\WindowsApps\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe\winget.exe" install 9P7BP5VNWKX5
             echo Task Completed.
             pause > nul
             goto msstore
         rem Microsoft Surface App ----------------------------------------------------
             :surface
             "%LOCALAPPDATA%\Microsoft\WindowsApps\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe\winget.exe" install 9WZDNCRFJB8P
             echo Task Completed.
             pause > nul
             goto msstore
         rem Microsoft Teams ----------------------------------------------------------
             :teams
             "%LOCALAPPDATA%\Microsoft\WindowsApps\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe\winget.exe" install Microsoft.Teams
             echo Task Completed.
             pause > nul
             goto msstore
         rem Microsoft Wireless Display Adapter App -----------------------------------
             :wd
             "%LOCALAPPDATA%\Microsoft\WindowsApps\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe\winget.exe" install 9WZDNCRFJBB1
             echo Task Completed.
             pause > nul
             goto msstore
         rem Microsoft Whiteboard App -------------------------------------------------
             :mswhiteboard
             "%LOCALAPPDATA%\Microsoft\WindowsApps\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe\winget.exe" install 9MSPC6MP8FM4
             echo Task Completed.
             pause > nul
             goto msstore
         rem Minecraft Education ------------------------------------------------------
             :minecraftedu
             "%LOCALAPPDATA%\Microsoft\WindowsApps\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe\winget.exe" install 9NBLGGH4R2R6
             echo Task Completed.
             pause > nul
             goto msstore
         rem Logitech Unifying Software -----------------------------------------------
             :unifying
             "%LOCALAPPDATA%\Microsoft\WindowsApps\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe\winget.exe" install Logitech.UnifyingSoftware
             echo Task Completed.
             pause > nul
             goto msstore
         rem Update -------------------------------------------------------------------
             :msupdate
             "%LOCALAPPDATA%\Microsoft\WindowsApps\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe\winget.exe" update --all --include-unknown --accept-source-agreements --accept-package-agreements
             echo Task Completed.
             pause > nul
             goto msstore
         rem VLC Player App -----------------------------------------------------------
             :vlc
             "%LOCALAPPDATA%\Microsoft\WindowsApps\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe\winget.exe" install XPDM1ZW6815MQM
             echo Task Completed.
             pause > nul
             goto msstore
         rem Third Party Installs -----------------------------------------------------
             :3pi
             cls
             powershell Write-Host 'Third Party Installs:' -ForegroundColor Blue
             powershell Write-Host '!!Install Chocolatey first if you have not already!!' -ForegroundColor Yellow
             echo.
             echo   [0] Back
             echo   [C] Chocolatey Package Manager
             echo   [1] Dell Support Assist
             echo   [2] HP Support Assist
             echo   [3] Mitel Connect
             echo   [4] Vexcode V5
             echo.
             choice /c 0C1234 /n /m ":~$"
             if %errorlevel%==1 goto msstore
             if %errorlevel%==2 goto 3piinstall
             if %errorlevel%==3 goto dellsupport
             if %errorlevel%==4 goto hpsupport
             if %errorlevel%==5 goto mitel
             if %errorlevel%==6 goto vex5
             rem Chocolatey Package Installer ---------------------------------------------
                 :3piinstall
                 cls
                 echo Are you sure you want to install Chocolatey?
                 echo   [Y]Yes/[N]No
                 echo.
                 choice /c YN /n /m ":~$"
                 if %errorlevel%==1 goto 3piinstallyes
                 if %errorlevel%==2 goto 3pi
                 rem Connect Yes --------------------------------------------------------------
                     :3piinstallyes
                     powershell Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
                     goto 3pi
             rem Dell Support Assist ------------------------------------------------------
                 :dellsupport
                 %ProgramData%\chocolatey\bin\choco.exe" install supportassist -y --no-progress
                 echo Task Completed.
                 pause > nul
                 goto 3pi
             rem HP Support Assist --------------------------------------------------------
                 :hpsupport
                 %ProgramData%\chocolatey\bin\choco.exe" install hpsupportassistant -y --no-progress
                 echo Task Completed.
                 pause > nul
                 goto 3pi
             rem Mitel Connect ------------------------------------------------------------
                 :mitel
                 %ProgramData%\chocolatey\bin\choco.exe" install MitelConnect -y --no-progress
                 echo Task Completed.
                 pause > nul
                 goto 3pi
             rem Vexcode V5 ---------------------------------------------------------------
                 :vex5
                 %ProgramData%\chocolatey\bin\choco.exe" install vexcode -y --no-progress
                 echo Task Completed.
                 pause > nul
                 goto 3pi
     rem System Information -------------------------------------------------------
         :wininfo
         cls
         color 0f
         powershell Write-Host ' Information' -ForegroundColor Blue
         %SystemRoot%\System32\systeminfo.exe
         pause > nul
         goto Selection
     rem Windows Command ----------------------------------------------------------
         rem Command Page 1 -----------------------------------------------------------
             :wincommand
             cls
             color 0f
             powershell Write-Host ' Windows Command Menu is selected. (Page 1 of 2)' -ForegroundColor Blue
             echo.
             powershell Write-Host ' Use [A] and [D] to navigate the pages.' -ForegroundColor DarkGray
             echo.
             echo   [0] Back
             echo   [1] Bitlocker Info - System Bitlocker Code
             echo   [2] Delete Profiles - Shortcut to remove user profiles
             echo   [3] Device Manager - Admin Shortcut
             echo   [4] Network Reset - System Network Repair
             echo   [5] Rename - Rename The Computer System
             echo   [6] System Clean - Deletes System Temporary Files
             echo   [7] Time Sync - Sync System Clock
             echo   [8] Verbo - Enables System Messages During Boot         
             echo.
             choice /c 0D12345678R9 /n /m ":~$"
             if %errorlevel%==1 goto selection
             if %errorlevel%==2 goto wincommand2
             if %errorlevel%==3 goto commandbitlockercode
             if %errorlevel%==4 goto commandprofile
             if %errorlevel%==5 goto commanddevmgmt
             if %errorlevel%==6 goto commandnet
             if %errorlevel%==7 goto commandrename
             if %errorlevel%==8 goto commandclean
             if %errorlevel%==9 goto commandtime
             if %errorlevel%==10 goto commandverbo
             rem Bitlocker Info -----------------------------------------------------------
                 :commandbitlockercode
                 %SystemRoot%\System32\manage-bde.exe -status
                 %SystemRoot%\System32\manage-bde.exe -protectors C: -get
                 pause > nul
                 goto wincommand
             rem Delete Profiles ----------------------------------------------------------
                 :commandprofile
                 %SystemRoot%\System32\SystemPropertiesAdvanced.exe
                 goto wincommand
             rem Device Manager -----------------------------------------------------------
                 :commanddevmgmt
                 %SystemRoot%\System32\devmgmt.msc
                 goto wincommand
             rem Network Reset ------------------------------------------------------------
                 :commandnet
                 netsh winsock reset
                 netsh int ip reset
                 ipconfig /release
                 ipconfig /renew
                 ipconfig /flushdns
                 start "" "https://www.msftconnecttest.com/redirect"
                 echo Task Completed.
                 pause > nul
                 goto wincommand
             rem Rename PC ----------------------------------------------------------------
                 :commandrename
                 hostname
                 echo.
                 set /p newname=Enter the new PC name: 
                 %SystemRoot%\System32\WMIC.exe computersystem where name="%computername%" call rename name="%newname%"
                 echo PC name has been changed to %newname%.
                 echo.
                 choice /c YN /n /m "Would you like to restart now (y/n)?:~$"
                 if %errorlevel%==1 %SystemRoot%\System32\shutdown.exe /r /f /t 0
                 if %errorlevel%==2 goto wincommand
             rem System Clean -------------------------------------------------------------
                 :commandclean
                 echo Cleaning System...
                 del /q /f /s %TEMP%\* && del /q /f /s "%SystemRoot%\Temp\*" >nul 2>&1
                 for /d %%i in ("%SystemRoot%\Prefetch\*") do rd /s /q "%%i" >nul 2>&1
                 for /d %%i in ("%LOCALAPPDATA%\Temp\*") do rd /s /q "%%i" >nul 2>&1
                 for /d %%i in ("%LOCALAPPDATA%\Package Cache\*") do rd /s /q "%%i" >nul 2>&1
                 for /d %%i in ("%LOCALAPPDATA%\D3DSCache\*") do rd /s /q "%%i" >nul 2>&1
                 for /d %%i in ("%LOCALAPPDATA%\CrashDumps\*") do rd /s /q "%%i" >nul 2>&1
                 for /d %%i in ("%LOCALLOWAPPDATA%\Temp\*") do rd /s /q "%%i" >nul 2>&1
                 for /d %%i in ("%SystemRoot%\System32\config\systemprofile\AppData\Local\mdm\*") do rd /s /q "%%i" >nul 2>&1
                 for /d %%i in ("%SystemRoot%\System32\config\systemprofile\AppData\Local\CrashDumps\*") do rd /s /q "%%i" >nul 2>&1
                 for /d %%i in ("%SystemRoot%\System32\config\systemprofile\AppData\Local\D3DSCache\*") do rd /s /q "%%i" >nul 2>&1
                 for /d %%i in ("C:\ProgramData\Packages\Microsoft.MixedReality.Portal_8wekyb3d8bbwe") do rd /s /q "%%i" >nul 2>&1
                 for /d %%i in ("C:\ProgramData\Packages\Microsoft.GetHelp_8wekyb3d8bbwe") do rd /s /q "%%i" >nul 2>&1
                 for /d %%i in ("C:\ProgramData\Packages\Microsoft.YourPhone_8wekyb3d8bbwe") do rd /s /q "%%i" >nul 2>&1
                 rd /s /q "C:\ProgramData\Microsoft\IntuneManagementExtension\Cache" >nul 2>&1
                 powershell -NoProfile -Command "Clear-RecycleBin -Force -ErrorAction SilentlyContinue"
                 echo ------------------------------------------------------------------------------
                 echo After the Disk Cleanup completes, please press "OK" on the Disk Space Notification.
                 %SystemRoot%\System32\cleanmgr.exe /verylowdisk /d
                 pause
                 powershell Write-Host ' Desktop Refreshing, Screen Will Flash' -ForegroundColor Blue
                 timeout /t 2
                 taskkill /F /IM explorer.exe >nul 2>&1 & start "" explorer.exe
                 timeout /t 3
                 echo Task Completed.
                 pause > nul
                 goto wincommand
             rem Time Sync ----------------------------------------------------------------
                 :commandtime
                 %SystemRoot%\System32\net.exe start w32time >nul 2>&1
                 timeout /t 10
                 %SystemRoot%\System32\w32tm.exe /resync >nul 2>&1
                 echo Task Completed.
                 pause > nul
                 goto wincommand
             rem Verbo --------------------------------------------------------------------
                 :commandverbo
                 %SystemRoot%\System32\reg.exe add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v verbosestatus /t REG_DWORD /d 1 /f >nul 2>&1
                 echo Task Completed.
                 pause > nul
                 goto wincommand
         rem Command Page 2 -----------------------------------------------------------
                 :wincommand2
                 cls
                 color 0f
                 powershell Write-Host ' Windows Command Menu is selected. (Page 2 of 2)' -ForegroundColor Blue
                 echo.
                 powershell Write-Host ' Use [A] and [D] to navigate the pages.' -ForegroundColor DarkGray
                 echo.
                 echo   [0] Back
                 echo   [1] Windows 11 Force Install
                 echo   [2] Windows OS Repair - Restore and fixes Windows system files
                 echo   [3] Windows Update Repair - Fixes issues with updating Windows       
                 echo.
                 choice /c 0AD123 /n /m ":~$"
                 if %errorlevel%==1 goto selection
                 if %errorlevel%==2 goto wincommand
                 if %errorlevel%==3 goto wincommand2
                 if %errorlevel%==4 goto win11u
                 if %errorlevel%==5 goto commandwinrepair
                 if %errorlevel%==6 goto commandwinupdate
                 if %errorlevel%== goto 
                 if %errorlevel%== goto 
                 if %errorlevel%== goto 
                 if %errorlevel%== goto 
             rem Windows 11 Force Install -------------------------------------------------
                 :win11u
                 d:
                 cd sources
                 "%D%\setupprep.exe" /product server
                 pause > nul
                 goto wincommand2
             rem Windows OS Repair --------------------------------------------------------
                 :commandwinrepair
                 %SystemRoot%\System32\chkdsk.exe /f
                 %SystemRoot%\System32\DISM.exe /Online /Cleanup-Image /CheckHealth
                 %SystemRoot%\System32\sfc.exe /scannow
                 %SystemRoot%\System32\UsoClient.exe ScanInstallWait
                 echo Task Completed.
                 pause > nul
                 goto wincommand2
             rem Windows Update Repair ----------------------------------------------------
                 :commandwinupdate
                 %SystemRoot%\System32\sc.exe config trustedinstaller start=auto
                 %SystemRoot%\System32\net.exe stop bits
                 %SystemRoot%\System32\net.exe stop wuauserv
                 %SystemRoot%\System32\net.exe stop msiserver
                 %SystemRoot%\System32\net.exe stop cryptsvc
                 %SystemRoot%\System32\net.exe stop appidsvcc
                 Ren %Systemroot%\SoftwareDistribution SoftwareDistribution.old
                 Ren %Systemroot%\System32\catroot2 catroot2.old
                 %SystemRoot%\System32\regsvr32.exe /s atl.dll
                 %SystemRoot%\System32\regsvr32.exe /s urlmon.dll
                 %SystemRoot%\System32\regsvr32.exe /s mshtml.dll
                 %SystemRoot%\System32\netsh.exe winsock reset
                 %SystemRoot%\System32\netsh.exe winsock reset proxy
                 %SystemRoot%\System32\rundll32.exe pnpclean.dll,RunDLL_PnpClean /DRIVERS /MAXCLEAN
                 %SystemRoot%\System32\DISM.exe /Online /Cleanup-image /ScanHealth
                 %SystemRoot%\System32\DISM.exe /Online /Cleanup-image /CheckHealth
                 %SystemRoot%\System32\DISM.exe /Online /Cleanup-image /RestoreHealth
                 %SystemRoot%\System32\DISM.exe /Online /Cleanup-image /StartComponentCleanup
                 %SystemRoot%\System32\sfc.exe /scannow
                 %SystemRoot%\System32\net.exe start bits
                 %SystemRoot%\System32\net.exe start wuauserv
                 %SystemRoot%\System32\net.exe start msiserver
                 %SystemRoot%\System32\net.exe start cryptsvc
                 %SystemRoot%\System32\net.exe start appidsvc
                 echo Task Completed.
                 pause > nul
                 goto wincommand2
 rem Security -----------------------------------------------------------------
     :ttsecurity
     cls
     color 0f
     echo  If you discover a vulnerability, please follow these steps to report it:
     echo.
     echo   1. Submit a Report: Send an email to affiliates@txdylan.com with a detailed description of the vulnerability, 
     echo  including steps to reproduce it, the potential impact, and any possible fixes.
     echo.
     echo   2. Acknowledgment: You will receive an acknowledgment within 48 hours confirming that your report has been 
     echo  received.
     echo.
     echo   3. Updates: You can expect updates on the status of the vulnerability every 7 days.
     echo.
     echo   4. Resolution Process: If the vulnerability is accepted, we will work on a patch and communicate the timeline
     echo  for the fix. If the vulnerability is declined, we will provide a reason for the decision.
     echo.
     echo   5. Confidentiality: We request that you keep the details of any reported vulnerabilities confidential
     echo  until they are resolved.
     echo.
     echo  Thank you for helping us keep our project secure.
     pause > nul
     cls
     goto agreement
rem End ----------------------------------------------------------------------
 :end           
 exit