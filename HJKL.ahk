;关闭Capslock
SetCapsLockState,AlwaysOff

;编辑器分组
GroupAdd,editor,ahk_exe studio64.exe
GroupAdd,editor,ahk_exe clion64.exe
GroupAdd,editor,ahk_exe gvim.exe

;中文输入分组
GroupAdd,cn,ahk_exe TortoiseGitProc.exe
GroupAdd,cn,ahk_exe RTXLite.exe
GroupAdd,cn,ahk_exe QQ.exe

;从剪贴板输入到界面
sendbyclip(var_string)
{
    ClipboardOld = %ClipboardAll%
    Clipboard =%var_string%
	ClipWait
    send ^v
    sleep 100
    Clipboard = %ClipboardOld%  ; Restore previous contents of clipboard.
}


setChineseLayout(){
	;发送中文输入法切换快捷键，请根据实际情况设置。
	Send {Ctrl Down}{2}
	Send {Ctrl Up}
}
setEnglishLayout(){
	;发送英文输入法切换快捷键
	Send {Ctrl Down}{1}    
	Send {Ctrl Up}
}

;激活窗口
Activate(t)
{
  IfWinActive,%t%
  {
    WinMinimize
    return
  }
  SetTitleMatchMode 2    
  DetectHiddenWindows,on
  IfWinExist,%t%
  {
    WinShow
    WinActivate           
    return 1
  }
  return 0
}

;激活/启动窗口
ActivateAndOpen(t,p)
{
  if Activate(t)==0
  {
    Run %p%
    WinActivate
    return
  }
}

;监控消息回调ShellMessage，并自动设置输入法
Gui +LastFound
hWnd := WinExist()
DllCall( "RegisterShellHookWindow", UInt,hWnd )
MsgNum := DllCall( "RegisterWindowMessage", Str,"SHELLHOOK" )
OnMessage( MsgNum, "ShellMessage")

ShellMessage( wParam,lParam ) {
	If ( wParam = 1 )
	{
		WinGetclass, WinClass, ahk_id %lParam%
		;MsgBox,%Winclass%
		Sleep, 1000
		WinActivate,ahk_class %Winclass%
		;WinGetActiveTitle, Title
		;MsgBox, The active window is "%Title%".
		IfWinActive,ahk_group cn
		{
			setChineseLayout()
			TrayTip,AHK, 已自动切换到中文输入法
			return
		}
		IfWinActive,ahk_group editor
		{
			setEnglishLayout()
			TrayTip,AHK, 已自动切换到英文输入法
			return
		}
	}
}

;打开Android Studio
#a::ActivateAndOpen("Android Studio","studio64.exe")
return

;打开CLion
#c::ActivateAndOpen("CLion","clion64.exe")
return

;打开pycharm
#p::ActivateAndOpen("PyCharm","pycharm.exe")
return

;打开Shell
#s::ActivateAndOpen("Xshell","Xshell.exe")
return

;打开xftp
#f::ActivateAndOpen("Xftp","Xftp.exe")
return

;打开chrome
#b::ActivateAndOpen("Google Chrome","chrome.exe")
return

;打开命令提示符
#d::ActivateAndOpen("Windows PowerShell","powershell.exe")
return

;打开Explorer
#e::ActivateAndOpen("Clover","explorer.exe")
return

;打开Notepad++
#n::ActivateAndOpen("Notepad++","notepad++.exe")
return

;打开Vim
#v::ActivateAndOpen("GVIM","gvim.exe")
return

;打开Foxmail
#m::ActivateAndOpen("Foxmail","Foxmail.exe")
return

;打开番茄土豆
#t::run "C:\Users\younggao\AppData\Local\Pomotodo\pomotodo.exe"
return

;删除
^`;::send {Backspace}
return

;delete
;^+`;::send {Delete}
;return

;在指定编辑器下
#IfWinActive,ahk_group editor
;esc进入英文输入
~Esc::
sleep 50
setEnglishLayout()
return
#IfWinActive

;HJKL 方向键
^h:: Send {left}
^l:: Send {right}
^j:: Send {down}
^k:: Send {up}
return

;PrtSrc 截图
printscreen:: 
Send {Ctrl Down}{Alt Down}{a}
Send {Ctrl Up}{Alt Up}
return

;在Chrome
#IfWinActive,ahk_exe chrome.exe
;esc退出编辑框
~Esc:: 
ControlClick,x1830 y1073
return
#IfWinActive



;/usr/local/taf/bin/jce2cpp
:c*:jce2cpp::/usr/local/taf/bin/jce2cpp 
return

; /usr/local/taf/create_taf_server.sh
:c*:createtaf:: /usr/local/taf/create_taf_server.sh 
return