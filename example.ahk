#SingleInstance force
#include SourceGrab.ahk
mg := new MyGrabber()
return

; Sample implementation to pull doctype from source
class MyGrabber extends SourceGrab {
	__New(){
		base.__New("F12")
		Gui, % this.GuiCmd("Add"), Text, xm yp+20 w80,  DocType:
		Gui, % this.GuiCmd("Add"), Text, % "hwndhwnd xp+50 yp w" this.GuiWidth - 80
		this.MyText := hwnd
	}
	
	ShowConfirmation(){
		if (this.Source = ""){
			this.SetTitle("Grab Failed")
		} else {
			this.SetTitle("Grab Successful!")
			RegExMatch(this.Source, "i)<!doctype (.*)>", SubPat)
			
			GuiControl,, % this.MyText, % SubPat1
		}
		base.ShowConfirmation()
	}
}
