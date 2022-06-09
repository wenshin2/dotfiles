; IMPORTANT INFO ABOUT GETTING STARTED: Lines that start with a
; semicolon, such as this one, are comments.  They are not executed.

; This script has a special filename and path because it is automatically
; launched when you run the program directly.  Also, any text file whose
; name ends in .ahk is associated with the program, which means that it
; can be launched simply by double-clicking it.  You can have as many .ahk
; files as you want, located in any folder.  You can also run more than
; one ahk file simultaneously and each will get its own tray icon.

;#Persistent
;SetTimer, MoveMouse

;MoveMouse:
If ( A_TimeIdle > 59999 ) {
  MouseMove, 1 , 1,, R
  MouseMove, -1,-1,, R
}
Return


; send the monitor into standby (off) mode
; Ctrl + Alt + O
^!o::
Sleep 300 
SendMessage 0x112, 0xF170, 2,,Program Manager 
Return

;; Virtual Media Keys
;; Based on http://frugalcoder.us/post/2011/10/07/Mapping-windows-volume-for-keyboards-without-media-keys.aspx
;; Map WIN + F9 to Play/Pause
#F9::Send {Media_Play_Pause}
;; Map WIN + F10 to <<
#F10::Send {Media_Prev}
;; Map WIN + F11 to >>
#F11::Send {Media_Next}
;; Map WIN + F12 to toggle mute
#F12::Send {Volume_Mute}
;; Map WIN + F8 to Stop
#F8::Send {Media_Stop}

; Quick add to work log 
^!l::
current=%A_Hour%:%A_Min% %A_MM%/%A_DD%/%A_YYYY%
InputBox, UserInput, Daily Log, What did you accomplish?, , 380, 170
If Not ErrorLevel
{
   FileAppend,%current%`n%UserInput%`n`n, C:\Users\WenShin.Too\Documents\@Logs\Year - 2020\11 November\Work Log_2022_06_WW24.txt
}
Return


; Pin window to top
!a::
WinGet, ExStyle, ExStyle, A
if (ExStyle & 0x8)
{
	WinSet,AlwaysOnTop,off,A
	ToolTip,Disabled
}
else
{
	WinSet,AlwaysOnTop,on,A
	ToolTip,Enabled
}
Sleep,2000
ToolTip
return


;; Toggle autohide taskbar
VarSetCapacity(APPBARDATA, A_PtrSize=4 ? 36:48)

#b::
NumPut(DllCall("Shell32\SHAppBarMessage", "UInt", 4 ; ABM_GETSTATE
                                           , "Ptr", &APPBARDATA
                                           , "Int")
 ? 2:1, APPBARDATA, A_PtrSize=4 ? 32:40) ; 2 - ABS_ALWAYSONTOP, 1 - ABS_AUTOHIDE
 , DllCall("Shell32\SHAppBarMessage", "UInt", 10 ; ABM_SETSTATE
                                    , "Ptr", &APPBARDATA)
   KeyWait, % A_ThisHotkey
   Return
   


;; Text expansion
::myperl::perl -lane 'print "@F[]"'
::myperla::perl -lane '@arr=split(/,/);print "@arr[]"'

;for logs
::,,fev::[FEV]
::,,s::[SYN]
::,,a::[APR]
::,,p::[PEO]
::,,pv::[PV]
::,,f::[FP]
::,,l::[LV]
::,,t::[TR]
::;d::[DONE]

;paths


;signature
::rsig::Regards,`nWen Shin
::tsig::Thanks,`nWen Shin
::jsig::PSG Structural Design Engineer

;email
::g@@::wenshin2@gmail.com
::s@@::wenshin.too@starfivetech.com
::sl@@::wenshin.too@starfivetechtechnology.com

;URL


;common words
::qd::queued
::2moro::tomorrow
::/err::/error:
::(f::(from: )

;lesser used commands
;; don't you hate errors?
::gerr::grep -in "error:"
::egerr::egrep -in "error\s*:|ERROR-MSG"
::eglog::egrep -inl "error\s*:|ERROR-MSG" -- ``ls -rt logs/*_*.log``

;; need to enable raw mode, aka {} to enable sending caret ^ to output
::egpar::eg '{^}\w' *.rdt_attributes.txt
::catpar::cat logs/par*.status.log

::rz::yes n|gzip -r
::pinfo::print_info "wtoo INFO: "
::mymkdir::mkdir dbs logs outputs reports
::mkdirw::mkdir wtoo_analysis
