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
	Field player:Player
	Field help:Image
	Field gameover:Image
	Field levels:Image
	Field level_image:Image
	Field level:Int
	Field Enemies:Int
	Field player_sprite:Image
	Field player_speed:Float = 5
	Field player_lives:Int
	Field lives:Image
	Field player_laser:List<Laser>
	Field alien_laser:List<Laser2>
	Field bluelaser:Image
	Field redlaser:Image
	Field speed:List<Speed>
	Field bomb:List<Bomb>
	Field shield:List<Shield>
	Field player_powerup:Int
	Field powerupsprite:Image
	Field SpeedSeconds:Int = 0
	Field SpeedTimer:Float = Millisecs()
	Field ShieldSeconds:Int = 0
	Field ShieldTimer:Float = Millisecs()
	Field BombSeconds:Int = 0
	Field BombTimer:Float = Millisecs()
	Field alienT1:List<AlienT1>
	Field alienT2:List<AlienT2>
	Field alienT3:List<AlienT3>
	Field alienT4:List<AlienT4>
	Field alienT5:List<AlienT5>
	Field Score:Int = 0
	Field laser:Sound
	Field explosion:Sound
	Field bombsound:Sound
	Field speedsound:Sound
	Field shieldsound:Sound
	Global GameState:String = "MENU"
	
	Method OnCreate ()
	'All the initialisation for the game goes here:
		SetUpdateRate 60
		SetMusicVolume(0.25)
		SetChannelVolume(0,1)
		SetChannelVolume(1,1)
		SetChannelVolume(2,0.2)
		SetChannelVolume(3,0.1)
		menu = LoadImage ("Menu.png")
		levels = LoadImage("Levels.png")
		help = LoadImage("Help.png")
		gameover = LoadImage("Gameover.png")
		bluelaser = LoadImage("bluelaser.png")
		redlaser = LoadImage("redlaser.png")
		player = New Player
		player_laser = New List<Laser>
		alien_laser = New List<Laser2>
		alienT1 = New List<AlienT1>
		alienT2 = New List<AlienT2>
		alienT3 = New List<AlienT3>
		alienT4 = New List<AlienT4>
		alienT5 = New List<AlienT5>
		speed = New List<Speed>
		bomb = New List<Bomb>
		shield = New List<Shield>
		laser = LoadSound("LaserSound.wav")
		explosion = LoadSound("ExplosionSound.wav")
		bombsound = LoadSound("BombSound.wav")
		speedsound = LoadSound("SpeedSound.wav")
		shieldsound = LoadSound("ShieldSound.wav")
	End

	Method OnUpdate ()
	'All the game logic goes here:
		Select GameState
			Case "MENU" 'Mouse detections for different button using coordinates on main menu
				level = 1
				player_powerup = 0
				Score = 0
				If KeyHit(KEY_LMB) Then
					If collision(MouseX,MouseY,0,0,266,200,157,59) Then 
						PlayMusic ("GameMusic.wav")
						GameState = "LOADING"
					End
					If collision(MouseX,MouseY,0,0,96,300,508,59) Then 
						GameState = "LEVELS"
					End
					If collision(MouseX,MouseY,0,0,269,400,152,59) Then 
						GameState = "HELP"
					End
				End
			Case "HELP" 'Back button to return to menu using coordinates
				If KeyHit(KEY_LMB) Then
					If collision(MouseX,MouseY,0,0,562,644,134,54) Then
						GameState = "MENU"
					End
				End
			Case "LEVELS"
				If KeyHit(KEY_LMB) Then
					If collision(MouseX,MouseY,0,0,100,165,100,100) Then
						PlayMusic ("GameMusic.wav")
						GameState = "LOADING"
					End
					If collision(MouseX,MouseY,0,0,300,165,100,100) Then 
						level = 2
						PlayMusic ("GameMusic.wav")
						GameState = "LOADING"
						
					End
					If collision(MouseX,MouseY,0,0,500,165,100,100) Then 
						level = 3
						PlayMusic ("GameMusic.wav")
						GameState = "LOADING"
					End
					If collision(MouseX,MouseY,0,0,100,365,100,100) Then 
						level = 4
						PlayMusic ("GameMusic.wav")
						GameState = "LOADING"
					End
					If collision(MouseX,MouseY,0,0,300,365,100,100) Then 
						level = 5
						PlayMusic ("GameMusic.wav")
						GameState = "LOADING"
					End
					If collision(MouseX,MouseY,0,0,500,365,100,100) Then 
						level = 6
						PlayMusic ("GameMusic.wav")
						GameState = "LOADING"
					End
					If collision(MouseX,MouseY,0,0,562,644,134,54) Then 
						GameState = "MENU"
					End
				End
			Case "LOADING"
				player_speed = 5
				player_lives = 3
				SpeedSeconds = 0
				BombSeconds = 0
				ShieldSeconds = 0
				For Local laser:=Eachin player_laser 'Lots of removal functions to delete objects before loading up any levels
					player_laser.Remove laser
				Next
				For Local laser:=Eachin alien_laser
					alien_laser.Remove laser
				Next
				For Local t1:=Eachin alienT1
					alienT1.Remove t1
				Next
				For Local t2:=Eachin alienT2
					alienT2.Remove t2
				Next
				For Local t3:=Eachin alienT3
					alienT3.Remove t3
				Next
				For Local t4:=Eachin alienT4
					alienT4.Remove t4
				Next
				For Local t5:=Eachin alienT5
					alienT5.Remove t5
				Next
				For Local s:= Eachin speed
					speed.Remove s
				Next
				For Local s:= Eachin shield
					shield.Remove s
				Next
				For Local s:= Eachin bomb
					bomb.Remove s
				Next
				player.x = 320
				player.y = 650
				If level = 1 'Sets all variables and spawns all objects in for Level 1
					level_image = LoadImage("Level1.png")
					Enemies = 10
					alienT1.AddLast(New AlienT1 (250,-200))
					alienT2.AddLast(New AlienT2 (400,-300))
					alienT3.AddLast(New AlienT3 (325,-300))
					alienT4.AddLast(New AlienT4 (200,-500))
					alienT4.AddLast(New AlienT4 (250,-550))
					alienT4.AddLast(New AlienT4 (150,-550))
					alienT4.AddLast(New AlienT4 (200,-600))
					alienT4.AddLast(New AlienT4 (100,-600))
					alienT4.AddLast(New AlienT4 (300,-600))
					alienT5.AddLast(New AlienT5 (500,-900))
					speed.AddLast(New Speed (300,-700))
				End
				If level = 2 'Sets all variables and spawns all objects in for Level 2
					level_image = LoadImage("Level2.png")
					Enemies = 15
					alienT1.AddLast(New AlienT1 (200,-130))
					alienT1.AddLast(New AlienT1 (500,-200))
					alienT1.AddLast(New AlienT1 (320,-310))
					alienT1.AddLast(New AlienT1 (130,-350))
					alienT1.AddLast(New AlienT1 (470,-450))
					alienT1.AddLast(New AlienT1 (600,-520))
					alienT1.AddLast(New AlienT1 (370,-600))
					alienT1.AddLast(New AlienT1 (410,-750))
					alienT1.AddLast(New AlienT1 (210,-820))
					alienT1.AddLast(New AlienT1 (60,-900))
					alienT1.AddLast(New AlienT1 (70,-1000))
					alienT3.AddLast(New AlienT3 (350,-500))
					alienT1.AddLast(New AlienT1 (380,-1250))
					alienT1.AddLast(New AlienT1 (280,-1250))
					alienT1.AddLast(New AlienT1 (350,-1300))
					shield.AddLast(New Shield (500,-700))
				End
				If level = 3 'Sets all variables and spawns all objects in for Level 3
					level_image = LoadImage("Level3.png")
					Enemies = 20
					alienT2.AddLast(New AlienT2 (350,-100))
					alienT2.AddLast(New AlienT2 (200,-300))
					alienT2.AddLast(New AlienT2 (574,-630))
					alienT2.AddLast(New AlienT2 (200,-800))
					alienT1.AddLast(New AlienT1 (170,-125))
					alienT1.AddLast(New AlienT1 (620,-350))
					alienT1.AddLast(New AlienT1 (290,-600))
					alienT1.AddLast(New AlienT1 (300,-1050))
					alienT1.AddLast(New AlienT1 (500,-1050))
					alienT2.AddLast(New AlienT2 (420,-1100))
					alienT2.AddLast(New AlienT2 (160,-1400))
					alienT2.AddLast(New AlienT2 (260,-1700))
					alienT2.AddLast(New AlienT2 (530,-2000))
					alienT1.AddLast(New AlienT1 (410,-1300))
					alienT1.AddLast(New AlienT1 (480,-1350))
					alienT1.AddLast(New AlienT1 (170,-1600))
					alienT1.AddLast(New AlienT1 (450,-1750))
					alienT1.AddLast(New AlienT1 (220,-1750))
					alienT3.AddLast(New AlienT3 (330,-1000))
					alienT3.AddLast(New AlienT3 (400,-1100))
					bomb.AddLast(New Bomb(400,-700))
				End
				If level = 4 'Sets all variables and spawns all objects in for Level 4
					level_image = LoadImage("Level4.png")
					Enemies = 25
					alienT3.AddLast(New AlienT3 (400,-30))
					alienT2.AddLast(New AlienT2 (330,-100))
					alienT2.AddLast(New AlienT2 (560,-250))
					alienT2.AddLast(New AlienT2 (600,-400))
					alienT1.AddLast(New AlienT1 (200,-300))
					alienT1.AddLast(New AlienT1 (230,-400))
					alienT1.AddLast(New AlienT1 (290,-300))
					alienT5.AddLast(New AlienT5 (650,-1000))
					alienT5.AddLast(New AlienT5 (100,-2000))
					alienT4.AddLast(New AlienT4 (200,-500))
					alienT4.AddLast(New AlienT4 (250,-550))
					alienT4.AddLast(New AlienT4 (150,-550))
					alienT4.AddLast(New AlienT4 (200,-600))
					alienT4.AddLast(New AlienT4 (100,-600))
					alienT4.AddLast(New AlienT4 (300,-600))	
					alienT3.AddLast(New AlienT3 (200,-800))
					alienT2.AddLast(New AlienT2 (450,-1000))
					alienT2.AddLast(New AlienT2 (370,-1100))
					alienT1.AddLast(New AlienT1 (150,-1250))
					alienT1.AddLast(New AlienT1 (290,-1350))
					alienT1.AddLast(New AlienT1 (400,-1300))
					alienT3.AddLast(New AlienT3 (300,-900))
					alienT3.AddLast(New AlienT3 (400,-1000))
					alienT1.AddLast(New AlienT1 (550,-2000))
					alienT2.AddLast(New AlienT2 (150,-2000))
					shield.AddLast(New Shield(300,-3000))		
				End
				If level = 5 'Sets all variables and spawns all objects in for Level 5
					level_image = LoadImage("Level5.png")
					Enemies = 30
					alienT4.AddLast(New AlienT4 (400,-250))
					alienT4.AddLast(New AlienT4 (300,-250))
					alienT4.AddLast(New AlienT4 (250,-200))
					alienT4.AddLast(New AlienT4 (350,-200))
					alienT4.AddLast(New AlienT4 (300,-150))
					alienT4.AddLast(New AlienT4 (350,-100))
					alienT4.AddLast(New AlienT4 (400,-150))
					alienT4.AddLast(New AlienT4 (450,-200))
					alienT4.AddLast(New AlienT4 (200,-250))
					alienT4.AddLast(New AlienT4 (500,-250))
					alienT2.AddLast(New AlienT2 (250,-1000))
					alienT2.AddLast(New AlienT2 (350,-1100))
					alienT2.AddLast(New AlienT2 (150,-1100))
					alienT2.AddLast(New AlienT2 (200,-1050))
					alienT2.AddLast(New AlienT2 (300,-1050))
					alienT1.AddLast(New AlienT1 (500,-1300))
					alienT1.AddLast(New AlienT1 (550,-1350))
					alienT1.AddLast(New AlienT1 (450,-1350))
					alienT3.AddLast(New AlienT3 (420,-900))
					alienT3.AddLast(New AlienT3 (540,-1000))
					alienT3.AddLast(New AlienT3 (340,-1000))
					alienT3.AddLast(New AlienT3 (420,-1100))
					alienT5.AddLast(New AlienT5 (300,-3300))
					alienT5.AddLast(New AlienT5 (260,-3400))
					alienT5.AddLast(New AlienT5 (220,-3500))
					alienT2.AddLast(New AlienT2 (360,-3000))
					alienT2.AddLast(New AlienT2 (310,-3050))
					alienT2.AddLast(New AlienT2 (410,-3100))
					alienT2.AddLast(New AlienT2 (260,-3150))
					alienT2.AddLast(New AlienT2 (210,-3200))
					speed.AddLast(New Speed(350,-50))
				End
				If level = 6 'Sets all variables and spawns all objects in for Level 6
					level_image = LoadImage("Level6.png")
					Enemies = 40
					alienT2.AddLast(New AlienT2(300,-250))
					alienT3.AddLast(New AlienT3(150,-125))
					alienT1.AddLast(New AlienT1(450,-300))
					alienT1.AddLast(New AlienT1(500,-300))
					alienT5.AddLast(New AlienT5(240,-700))
					alienT4.AddLast(New AlienT4(280,-800))
					alienT4.AddLast(New AlienT4(330,-850))
					alienT4.AddLast(New AlienT4(150,-850))
					alienT4.AddLast(New AlienT4(430,-900))
					alienT4.AddLast(New AlienT4(230,-900))
					alienT4.AddLast(New AlienT4(380,-900))
					alienT2.AddLast(New AlienT2(540,-1200))
					alienT2.AddLast(New AlienT2(240,-1220))
					alienT5.AddLast(New AlienT5(550,-2000))
					alienT3.AddLast(New AlienT3(320,-1000))
					alienT3.AddLast(New AlienT3(220,-1100))
					alienT3.AddLast(New AlienT3(420,-1100))
					alienT1.AddLast(New AlienT1(150,-1400))
					alienT1.AddLast(New AlienT1(280,-1490))
					alienT1.AddLast(New AlienT1(450,-1580))
					alienT1.AddLast(New AlienT1(300,-2300))
					alienT1.AddLast(New AlienT1(430,-2400))
					alienT3.AddLast(New AlienT3(200,-1200))
					alienT5.AddLast(New AlienT5(50,-4000))
					alienT5.AddLast(New AlienT5(550,-4500))
					alienT2.AddLast(New AlienT2(300,-2600))
					alienT2.AddLast(New AlienT2(400,-2600))
					alienT2.AddLast(New AlienT2(500,-2600))
					alienT2.AddLast(New AlienT2(200,-2600))
					alienT2.AddLast(New AlienT2(100,-2600))
					alienT3.AddLast(New AlienT3(200,-1750))
					alienT3.AddLast(New AlienT3(300,-1750))
					alienT3.AddLast(New AlienT3(400,-1750))
					alienT3.AddLast(New AlienT3(500,-1750))
					alienT3.AddLast(New AlienT3(600,-1750))
					alienT5.AddLast(New AlienT5(330,-5500))
					alienT2.AddLast(New AlienT2(470,-3800))
					alienT2.AddLast(New AlienT2(320,-4000))
					alienT2.AddLast(New AlienT2(220,-4200))
					alienT2.AddLast(New AlienT2(100,-4400))
					bomb.AddLast(New Bomb(200,-100))
					
				End
				GameState = "PLAY"
			Case "PLAY" 'Input keys for basic movement and the main firing method of the player's ship
				If player_lives = 3
					lives = LoadImage("Lives3.png")
				Elseif player_lives = 2
					lives = LoadImage("Lives2.png")
				ElseIf player_lives = 1
					lives = LoadImage("Lives1.png")
				Else
					GameState = "GAMEOVER"
				End
				If Score <= 0 Then
					Score = 0
				End
				If KeyDown(KEY_LEFT) Or KeyDown(KEY_A) Then player.Move(-player_speed)
				If KeyDown(KEY_RIGHT) Or KeyDown(KEY_D) Then player.Move(player_speed)
				If KeyHit(KEY_SPACE) Then
					player_laser.AddLast(New Laser(player.x,player.y))
					PlaySound(laser,0,0)
				End
				If KeyHit(KEY_W) Or KeyHit(KEY_UP) Then
					If player_powerup = 1
						player_powerup = 0
						SpeedSeconds = 10
						player_speed = 7
						PlaySound(speedsound,2,0)
					Else If player_powerup = 2
						player_powerup = 0
						ShieldSeconds = 5
						PlaySound(shieldsound,2,0)
					Else If player_powerup = 3
						player_powerup = 0
						BombSeconds = 2
						PlaySound(bombsound,2,0)
					End
				End
				If SpeedSeconds > 0
					If Millisecs() - SpeedTimer > 1000 Then
						SpeedTimer = Millisecs()
						SpeedSeconds -= 1
					End
				End
				If ShieldSeconds > 0
					If Millisecs() - ShieldTimer > 1000 Then
						ShieldTimer = Millisecs()
						ShieldSeconds -= 1
					End
				End
				If BombSeconds > 0
					If Millisecs() - BombTimer > 1000 Then
						BombTimer = Millisecs()
						BombSeconds -= 1
					End
				End
				If SpeedSeconds = 0
					player_speed = 5
				End
				If ShieldSeconds = 0
					player_sprite = LoadImage("Player1.png")
				End
				For Local s:=Eachin speed
					s.Move(5)
					If collision(s.x,s.y,50,50, player.x, player.y, 40, 40) Then
						speed.Remove s
						If player_powerup = 0 Then
							player_powerup = 1
						End
					End
				Next
				For Local s:=Eachin shield
					s.Move(5)
					If collision(s.x,s.y,50,50, player.x, player.y, 40, 40) Then
						shield.Remove s
						If player_powerup = 0 Then
							player_powerup = 2
						End
					End
				Next
				For Local s:=Eachin bomb
					s.Move(5)
					If collision(s.x,s.y,50,50, player.x, player.y, 40, 40) Then
						bomb.Remove s
						If player_powerup = 0 Then
							player_powerup = 3
						End
					End
				Next
						
				For Local laser:=Eachin player_laser 'Method to make all lasers move up until they reach the top
					laser.Move(5)
					If laser.y<10 Then player_laser.Remove laser
				Next
				For Local laser2:=Eachin alien_laser
					laser2.Move(5)
					If laser2.y>680 Or laser2.y < 0 Then alien_laser.Remove laser2
					If ShieldSeconds = 0
						If collision(laser2.x,laser2.y,5,15, player.x, player.y, 40, 40) Then
							alien_laser.Remove laser2
							player_lives -= 1
							Score -= 100
						End
					Else If ShieldSeconds > 0
						If collision(laser2.x,laser2.y,5,15, player.x, player.y, 60, 60) Then
							alien_laser.Remove laser2
						End
					End
				Next
				For Local t1:=Eachin alienT1
					t1.Move(-2)
					For Local laser:=Eachin player_laser
						If collision(t1.x,t1.y,34,35, laser.x, laser.y, 5, 15) Then
							PlaySound(explosion,3,0)
							Enemies -= 1
							alienT1.Remove t1
							player_laser.Remove laser
							Score += 20
						End
					Next
					If t1.seconds = 0 Then
						alien_laser.AddLast(New Laser2(t1.x,t1.y))
						t1.seconds = 3
						If t1.y > 0
							PlaySound(laser,1,0)
						End
					End
					If t1.seconds > 0
						If Millisecs() - t1.timer > 1000 Then
							t1.timer = Millisecs()
							t1.seconds -= 1
						End
					End
					If t1.y > 630 Then 
						Enemies -= 1
						player_lives -= 1
						alienT1.Remove t1
						Score -= 100
					End
					If BombSeconds > 0 And t1.y > 0
						alienT1.Remove t1
						Enemies -= 1
					End
				Next
				For Local t2:=Eachin alienT2
					t2.Move(-2)
					For Local laser:=Eachin player_laser
						If collision(t2.x,t2.y,34,35, laser.x, laser.y, 5, 15) Then
							t2.lives = t2.lives - 1
							player_laser.Remove laser
						End
					Next
					If t2.seconds = 0 Then
						alien_laser.AddLast(New Laser2(t2.x,t2.y))
						t2.seconds = 2
						If t2.y > 0
							PlaySound(laser,1,0)
						End
					End
					If t2.seconds > 0 Then
						If Millisecs() - t2.timer > 1000 Then
							t2.timer = Millisecs()
							t2.seconds -= 1
						End
					End
					If t2.lives = 0 Then
						PlaySound(explosion,3,0)
						alienT2.Remove t2
						Enemies -= 1
						Score += 30
					End
					If t2.y > 630 Then 
						Enemies -= 1
						player_lives -= 1
						alienT2.Remove t2
						Score -= 100
					End	
					If BombSeconds > 0 And t2.y > 0
						alienT2.Remove t2
						Enemies -= 1
					End					
				Next
				For Local t3:=Eachin alienT3
					t3.Move(-1)
					For Local laser:=Eachin player_laser
						If collision(t3.x,t3.y,34,35, laser.x, laser.y, 5, 15) Then
							t3.lives -= 1
							player_laser.Remove laser
						End
					Next
					If t3.seconds = 0 Then
						alien_laser.AddLast(New Laser2(t3.x,t3.y))
						t3.seconds = 1
						If t3.y > 0
							PlaySound(laser,1,0)
						End
					End
					If t3.seconds > 0 Then
						If Millisecs() - t3.timer > 1000 Then
							t3.timer = Millisecs()
							t3.seconds -= 1
						End
					End
					If t3.lives = 0 Then 
						PlaySound(explosion,3,0)
						alienT3.Remove t3
						Enemies -= 1
						Score += 50
					End
					If t3.y > 630 Then 
						player_lives -= 1
						Enemies -= 1
						alienT3.Remove t3
						Score -= 100
					End
					If BombSeconds > 0 And t3.y > 0
						alienT3.Remove t3
						Enemies -= 1
					End
				Next
				For Local t4:=Eachin alienT4
					t4.Move(-1)
					For Local laser:=Eachin player_laser
						If collision(t4.x,t4.y,34,35, laser.x, laser.y, 5, 15) Then
							PlaySound(explosion,3,0)
							Enemies -= 1
							alienT4.Remove t4
							player_laser.Remove laser
							Score += 10
						End
					Next
					If t4.seconds = 0
						alien_laser.AddLast(New Laser2(t4.x,t4.y))
						t4.seconds = 2
						If t4.y > 0
							PlaySound(laser,1,0)
						End
					End
					If t4.seconds > 0 Then
						If Millisecs() - t4.timer > 1000 Then
							t4.timer = Millisecs()
							t4.seconds -= 1
						End
					End	
					If t4.y > 630 Then
						Enemies -= 1
						player_lives -= 1
						alienT4.Remove t4
						Score -= 100
					End
					If BombSeconds > 0 And t4.y > 0
						alienT4.Remove t4
						Enemies -= 1
					End
				Next
				For Local t5:=Eachin alienT5
					t5.Move(-4)
					For Local laser:=Eachin player_laser
						If collision(t5.x,t5.y,34,35, laser.x, laser.y, 5, 15) Then
							PlaySound(explosion,3,0)
							Enemies -= 1
							alienT5.Remove t5
							player_laser.Remove laser
							Score += 25
						End
					Next
					If t5.y > 630 Then 
						Enemies -= 1
						player_lives -= 1
						alienT5.Remove t5
						Score -= 100
					End
					If BombSeconds > 0 And t5.y > 0
						alienT5.Remove t5
						Enemies -= 1
					End
				Next
				If Enemies = 0
					If level = 6
						GameState = "MENU"
					Else
						level += 1
						GameState = "LOADING"
					End
				End			
							
				
				
			Case "GAMEOVER"
				StopMusic()
				If KeyHit(KEY_LMB) Then
					If collision(MouseX,MouseY,0,0,212,463,276,54) Then
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
			Case "LEVELS"
				DrawImage levels, 0,0
			Case "HELP"
				DrawImage help, 0,0
			Case "PLAY"
				DrawImage level_image, 0,0
				If ShieldSeconds > 0 Then
					player_sprite = LoadImage("PlayerShield.png")
					DrawImage player_sprite, player.x, player.y
				Elseif player_lives = 1
					player_sprite = LoadImage("Player1L.png")
					DrawImage player_sprite, player.x, player.y
				Elseif player_lives = 2
					player_sprite = LoadImage("Player2L.png")
					DrawImage player_sprite, player.x, player.y
				Else
					player_sprite = LoadImage("Player3L.png")
					DrawImage player_sprite, player.x, player.y
				End
				DrawText "Enemies remaining:", 240,20
				DrawText Enemies, 370,20
				DrawText "Score:", 10,20
				DrawText Score, 60,20
				DrawImage lives, 650,670
				If player_powerup = 1
					powerupsprite = LoadImage("Speed.png")
					DrawImage powerupsprite, 30,670
				Elseif player_powerup = 2
					powerupsprite = LoadImage("Shield.png")
					DrawImage powerupsprite, 30,670
				Elseif player_powerup = 3
					powerupsprite = LoadImage("Bomb.png")
					DrawImage powerupsprite, 30,670
				Else
					DrawText "No powerup", 30,670
				End
				For Local laser:=Eachin player_laser
					DrawImage bluelaser, laser.x, laser.y
				Next
				For Local laser:=Eachin alien_laser
					DrawImage redlaser, laser.x, laser.y
				Next
				For Local t1:=Eachin alienT1
					DrawImage t1.sprite, t1.x, t1.y
				Next
				For Local t2:=Eachin alienT2
					DrawImage t2.sprite, t2.x, t2.y
				Next
				For Local t3:=Eachin alienT3
					DrawImage t3.sprite, t3.x, t3.y
				Next
				For Local t4:=Eachin alienT4
					DrawImage t4.sprite, t4.x, t4.y
				Next
				For Local t5:=Eachin alienT5
					DrawImage t5.sprite, t5.x, t5.y
				Next
				For Local s:=Eachin speed
					DrawImage s.sprite, s.x, s.y
				Next
				For Local s:=Eachin shield
					DrawImage s.sprite, s.x, s.y
				Next
				For Local s:=Eachin bomb
					DrawImage s.sprite, s.x, s.y
				Next
				
			Case "GAMEOVER"
				DrawImage gameover, 0,0
				DrawText "Score:", 10,20
				DrawText Score, 60,20
		End
	End
