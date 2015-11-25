#SingleInstance force
#include SourceGrab.ahk
mg := new MyGrabber()
return

; Sample implementation to pull doctype from source
class MyGrabber extends SourceGrab {
	__New(){
		base.__New("F12", 3000)
		fn := this.Paste.Bind(this)
		hotkey, F11, % fn
		Gui, % this.GuiCmd("Add"), Text, xm yp+20 w80,  DocType:
		Gui, % this.GuiCmd("Add"), Text, % "hwndhwnd xp+50 yp w" this.GuiWidth - 80
		this.MyText := hwnd
		
		fn := this.ShowForm.Bind(this)
		hotkey, F11, % fn
		
		Gui, 2:New
		Gui, 2:Add, Text, xm ym, Enter a URL
		Gui, 2:Add, Edit, x+5 yp-5 w200 hwndhURL, http://google.com
		this.hURL := hURL
		Gui, Add, Button, x+5 yp-1 Default hwndhwnd, Go
		fn := this.FormSubmit.Bind(this)
		GuiControl +g, % hwnd, % fn
	}
	
	ShowForm(){
		Gui 2:Show
	}
	
	FormSubmit(){
		Gui, 2: Hide
		GuiControlGet, val,, % this.hURL
		Run, % val
		Sleep 1000	; This is a very crude way of waiting for the page to load. Needs improving
		this.DoGrab()
	}
	
	ShowConfirmation(){
		if (this.Source = ""){
			this.SetTitle("Grab Failed")
			this.DocType := ""
		} else {
			this.SetTitle("Grab Successful!")
			RegExMatch(this.Source, "i)<!doctype (.*)>", SubPat)
			this.DocType := SubPat1
			GuiControl,, % this.MyText, % SubPat1
		}
		base.ShowConfirmation()
	}
	
	Paste(){
		Send % this.DocType
	}
}
