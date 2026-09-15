# AISD SysAdminTool v1.3

A Windows batch-based system administration utility designed for IT/sysadmin workflows. It provides a menu-driven collection of Intune diagnostics, software installation shortcuts, Windows maintenance commands, system information, OpenAI/ChatGPT access, and domain-management tools.

**Version:** 1.3  
**Author:** TXDYLAN  
**Primary platform:** Windows 10 / Windows 11  
**Minimum OS listed by the tool:** Windows 10 22H2  
**Recommended OS:** Windows 11 23H2 or later

---

## ⚠️ Important

This tool is intended for **system administrators and authorized IT personnel**.

Many functions run with Administrator privileges and can make significant changes to a Windows computer, including:

- Removing temporary/cache data
- Resetting networking components
- Modifying Windows services and registry settings
- Renaming the computer
- Running Windows repair operations
- Installing or updating software
- Restarting or shutting down computers remotely
- Sending messages to other computers on a network
- Accessing BitLocker protector information

Only use the tool on computers and networks you are authorized to administer.

---

# Getting Started

## 1. Run the tool

Double-click:

```text
AISD_SysAdminTool v1.3.bat
```

The script checks whether it is running with Administrator privileges. If it is not, it attempts to relaunch itself using **Run as Administrator**.

After launch, the tool displays a usage agreement/menu.

## 2. Main menu

The main menu contains:

```text
[0] Exit
[1] Intune Commands
[2] Online Installs
[3] System Information
[4] Windows Commands
[5] Other
```

Select the desired option using the displayed number or letter.

---

# Features

## 1. Intune Commands

The Intune section provides several troubleshooting and management shortcuts.

### Check Intune Management Status

Runs:

```text
dsregcmd /status
```

Useful for viewing Microsoft Entra/Windows device registration and MDM-related status.

### Check Intune Management Extension Status

Runs:

```text
sc query IntuneManagementExtension
```

Displays the current state of the Intune Management Extension service.

### Restart Intune Management Extension

The tool:

1. Stops the `IntuneManagementExtension` service.
2. Removes the Intune Management Extension Content directory.
3. Removes the Intune Management Extension Policies directory.
4. Starts the service again.
5. Attempts to run EnterpriseMgmt scheduled tasks.

This can be useful when troubleshooting Intune application/policy processing.

### Resync

Runs:

```text
dsregcmd /refreshprt
```

Then opens:

```text
ms-settings:workplace
```

---

# 2. Online Installs

The software installation menu uses **WinGet** for many applications.

## Page 1

Available applications include:

- Adobe Acrobat PDF Reader
- Adobe Creative Cloud
- AVer Touch
- Dell Display and Peripheral Manager
- Dell SupportAssist
- Git
- IPEVO Visualizer
- Logitech Unifying Software
- Minecraft Education
- VLC Player
- Update All Applications

The **Update** option runs:

```text
winget update --all --include-unknown --accept-source-agreements --accept-package-agreements
```

## Page 2

Available applications include:

- Microsoft Company Portal
- Microsoft Office
- Microsoft Outlook
- Microsoft PC Manager
- Microsoft PowerToys
- Microsoft Quick Assist
- Microsoft Surface
- Microsoft Teams
- Microsoft Wireless Display Adapter
- Microsoft Whiteboard

## Page navigation

The software pages indicate:

```text
Use [A] and [D] to navigate the pages.
```

---

# 3. Third Party Installs

The third-party section uses **Chocolatey**.

Available options include:

- Chocolatey Package Manager
- Dell SupportAssist
- HP Support Assistant
- Mitel Connect
- VEXcode V5

The tool provides an option to install Chocolatey first.

### Chocolatey installation

The script downloads and executes the Chocolatey installation script from:

```text
https://community.chocolatey.org/install.ps1
```

Only install software from sources you trust and understand.

---

# 4. System Information

The System Information option runs Windows:

```text
systeminfo.exe
```

This displays information about the Windows installation and computer, such as OS version, system configuration, hardware information, and other system details.

---

# 5. Windows Commands

The Windows Commands section contains two pages of maintenance and troubleshooting utilities.

## Page 1

### Classic Device and Printers

Opens the classic Windows Device and Printers interface.

### BitLocker Info

Runs:

```text
manage-bde -status
manage-bde -protectors C: -get
```

Displays BitLocker status and protector information for drive C:.

### Delete Profiles

Opens:

```text
SystemPropertiesAdvanced.exe
```

This provides access to advanced system settings where user profiles can be managed.

### Device Manager

Opens:

```text
devmgmt.msc
```

### Network Reset

Runs several network repair commands:

```text
netsh winsock reset
netsh int ip reset
ipconfig /release
ipconfig /renew
ipconfig /flushdns
```