End



'A function that takes the position and parameters of two objects and tests to see if they collide
Function collision:Bool (x1:Int, y1:Int, w1:Int, h1:Int, x2:Int, y2:Int, w2:Int, h2:Int)
	If x1 >= (x2 + w2) Or (x1 + w1) <= x2 Then Return False
	If y1 >= (y2 + h2) Or (y1 + h1) <= y2 Then Return False
	Return True
End

	
Class Player
	Field x:Float = 320
	Field y:Float = 650
	
	Method Move (x_distance:Int)
		x+=x_distance
		If x<-6 Then x=-6
		If x>666 Then x=666
	End
End

Class Laser
	Field x:Float
	Field y:Float
	
	Method New(x_spawn:Int,y_spawn:Int)
		x = x_spawn+18
		y = y_spawn
	End
	
	Method Move (y_distance:Int)
		y-=y_distance
	End
End

Class Laser2
	Field x:Float
	Field y:Float
	
	Method New(x_spawn:Int,y_spawn:Int)
		x = x_spawn+18
		y = y_spawn+20
	End
	
	Method Move (y_distance:Int)
		y+=y_distance
	End
End

Class Speed
	Field x:Float
	Field y:Float
	Field sprite:Image = LoadImage("Speed.png")
	
	Method New(x_spawn:Int,y_spawn:Int)
		x = x_spawn
		y = y_spawn
	End
	
	Method Move (y_distance:Int)
		y+=y_distance
	End
