#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance, force
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory.

; global backgroundColor:="001F1B"
global backgroundColor:="black"
global NumberOfDesktops := 9

global CurrentDesktopIndex := 1
global rY := A_ScreenHeight - 100
global inMove := 0
global switchTimeout := 1
global tooltipTimeout := 50

; Workspaces
NumpadEnter::
    IncDesktop()
return
NumpadIns::
    DecDesktop()
return
XButton2::
    IncDesktop()
return
XButton1::
    DecDesktop()
return

NumpadDel::
    Send, #d
return

NumpadEnd::
    MoveToDesktop(1)
return
+NumpadEnd::
    CurrentDesktopIndex := NumberOfDesktops
    MoveToDesktop(1)
return

NumpadDown::
    MoveToDesktop(2)
return
+NumpadDown::
    CurrentDesktopIndex := NumberOfDesktops
    MoveToDesktop(1, 1, 0)
    MoveToDesktop(2, 0, 1)
return

NumpadPgdn::
    MoveToDesktop(3)
return
+NumpadPgdn::
    CurrentDesktopIndex := NumberOfDesktops
    MoveToDesktop(1, 1, 0)
    MoveToDesktop(3, 0, 1)
return

NumpadLeft::
    MoveToDesktop(4)
return
+NumpadLeft::
    CurrentDesktopIndex := NumberOfDesktops
    MoveToDesktop(1, 1, 0)
    MoveToDesktop(4, 0, 1)
return

NumpadClear::
    MoveToDesktop(5)
return
+NumpadClear::
    CurrentDesktopIndex := NumberOfDesktops
    MoveToDesktop(1, 1, 0)
    MoveToDesktop(5, 0, 1)
return

NumpadRight::
    MoveToDesktop(6)
return
+NumpadRight::
    CurrentDesktopIndex := 1
    MoveToDesktop(9, 1, 0)
    MoveToDesktop(6, 0, 1)
return

NumpadHome::
    MoveToDesktop(7)
return
+NumpadHome::
    CurrentDesktopIndex := 1
    MoveToDesktop(9, 1, 0)
    MoveToDesktop(7, 0, 1)
return

NumpadUp::
    MoveToDesktop(8)
return
+NumpadUp::
    CurrentDesktopIndex := 1
    MoveToDesktop(9, 1, 0)
    MoveToDesktop(8, 0, 1)
return

NumpadPgup::
    MoveToDesktop(9)
return
+NumpadPgup::
    CurrentDesktopIndex := 1
    MoveToDesktop(9)
return

MoveToDesktop(i, keepClose = 0, keepOpen = 0)
{
    if (inMove == 1) {
        ToolTip, "PROGRESS", 20, rY-100, 2
        Sleep, 100
        ToolTip, ,,, 2
        return
    }
    inMove := 1
    distance:=Abs(CurrentDesktopIndex-i)
    if(keepOpen){

    } else if(keepClose>0){
        CloseEyes()
    } else if(distance>1){
        CloseEyes()
    } 
    while (CurrentDesktopIndex!=i)
    {
        if (CurrentDesktopIndex<i) {
            IncDesktop()
        } else {
            DecDesktop()
        }
    }
    if(keepClose>0){

    } else if(keepOpen>0){
        OpenEyes()
    } else if(distance>1){
        OpenEyes()
    } 
    inMove := 0
}

WaitForSwitch()
{
    Sleep, switchTimeout
}

IncDesktop(){
    if(CurrentDesktopIndex!=NumberOfDesktops) {
        CurrentDesktopIndex := CurrentDesktopIndex+1
    }
    Send, ^#{Right}
    WaitForSwitch()
}

DecDesktop()
{
    if(CurrentDesktopIndex!=1) {
        CurrentDesktopIndex := CurrentDesktopIndex-1
    }
    Send, ^#{Left}
    WaitForSwitch()
}

CloseEyes(){
    Gui 1:-owner toolwindow -caption +LastFound
    hwnd:=WinExist()
    WinSet,Transparent,0,ahk_id %hwnd%
    Gui, Margin, 0,0
    Gui, Color, %backgroundColor%
    Gui, -Caption
    Gui, Show, % "W" . A_ScreenWidth . " H" . A_ScreenHeight . " X0 Y0"
    Gui, Show, x0 y0 w%A_ScreenWidth% h%A_ScreenHeight%
}

OpenEyes(){
    Gui,Destroy
}