It then opens Microsoft's connectivity test redirect.

**Note:** Network connectivity may be interrupted while these commands run.

### Performance Monitor Report

Runs:

```text
perfmon /report
```

### Performance Monitor Resources

Runs:

```text
perfmon /res
```

### Rename PC

The tool:

1. Displays the current hostname.
2. Requests a new computer name.
3. Attempts to rename the computer.
4. Asks whether the computer should restart immediately.

A restart is normally required for the new computer name to fully take effect.

### System Clean

Performs an aggressive cleanup of several temporary/cache locations, including:

- `%TEMP%`
- Windows Temp
- Windows Prefetch
- Local AppData Temp
- Package Cache
- Direct3D shader cache
- Crash dumps
- MDM-related cache
- Selected Windows package directories
- Intune Management Extension cache
- Recycle Bin

It then launches Windows Disk Cleanup and refreshes Windows Explorer.

**Use caution:** This cleanup intentionally removes cached and temporary data. Do not use it blindly on a production system if you need to preserve troubleshooting artifacts, crash dumps, or application caches.

---

# Windows Commands — Page 2

## Time Sync

Attempts to start the Windows Time service and synchronize the system clock using:

```text
net start w32time
w32tm /resync
```

## Verbose Boot Status

Adds the Windows registry value:

```text
HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System
verboseStatus = 1
```

This enables additional status information during Windows startup/shutdown.

## Windows 11 Force Install

Attempts to launch Windows Setup using:

```text
setupprep.exe /product server
```

This feature is intended to assist with Windows 11 installation/upgrade scenarios.

**Important:** Test this carefully before using it in production. The script assumes a specific setup-file location and drive configuration.

## Windows OS Repair

Runs:

```text
chkdsk /f
DISM /Online /Cleanup-Image /CheckHealth
sfc /scannow
UsoClient ScanInstallWait
```

These commands check/repair the Windows file system and Windows component store, then request Windows Update scanning.

Depending on system state, `chkdsk /f` may require a restart.

## Windows Update Repair

Performs a more extensive Windows Update repair sequence, including:

- Configuring Windows Modules Installer
- Stopping Windows Update-related services
- Renaming `SoftwareDistribution`
- Renaming `catroot2`
- Re-registering selected DLLs
- Resetting Winsock
- Cleaning Plug and Play driver data
- Running DISM health checks/repair
- Running component cleanup
- Running SFC
- Restarting required services

This is a **high-impact repair operation** and should be used when Windows Update problems justify it.

---

# 6. Other

The Other menu contains:

```text
[1] ChatGPT - Requires API Token
[2] Domain Tools - For Domain Joined Devices
```

---

# ChatGPT / AskAI

The built-in ChatGPT feature communicates directly with the OpenAI API.

The script currently specifies:

```text
Model: gpt-5.6-luna
API endpoint: https://api.openai.com/v1/responses
```

## Requirements

The ChatGPT feature requires:

- Internet access
- `curl.exe`
- Windows PowerShell
- An OpenAI API key
- An API account with available billing/credits

The script checks for `curl.exe` and PowerShell before continuing.

## API key configuration

Create a file named:

```text
.env
```

in the **same directory as the BAT file**.

The file should contain:

```text
OPENAI_API_KEY=sk-your-key-here
```

Replace the example value with your actual API key.

### Security warning

**Never share the `.env` file.**

It contains a private API credential. Do not upload it to GitHub, send it to other people, or include it in screenshots.

A recommended `.gitignore` entry is:

```text
.env
```

## AskAI commands

Inside the ChatGPT interface:

```text
/help
```

Displays the available commands.

```text
/clear
```

Clears the terminal.

```text
/exit
```

Closes the AskAI interface.

```text
/quit
```

Also exits AskAI.

Any other text is sent as the user prompt to the OpenAI API.

## API costs

The BAT file itself does **not** make the OpenAI API free.

API requests are separate from normal ChatGPT app usage and may be subject to OpenAI API billing/credits according to the API account.

If you want to avoid unexpected API charges, configure appropriate spending/billing limits in your OpenAI API account before using this feature.

---

# Domain Tools

The Domain Tools section is intended for authorized domain/LAN administration.

## Send Message

Allows the administrator to enter a computer name or IP address and send messages to sessions on that computer.

The underlying command is:

```text
msg /SERVER:<target> * "<message>"
```

Common failure causes include:

- Target computer is unreachable
- Incorrect computer name/IP
- Port 445 is blocked
- Server service is disabled
- Permission/UAC restrictions
- Domain/credential restrictions

## Remote Power

Allows an administrator to select a target computer and:

- Restart immediately
- Shut down immediately
- Schedule a restart
- Abort a pending shutdown/restart
- Perform a basic connectivity check