End

Class Shield
	Field x:Float
	Field y:Float
	Field sprite:Image = LoadImage("Shield.png")
	
	Method New(x_spawn:Int,y_spawn:Int)
		x = x_spawn
		y = y_spawn
	End
	
	Method Move (y_distance:Int)
		y+=y_distance
	End
End

Class Bomb
	Field x:Float
	Field y:Float
	Field sprite:Image = LoadImage("Bomb.png")
	
	Method New(x_spawn:Int,y_spawn:Int)
		x = x_spawn
		y = y_spawn
	End
	
	Method Move (y_distance:Int)
		y+=y_distance
	End
End

Class AlienT1
	Field x:Float
	Field y:Float
	Field timer:Float = Millisecs()
	Field seconds:Int = 0	
	Field sprite:Image = LoadImage("Tier1.png")
	
	Method New(x_spawn:Int,y_spawn:Int)
		x = x_spawn
		y = y_spawn
	End
	
	Method Move (y_distance:Int)
		y-=y_distance
	End
End

Class AlienT2
	Field x:Float
	Field y:Float
	Field timer:Float = Millisecs()
	Field seconds:Int = 0	
	Field lives:Float = 2
	Field sprite:Image = LoadImage("Tier2.png")
	
	Method New(x_spawn:Int,y_spawn:Int)
		x = x_spawn
		y = y_spawn
	End
	
	Method Move (y_distance:Int)
		y-=y_distance
	End
End

Class AlienT3
	Field x:Float
	Field y:Float
	Field timer:Float = Millisecs()
	Field seconds:Int = 0	
	Field lives:Float = 3
	Field sprite:Image = LoadImage("Tier3.png")
	
	Method New(x_spawn:Int,y_spawn:Int)
		x = x_spawn
		y = y_spawn
	End
	
	Method Move (y_distance:Int)
		y-=y_distance
	End
End

Class AlienT4
	Field x:Float
	Field y:Float
	Field timer:Float = Millisecs()
	Field seconds:Int = 0	
	Field sprite:Image = LoadImage("Tier4.png")
	
	Method New(x_spawn:Int,y_spawn:Int)
		x = x_spawn
		y = y_spawn
	End
	
	Method Move (y_distance:Int)
		y-=y_distance
	End
End

Class AlienT5
	Field x:Float
	Field y:Float
	Field timer:Float = Millisecs()
	Field seconds:Int = 0	
	Field sprite:Image = LoadImage("Tier5.png")
	
	Method New(x_spawn:Int,y_spawn:Int)
		x = x_spawn
		y = y_spawn
	End
	
	Method Move (y_distance:Int)
		y-=y_distance
	End
End
	
	