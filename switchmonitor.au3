#include <WinAPI.au3>

HotKeySet("#{PGUP}", "NextMon")
HotKeySet("#{PGDN}", "PrevMon")

While 1
   Sleep(60000)
WEnd

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