The underlying remote shutdown commands use:

```text
shutdown /m \\<target>
```

Use these functions carefully because they can immediately interrupt users and running workloads.

---

# Security / Vulnerability Reporting

If you discover a security vulnerability in AISD SysAdminTool, the script directs researchers to report it to:

```text
affiliates@txdylan.com
```

The tool requests a description including:

- Vulnerability details
- Steps to reproduce
- Potential impact
- Possible fixes

The script states that an acknowledgment should be provided within 48 hours and that status updates are expected every 7 days.

Please keep vulnerability details confidential until the issue is resolved.

---

# Dependencies

The tool primarily relies on Windows built-in utilities and the following external components/features:

### Windows components

- Command Prompt
- Windows PowerShell
- `curl.exe`
- `dsregcmd`
- `systeminfo`
- `manage-bde`
- `devmgmt.msc`
- `netsh`
- `ipconfig`
- `perfmon`
- `DISM`
- `SFC`
- `w32tm`
- `shutdown`
- `msg`
- Windows Task Scheduler

### Software/package managers

- WinGet / App Installer
- Chocolatey (only required for the third-party install section)

### ChatGPT

- OpenAI API key
- Internet access

---

# Recommended Folder Layout

For the ChatGPT feature, keep the files together:

```text
AISD-SysAdminTool/
│
├── AISD_SysAdminTool v1.3.bat
├── .env
└── README.txt
```

Do **not** distribute the `.env` file containing your API key.

---

# Troubleshooting

## The script keeps asking for Administrator access

This is expected. AISD SysAdminTool is designed to run with elevated privileges.

Right-clicking the BAT file and choosing:

```text
Run as administrator
```

is recommended.

## WinGet installations fail

Check that WinGet/App Installer is installed and available.

The script calls WinGet using its WindowsApps path:

```text
%LOCALAPPDATA%\Microsoft\WindowsApps\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe\winget.exe
```

If WinGet is unavailable or that path does not exist, software installation options may fail.

## ChatGPT says `.env` is missing

Create `.env` beside the BAT file:

```text
OPENAI_API_KEY=your_api_key_here
```

Make sure Windows has not silently saved the file as:

```text
.env.txt
```

## ChatGPT reports an API error

Possible causes include:

- No Internet connection
- Invalid API key
- Expired/revoked API key
- No available API billing/credits
- Temporary OpenAI service problem

The script displays the server response when a request fails.

## Remote commands fail

Verify:

1. The target computer name/IP is correct.
2. The target is reachable.
3. You have appropriate administrative permissions.
4. Required Windows services are running.
5. Firewall/network rules allow the required traffic.
6. The target is on a network/domain where remote administration is permitted.

---

# Important v1.3 Notes

The following items are worth testing/fixing before treating this version as a production-ready deployment tool:

### 1. Time Sync return label

The Time Sync function currently returns to:

```text
goto wincommand22
```

The visible script defines `wincommand` and `wincommand2`, but not `wincommand22`. This appears to be a label typo and may cause unexpected navigation after Time Sync completes.

### 2. Windows 11 setup path

The Windows 11 Force Install function changes to drive `D:` and the `sources` directory and then references:

```text
"%D%\setupprep.exe"
```

The script does not visibly define `%D%`. This should be verified before relying on the function.

### 3. Chocolatey command paths

The third-party Chocolatey commands contain a quote immediately after `choco.exe`. These command lines should be tested and corrected if they fail to execute as intended.

### 4. Cleanup scope

The System Clean function intentionally deletes a broad set of cache/temp locations. Consider whether diagnostic artifacts such as crash dumps or Intune cache data should be preserved before running it during troubleshooting.

### 5. API key handling

The API key is loaded into an environment variable and passed to `curl`. Protect the BAT file and especially the `.env` file accordingly.

### 6. Remote administration

The Domain Tools features should only be used on systems where the operator has explicit administrative authorization.

---

# Version Information

```text
AISD SysAdminTool v1.3
Created By: TXDYLAN

Minimum:
Windows 10 22H2

Recommended:
Windows 11 23H2 or later
```

For releases, the tool points users to the project's GitHub releases page:

```text
https://github.com/txdylan/AISD-SysAdminTool/releases
```

For questions/support, the tool lists:

```text
affiliates@txdylan.com
```

---

# Disclaimer

AISD SysAdminTool is a collection of administrative shortcuts and commands. It does not guarantee that every operation will succeed on every Windows configuration.

Always review what a command does before deploying it broadly. Test changes on a controlled system before using them across an organization.

The administrator operating the tool is responsible for verifying authorization, backups, system state, network access, software licensing, and the consequences of administrative actions.

---

## End

**AISD SysAdminTool v1.3 — System Administration Utility**
