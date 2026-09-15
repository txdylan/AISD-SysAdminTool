@echo off
title AISD SysAdminTool v1.3
net session >nul 2>&1
if %errorLevel% neq 0 (
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
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
     echo  Build Version: v1.3
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
     echo   [1] Intune Commands
     echo   [2] Online Installs
     echo   [3] System Information
     echo   [4] Windows Commands
     echo   [5] Other
     echo.
     choice /c 012345 /n /m ":~$"
     if %errorlevel%==1 goto end
     if %errorlevel%==2 goto intune
     if %errorlevel%==3 goto msstore
     if %errorlevel%==4 goto wininfo
     if %errorlevel%==5 goto wincommand
     if %errorlevel%==6 goto other 
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
         rem MSstore ------------------------------------------------------------------
             :msstore
             cls
             color 0f
             powershell Write-Host ' Software Installs: (Page 1 of 2)' -ForegroundColor Blue
             echo.
             powershell Write-Host ' Use [A] and [D] to navigate the pages.' -ForegroundColor DarkGray
             echo.
             echo   [0] Back
             echo   [1] Adobe Acrobat PDF Reader
             echo   [2] Adobe Creative Cloud - Adobe Suite
             echo   [3] AVer Touch App 
             echo   [4] Dell Display And Peripheral Manager
             echo   [5] Dell Support Assist 
             echo   [6] GitBash
             echo   [7] IPEVO Visualizer App
             echo   [8] Logitech Unifying Software
             echo   [9] Minecraft Education
             echo   [U] Update - Will Update all Applications
             echo   [V] VLC Player App
             echo.
             choice /c 0D123456789UV /n /m ":~$"
             if %errorlevel%==1 goto selection
             if %errorlevel%==2 goto msstore2
             if %errorlevel%==3 goto aar
             if %errorlevel%==4 goto acc
             if %errorlevel%==5 goto aver
             if %errorlevel%==6 goto delldpm
             if %errorlevel%==7 goto dellsa
             if %errorlevel%==8 goto gitbash
             if %errorlevel%==9 goto ipevo
             if %errorlevel%==10 goto unifying
             if %errorlevel%==11 goto minecraftedu
             if %errorlevel%==12 goto msupdate
             if %errorlevel%==13 goto vlc
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
             rem AVer Touch ---------------------------------------------------------------
                 :aver
                 "%LOCALAPPDATA%\Microsoft\WindowsApps\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe\winget.exe" install 9PNKDR50694P
                 echo Task Completed.
                 pause > nul
                 goto msstore 
             rem Dell Display & Peripheral Manager ----------------------------------------
                 :delldpm
                 "%LOCALAPPDATA%\Microsoft\WindowsApps\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe\winget.exe" install Dell.DisplayAndPeripheralManager
                 echo Task Completed.
                 pause > nul
                 goto msstore    
             rem Dell Support Assist ------------------------------------------------------
                 :dellsa
                 "%LOCALAPPDATA%\Microsoft\WindowsApps\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe\winget.exe" install XPDCCXDN26VNBT
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
             rem Logitech Unifying Software -----------------------------------------------
                 :unifying
                 "%LOCALAPPDATA%\Microsoft\WindowsApps\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe\winget.exe" install Logitech.UnifyingSoftware
                 echo Task Completed.
                 pause > nul
                 goto msstore              
             rem Minecraft Education ------------------------------------------------------
                 :minecraftedu
                 "%LOCALAPPDATA%\Microsoft\WindowsApps\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe\winget.exe" install 9NBLGGH4R2R6
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
         rem MSstore2 -----------------------------------------------------------------
             :msstore2
             cls
             color 0f
             powershell Write-Host ' Software Installs: (Page 2 of 2)' -ForegroundColor Blue
             echo.
             powershell Write-Host ' Use [A] and [D] to navigate the pages.' -ForegroundColor DarkGray
             echo.
             echo   [0] Back
             echo   [1] Microsoft Company Portal App
             echo   [2] Microsoft Office 365 Suit
             echo   [3] Microsoft Outlook App
             echo   [4] Microsoft PC Manager
             echo   [5] Microsoft PowerToys
             echo   [6] Microsoft Quick Assist
             echo   [7] Microsoft Surface App
             echo   [T] Microsoft Teams
             echo   [8] Microsoft Wireless Display Adapter App
             echo   [9] Microsoft Whiteboard App
             echo   [P] Third Party Installs
             echo.
             choice /c 0AD1234567T89P /n /m ":~$"
             if %errorlevel%==1 goto selection
             if %errorlevel%==2 goto msstore
             if %errorlevel%==3 goto msstore2
             if %errorlevel%==4 goto mscp
             if %errorlevel%==5 goto office365
             if %errorlevel%==6 goto outlook
             if %errorlevel%==7 goto pcmanager
             if %errorlevel%==8 goto powertoys
             if %errorlevel%==9 goto quickassist
             if %errorlevel%==10 goto surface
             if %errorlevel%==11 goto teams
             if %errorlevel%==12 goto wd
             if %errorlevel%==13 goto mswhiteboard
             if %errorlevel%==14 goto 3pi
             rem Microsoft Company Portal App ---------------------------------------------
                 :mscp
                 "%LOCALAPPDATA%\Microsoft\WindowsApps\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe\winget.exe" install 9WZDNCRFJ3PZ
                 echo Task Completed.
                 pause > nul
                 goto msstore2
             rem Microsoft Office 365 Suit ------------------------------------------------
                 :office365
                 "%LOCALAPPDATA%\Microsoft\WindowsApps\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe\winget.exe" install Microsoft.Office
                 echo Task Completed.
                 pause > nul
                 goto msstore2
             rem Microsoft Outlook App ----------------------------------------------------
                 :outlook
                 "%LOCALAPPDATA%\Microsoft\WindowsApps\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe\winget.exe" install 9NRX63209R7B
                 echo Task Completed
                 pause > nul
                 goto msstore2
             rem Microsoft PC Manager -----------------------------------------------------
                 :pcmanager
                 "%LOCALAPPDATA%\Microsoft\WindowsApps\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe\winget.exe" install 9PM860492SZD
                 echo Task Completed.
                 pause > nul
                 goto msstore2
             rem Microsoft PowerToys ------------------------------------------------------
                 :powertoys
                 "%LOCALAPPDATA%\Microsoft\WindowsApps\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe\winget.exe" install Microsoft.PowerToys
                 echo Task Completed.
                 pause > nul
                 goto msstore2
             rem Microsoft Quick Assist ---------------------------------------------------
                 :quickassist
                 "%LOCALAPPDATA%\Microsoft\WindowsApps\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe\winget.exe" install 9P7BP5VNWKX5
                 echo Task Completed.
                 pause > nul
                 goto msstore2
             rem Microsoft Surface App ----------------------------------------------------
                 :surface
                 "%LOCALAPPDATA%\Microsoft\WindowsApps\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe\winget.exe" install 9WZDNCRFJB8P
                 echo Task Completed.
                 pause > nul
                 goto msstore2
             rem Microsoft Teams ----------------------------------------------------------
                 :teams
                 "%LOCALAPPDATA%\Microsoft\WindowsApps\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe\winget.exe" install Microsoft.Teams
                 echo Task Completed.
                 pause > nul
                 goto msstore2
             rem Microsoft Wireless Display Adapter App -----------------------------------
                 :wd
                 "%LOCALAPPDATA%\Microsoft\WindowsApps\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe\winget.exe" install 9WZDNCRFJBB1
                 echo Task Completed.
                 pause > nul
                 goto msstore2
             rem Microsoft Whiteboard App -------------------------------------------------
                 :mswhiteboard
                 "%LOCALAPPDATA%\Microsoft\WindowsApps\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe\winget.exe" install 9MSPC6MP8FM4
                 echo Task Completed.
                 pause > nul
                 goto msstore2
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
             echo   [1] Classic Device and Printers - Control Panel Management
             echo   [2] Bitlocker Info - System Bitlocker Code
             echo   [3] Delete Profiles - Shortcut to remove user profiles
             echo   [4] Device Manager - Admin Shortcut
             echo   [5] Network Reset - System Network Repair
             echo   [6] Perfomance Monitor Report
             echo   [7] Perfomance Monitor Resources
             echo   [8] Rename - Rename The Computer System
             echo   [9] System Clean - Deletes System Temporary Files         
             echo.
             choice /c 0AD123456789E /n /m ":~$"
             if %errorlevel%==1 goto selection
             if %errorlevel%==2 goto wincommand
             if %errorlevel%==3 goto wincommand2
             if %errorlevel%==4 goto mcdp
             if %errorlevel%==5 goto commandbitlockercode
             if %errorlevel%==6 goto commandprofile
             if %errorlevel%==7 goto commanddevmgmt
             if %errorlevel%==8 goto commandnet
             if %errorlevel%==9 goto pmreport
             if %errorlevel%==10 goto pmres
             if %errorlevel%==11 goto commandrename
             if %errorlevel%==12 goto commandclean
             if %errorlevel%==13 goto medge
             rem Classic Device and Printers ----------------------------------------------
                 :mcdp
                 C:\Windows\explorer.exe shell:::{A8A91A66-3A7D-4424-8D24-04E180695C7A}
                 goto wincommand
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
             rem Perfomance Monitor Report ------------------------------------------------
                 :pmreport
                 powershell perfmon /report
                 goto wincommand
             rem Perfomance Monitor Resources ---------------------------------------------
                 :pmres
                 powershell perfmon /res
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
             rem (Hidden) Microsoft Edge --------------------------------------------------
                 :medge
                 "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
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
                 echo   [1] Time Sync - Sync System Clock
                 echo   [2] Verbo - Enables System Messages During Boot
                 echo   [3] Windows 11 Force Install
                 echo   [4] Windows OS Repair - Restore and fixes Windows system files
                 echo   [5] Windows Update Repair - Fixes issues with updating Windows       
                 echo.
                 choice /c 0AD12345 /n /m ":~$"
                 if %errorlevel%==1 goto selection
                 if %errorlevel%==2 goto wincommand
                 if %errorlevel%==3 goto wincommand2
                 if %errorlevel%==4 goto commandtime
                 if %errorlevel%==5 goto commandverbo
                 if %errorlevel%==6 goto win11u
                 if %errorlevel%==7 goto commandwinrepair
                 if %errorlevel%==8 goto commandwinupdate
                 rem Time Sync ----------------------------------------------------------------
                 :commandtime
                 %SystemRoot%\System32\net.exe start w32time >nul 2>&1
                 timeout /t 10
                 %SystemRoot%\System32\w32tm.exe /resync >nul 2>&1
                 echo Task Completed.
                 pause > nul
                 goto wincommand22
             rem Verbo --------------------------------------------------------------------
                 :commandverbo
                 %SystemRoot%\System32\reg.exe add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v verbosestatus /t REG_DWORD /d 1 /f >nul 2>&1
                 echo Task Completed.
                 pause > nul
                 goto wincommand2
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
     rem Other --------------------------------------------------------------------
         :other
         cls
         color 0f
         powershell Write-Host ' Main Menu' -ForegroundColor Blue
         echo.
         echo   [0] Back
         echo   [1] ChatGPT - Requires API Token
         echo   [2] Domain Tools - For Domain Joined Devices
         echo.
         choice /c 012 /n /m ":~$"
         if %errorlevel%==1 goto selection
         if %errorlevel%==2 goto chatgpt
         if %errorlevel%==3 goto domain
         rem ChatGPT OpenAI -----------------------------------------------------------
             :chatgpt
             cls
             cd /d "%~dp0"
             set "ENV_FILE=%~dp0.env"
             set "MODEL=gpt-5.6-luna"
             set "API_URL=https://api.openai.com/v1/responses"
             set "RESPONSE_FILE=%TEMP%\AskAI_%RANDOM%_%RANDOM%.response.json"
             set "REQUEST_FILE=%TEMP%\AskAI_%RANDOM%_%RANDOM%.request.json"
             echo.
             echo  ================================================================
             echo                             ChatGPT
             echo  ================================================================
             echo.
             echo  Powered remotely by OpenAI
             echo.
             REM ----------------------------------------------------------------
             REM Check required Windows tools
             REM ----------------------------------------------------------------
             where curl.exe >nul 2>&1
             if errorlevel 1 (
             powershell Write-Host ' [ERROR] curl.exe was not found.' -ForegroundColor red
             echo.
             echo  AskAI requires Windows 10 or Windows 11 with curl available.
             echo.
             pause > nul
             goto other
             )
             where powershell.exe >nul 2>&1
             if errorlevel 1 (
             echo  [ERROR] Windows PowerShell was not found.
             echo.
             pause > nul
             goto other
             )
             REM ----------------------------------------------------------------
             REM Load OPENAI_API_KEY from .env
             REM ----------------------------------------------------------------
             if not exist "%ENV_FILE%" (
             powershell Write-Host ' [SETUP REQUIRED]' -ForegroundColor red
             echo.
             echo  I could not find:
             echo  %ENV_FILE%
             echo.
             echo  To set up OpenAI:
             powershell Write-Host -NoNewline ' 1. Go to ' -ForegroundColor White
             powershell Write-Host 'https://platform.openai.com/api-keys' -ForegroundColor Blue
             echo  2. Sign in to OpenAI.
             echo  3. Create an API key.
             echo  4. Copy the key.
             powershell Write-Host -NoNewline ' 5. Create a new file named ' -ForegroundColor White
             powershell Write-Host '".env"' -ForegroundColor Yellow
             echo  6. Open .env in Notepad
             powershell Write-Host -NoNewline ' 7. Add the following line: ' -ForegroundColor White
             powershell Write-Host '"OPENAI_API_KEY=sk-your-key-here"' -ForegroundColor Yellow
             powershell Write-Host -NoNewline ' 8.  Replace ' -ForegroundColor White
             powershell Write-Host -NoNewline '"sk-your-key-here" ' -ForegroundColor Yellow
             powershell Write-Host 'with your actual API key' -ForegroundColor White
             echo  9.  Save the .env file
             echo.
             powershell Write-Host ' Do NOT share your .env file!' -ForegroundColor red
             pause > nul
             goto other
             )
             set "OPENAI_API_KEY="
             for /f "usebackq tokens=1,* delims==" %%A in ("%ENV_FILE%") do (
             if /i "%%A"=="OPENAI_API_KEY" set "OPENAI_API_KEY=%%B"
             )
             if not defined OPENAI_API_KEY (
             powershell Write-Host ' [ERROR] OPENAI_API_KEY was not found in .env.' -ForegroundColor red
             echo.
             echo  Your .env file should contain:
             echo.
             echo    OPENAI_API_KEY=sk-your-key-here
             echo.
             pause > nul
             goto other
             )
             REM Remove optional surrounding double quotes.
             if "%OPENAI_API_KEY:~0,1%"=="\"" if "%OPENAI_API_KEY:~-1%"=="\"" (
             set "OPENAI_API_KEY=%OPENAI_API_KEY:~1,-1%"
             )
             powershell Write-Host ' [OK] Configuration loaded.' -ForegroundColor Green
             echo.
             echo  Model:
             powershell Write-Host '  %MODEL%' -ForegroundColor Blue
             echo.
             echo  Type /help for commands.
             echo  Type /exit to quit.
             echo.
             echo  ----------------------------------------------------------------
             echo.
             rem OpenAI Main --------------------------------------------------------------
                 :openaimain
                 set "USER_PROMPT="
                 set /p "USER_PROMPT=:~$"
                 if not defined USER_PROMPT goto main
                 if /i "%USER_PROMPT%"=="/exit" goto openaicleanup
                 if /i "%USER_PROMPT%"=="/quit" goto openaicleanup
                 if /i "%USER_PROMPT%"=="/help" goto openaihelp
                 if /i "%USER_PROMPT%"=="/clear" (
                 cls
                 goto openaimain
                 )
                 REM ----------------------------------------------------------------
                 REM Build JSON directly in PowerShell.
                 REM This avoids the previous prompt-file locking problem entirely.
                 REM ----------------------------------------------------------------
                 powershell.exe -NoProfile -ExecutionPolicy Bypass -Command ^
                 "$body=@{model=$env:MODEL; input=$env:USER_PROMPT} | ConvertTo-Json -Compress; [IO.File]::WriteAllText($env:REQUEST_FILE,$body,[Text.UTF8Encoding]::new($false))"
                 if errorlevel 1 (
                 echo.
                 powershell Write-Host ' [ERROR] Could not prepare the request.' -ForegroundColor red
                 echo.
                 goto openaimain
                 )
                 echo.
                 echo  OpenAI: Thinking...
                 curl.exe -sS --fail-with-body "%API_URL%" ^
                 -H "Content-Type: application/json" ^
                 -H "Authorization: Bearer %OPENAI_API_KEY%" ^
                 --data-binary "@%REQUEST_FILE%" > "%RESPONSE_FILE%" 2>&1
                 if errorlevel 1 (
                 echo.
                 powershell Write-Host ' [ERROR] The request could not be completed.' -ForegroundColor red
                 echo.
                 echo  Possible causes:
                 echo    - No Internet connection
                 echo    - Invalid or expired API key
                 echo    - API account has no available billing/credits
                 echo    - Temporary OpenAI service issue
                 echo.
                 echo  Server response:
                 type "%RESPONSE_FILE%"
                 echo.
                 del "%REQUEST_FILE%" >nul 2>&1
                 del "%RESPONSE_FILE%" >nul 2>&1
                 goto openaimain
                 )
                 echo.
                 powershell.exe -NoProfile -ExecutionPolicy Bypass -Command ^
                 "$r=Get-Content -LiteralPath $env:RESPONSE_FILE -Raw | ConvertFrom-Json; if($r.error){Write-Host ('OpenAI error: '+$r.error.message); exit 2}; $printed=$false; foreach($item in $r.output){foreach($c in $item.content){if($c.type -eq 'output_text'){Write-Output $c.text; $printed=$true}}}; if(-not $printed){Write-Output 'No text response was returned.'}"
                 echo.
                 echo  ----------------------------------------------------------------
                 echo.
                 del "%REQUEST_FILE%" >nul 2>&1
                 del "%RESPONSE_FILE%" >nul 2>&1
                 goto openaimain
             rem OpenAI Help --------------------------------------------------------------
                 :openaihelp
                 echo.
                 echo  OpenAI commands:
                 echo.
                 echo    /help       Show this help
                 echo    /clear      Clear the terminal
                 echo    /exit       Close AskAI
                 echo.
                 echo  Type any normal question after ":~$".
                 echo.
                 echo  Your API key is read from .env in this folder.
                 echo  Never share .env because it contains your private API key.
                 echo.
                 echo  ----------------------------------------------------------------
                 echo.
                 goto openaimain
             rem Open AI close ------------------------------------------------------------
                 :openaicleanup
                 del "%REQUEST_FILE%" >nul 2>&1
                 del "%RESPONSE_FILE%" >nul 2>&1
                 echo.
                 echo  Thanks for using OpenAI.
                 echo.
                 pause > nul
                 endlocal
                 goto other
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
             if %errorlevel%==1 goto other
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