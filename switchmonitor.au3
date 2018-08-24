#include <WinAPI.au3>

Opt("TrayAutoPause", 0)
Opt("TrayMenuMode", 3)
Opt("TrayOnEventMode", 1)

HotKeySet("#{PGUP}", "NextMon")
HotKeySet("#{PGDN}", "PrevMon")

TrayCreateEventItem("Next Monitor", "NextMon")
TrayCreateEventItem("Previous Monitor", "PrevMon")
TrayCreateItem("")
$idLockMonitor = TrayCreateEventItem("Lock Monitor", "ToggleLockMonitor")
TrayCreateItem("")
TrayCreateEventItem("Exit", "ExitScript")

Global $lockMonitor = False
Global $monitor = GetMonitor(MouseGetPos(0))

Loop()

Func Loop()
  Local $lastUpdated = 0

  While 1
    If $lockMonitor Then
      Local $currentMonitor = GetMonitor(MouseGetPos(0))
      If $currentMonitor > $monitor Then
        MouseMove(@DesktopWidth * ($monitor + 1) - 1, MouseGetPos(1), 0)
        $lastUpdated = TimerInit()
      ElseIf $currentMonitor < $monitor Then
        MouseMove(@DesktopWidth * $monitor, MouseGetPos(1), 0)
        $lastUpdated = TimerInit()
      EndIf
    EndIf

    If TimerDiff($lastUpdated) > 1000 Then
      Sleep(100)
    EndIf
  WEnd
EndFunc

Func ExitScript()
  Exit
EndFunc

Func TrayCreateEventItem($text, $function)
  Local $id = TrayCreateItem($text)
  TrayItemSetOnEvent(-1, $function)
  Return $id
EndFunc

Func GetMonitor($mouseX)
  Return Floor($mouseX / @DesktopWidth)
EndFunc

Func VirtScreenWidth()
  Return _WinAPI_GetSystemMetrics(78)
EndFunc

Func VirtScreenMinX()
  Return _WinAPI_GetSystemMetrics(76)
EndFunc

Func VirtScreenMaxX()
  Return VirtScreenMinX() + VirtScreenWidth()
EndFunc

Func NextMon()
  Local $newX = MouseGetPos(0) + @DesktopWidth
  If $newX <= VirtScreenMaxX() Then
    MouseMove($newX, MouseGetPos(1),0)
    $monitor = GetMonitor(MouseGetPos(0))
  EndIf
EndFunc

Func PrevMon()
  Local $newX = MouseGetPos(0) - @DesktopWidth
  if $newX >= VirtScreenMinX() Then
    MouseMove($newX, MouseGetPos(1),0)
    $monitor = GetMonitor(MouseGetPos(0))
  EndIf
EndFunc

Func ToggleLockMonitor()
  $lockMonitor = Not($lockMonitor)
  $monitor = GetMonitor(MouseGetPos(0))
  TrayItemSetState($idLockMonitor, 1 + Not($lockMonitor) * 3)
EndFunc
