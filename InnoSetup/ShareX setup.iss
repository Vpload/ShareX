#define MyAppName "ShareX"
#define MyAppFile "ShareX.exe"
#define MyAppParentDir "..\ShareX\bin\Release"
#define MyAppPath MyAppParentDir + "\ShareX.exe"
#dim Version[4]
#expr ParseVersion(MyAppPath, Version[0], Version[1], Version[2], Version[3])
#define MyAppVersion Str(Version[0]) + "." + Str(Version[1]) + "." + Str(Version[2])
#define MyAppPublisher "ShareX Developers"
#define MyAppId "82E6AC09-0FEF-4390-AD9F-0DD3F5561EFC"

[Setup]
AllowNoIcons=yes
AppCopyright=Copyright � 2007-2015 {#MyAppPublisher}
AppId={#MyAppId}
AppMutex={#MyAppId}
AppName={#MyAppName}
AppPublisher={#MyAppPublisher}
AppPublisherURL=http://getsharex.com
AppSupportURL=https://github.com/ShareX/ShareX/issues
AppUpdatesURL=https://github.com/ShareX/ShareX/releases
AppVerName={#MyAppName} {#MyAppVersion}
AppVersion={#MyAppVersion}
ArchitecturesAllowed=x86 x64 ia64
ArchitecturesInstallIn64BitMode=x64 ia64
Compression=lzma2/ultra64
DefaultDirName={pf}\{#MyAppName}
DefaultGroupName={#MyAppName}
DirExistsWarning=no
LicenseFile=..\LICENSE.txt
MinVersion=0,5.01.2600
OutputBaseFilename={#MyAppName}-{#MyAppVersion}-setup
OutputDir=Output\
PrivilegesRequired=none
ShowLanguageDialog=auto
SolidCompression=yes
UninstallDisplayIcon={app}\{#MyAppFile}
VersionInfoCompany={#MyAppPublisher}
VersionInfoTextVersion={#MyAppVersion}
VersionInfoVersion={#MyAppVersion}
WizardImageFile=WizardImageFile.bmp
WizardSmallImageFile=WizardSmallImageFile.bmp
WizardImageBackColor=clWhite
WizardImageStretch=no

[Languages]
Name: "en"; MessagesFile: "compiler:Default.isl"
Name: "de"; MessagesFile: "compiler:Languages\German.isl"

[Tasks]
Name: "CreateDesktopIcon"; Description: "Create a desktop shortcut"; GroupDescription: "Additional shortcuts:"
Name: "CreateSendToIcon"; Description: "Create a send to shortcut"; GroupDescription: "Additional shortcuts:"
Name: "CreateQuickLaunchIcon"; Description: "Create a quick launch shortcut"; GroupDescription: "Additional shortcuts:"; OnlyBelowVersion: 0,6.1
Name: "CreateStartupIcon"; Description: "Launch {#MyAppName} automatically at Windows startup"; GroupDescription: "Other tasks:"

[Files]
Source: "{#MyAppParentDir}\ShareX.exe"; DestDir: {app}; Flags: ignoreversion
Source: "{#MyAppParentDir}\ShareX.exe.config"; DestDir: {app}; Flags: ignoreversion
Source: "{#MyAppParentDir}\*.dll"; DestDir: {app}; Flags: ignoreversion
Source: "{#MyAppParentDir}\*.css"; DestDir: {app}; Flags: ignoreversion
Source: "{#MyAppParentDir}\*.txt"; DestDir: {app}; Flags: ignoreversion
Source: "Output\Recorder-devices-setup.exe"; DestDir: {app}; Flags: ignoreversion

; Language resources
Source: "{#MyAppParentDir}\tr\*.resources.dll"; DestDir: {app}\Languages\tr; Flags: ignoreversion
Source: "{#MyAppParentDir}\de\*.resources.dll"; DestDir: {app}\Languages\de; Flags: ignoreversion
Source: "{#MyAppParentDir}\fr\*.resources.dll"; DestDir: {app}\Languages\fr; Flags: ignoreversion
Source: "{#MyAppParentDir}\zh-CN\*.resources.dll"; DestDir: {app}\Languages\zh-CN; Flags: ignoreversion
Source: "{#MyAppParentDir}\hu\*.resources.dll"; DestDir: {app}\Languages\hu; Flags: ignoreversion
Source: "{#MyAppParentDir}\ko-KR\*.resources.dll"; DestDir: {app}\Languages\ko-KR; Flags: ignoreversion
Source: "{#MyAppParentDir}\es\*.resources.dll"; DestDir: {app}\Languages\es; Flags: ignoreversion
Source: "{#MyAppParentDir}\nl-NL\*.resources.dll"; DestDir: {app}\Languages\nl-NL; Flags: ignoreversion

[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\{#MyAppFile}"; WorkingDir: "{app}"
Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"; WorkingDir: "{app}"
Name: "{userdesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppFile}"; WorkingDir: "{app}"; Tasks: CreateDesktopIcon; Check: not DesktopIconExists
Name: "{userappdata}\Microsoft\Internet Explorer\Quick Launch\{#MyAppName}"; Filename: "{app}\{#MyAppFile}"; WorkingDir: "{app}"; Tasks: CreateQuickLaunchIcon
Name: "{sendto}\{#MyAppName}"; Filename: "{app}\{#MyAppFile}"; WorkingDir: "{app}"; Tasks: CreateSendToIcon
Name: "{userstartup}\{#MyAppName}"; Filename: "{app}\{#MyAppFile}"; WorkingDir: "{app}"; Parameters: "-silent"; Tasks: CreateStartupIcon

[Run]
Filename: "{app}\{#MyAppFile}"; Description: "{cm:LaunchProgram,{#MyAppName}}"; Flags: nowait postinstall

[UninstallRun]
Filename: regsvr32; WorkingDir: {app}; Parameters: "/s /u screen-capture-recorder.dll"; Check: not IsWin64
Filename: regsvr32; WorkingDir: {app}; Parameters: "/s /u screen-capture-recorder-x64.dll"; Check: IsWin64
Filename: regsvr32; WorkingDir: {app}; Parameters: "/s /u audio_sniffer.dll"; Check: not IsWin64
Filename: regsvr32; WorkingDir: {app}; Parameters: "/s /u audio_sniffer-x64.dll"; Check: IsWin64

[Registry]
;Root: "HKCU"; Subkey: "Software\Microsoft\Windows\CurrentVersion\Run"; ValueName: "{#MyAppName}"; Flags: uninsdeletevalue
Root: "HKCU"; Subkey: "Software\Classes\*\shell\{#MyAppName}"; Flags: dontcreatekey uninsdeletekey
Root: "HKCU"; Subkey: "Software\Classes\Directory\shell\{#MyAppName}"; Flags: dontcreatekey uninsdeletekey
Root: "HKCU"; Subkey: "Software\Classes\Folder\shell\{#MyAppName}"; Flags: dontcreatekey uninsdeletekey

[Code]
#include "Scripts\products.iss"
#include "Scripts\products\stringversion.iss"
#include "Scripts\products\winversion.iss"
#include "Scripts\products\fileversion.iss"
#include "Scripts\products\dotnetfxversion.iss"
#include "Scripts\products\msi31.iss"
#include "Scripts\products\dotnetfx40full.iss"

procedure InitializeWizard;
begin
  WizardForm.LicenseAcceptedRadio.Checked := true;
end;

function InitializeSetup(): Boolean;
begin
  initwinversion();
  msi31('3.1');
  dotnetfx40full();
  Result := true;
end;

function DesktopIconExists(): Boolean;
begin
  Result := FileExists(ExpandConstant('{userdesktop}\{#MyAppName}.lnk'));
end;