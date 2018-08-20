#include <WinAPI.au3>

Opt("TrayAutoPause", 0)
Opt("TrayMenuMode", 3)
Opt("TrayOnEventMode", 1)

Main()

Func Main()
  HotKeySet("#{PGUP}", "NextMon")
  HotKeySet("#{PGDN}", "PrevMon")

  TrayCreateEventItem("Next Monitor", "NextMon")
  TrayCreateEventItem("Previous Monitor", "PrevMon")
  TrayCreateItem("")
  TrayCreateEventItem("Exit", "ExitScript")

  Idle()
EndFunc

Func Idle()
  While 1
    Sleep(60000)
  WEnd
EndFunc

Func ExitScript()
  Exit
EndFunc

Func TrayCreateEventItem($text, $function)
  TrayCreateItem($text)
  TrayItemSetOnEvent(-1, $function)
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
  $newX = MouseGetPos(0) + @DesktopWidth
  If ($newX <= VirtScreenMaxX()) Then
    MouseMove($newX, MouseGetPos(1),0)
  EndIf
EndFunc

Func PrevMon()
  $newX = MouseGetPos(0) - @DesktopWidth
  if ($newX >= VirtScreenMinX()) Then
    MouseMove($newX, MouseGetPos(1),0)
  EndIf
EndFunc
