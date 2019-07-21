'Libraries and globals
Import mojo
Global Game:Game_app

'Main program starts here:
Function Main ()
	Game = New Game_app
End

'All game code goes here:
Class Game_app Extends App
	Field menu:Image
	Global GameState:String = "MENU"

	Method OnCreate ()
	'All the initialisation for the game goes here:
		SetUpdateRate 60
		menu = LoadImage ("menu.png")
		scores = LoadImage("scores.png")
		options = LoadImage("options.png")
	End

	Method OnUpdate ()
	'All the game logic goes here:
		Select GameState
			Case "MENU"
				If KeyHit(KEY_LMB) Then
					If collision(MouseX,MouseY,0,0,0,0,0,0) Then
						GameState = "PLAY"
					End
					If collision(MouseX,MouseY,0,0,0,0,0,0) Then
						GameState = "SCORES"
					End
					If collision(MouseX,MouseY,0,0,0,0,0,0) Then
						GameState = "OPTIONS"
					End
				End
			Case "SCORES"
				If KeyHit(KEY_LMB) Then
					If collision(MouseX,MouseY,0,0,0,0,0,0) Then
						GameState = "MENU"
					End
				End
			Case "OPTIONS"
				If KeyHit(KEY_LMB) Then
					If collision(MouseX,MouseY,0,0,0,0,0,0) Then
						GameState = "MENU"
					End
				End
		End
	End

	Method OnRender ()
	'All the graphics drawing goes here:
		Select GameState
			Case "MENU"
				DrawImage menu, 0,0
			Case "SCORES"
				DrawImage scores, 0,0
			Case "OPTIONS"
				DrawImage options, 0,0
		End
	
	End

End