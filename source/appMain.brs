Sub Main()

    m.port = CreateObject("roMessagePort")
    
    m.screen = CreateObject("roScreen", true)
    m.screen.SetPort(m.port)
    m.screen.SetAlphaEnable(true)
    m.screen.Clear(&h000000FF)
	m.screen.SwapBuffers()
    
    m.logo = CreateObject("roBitmap", "pkg:/images/logo.png")
    
	m.sound_select = CreateObject("roAudioResource", "select")
    m.sound_change = CreateObject("roAudioResource", "navsingle")
	m.sound_deadend = CreateObject("roAudioResource", "deadend")
	
	m.timer = CreateObject("roTimespan")
	
	
    mainScreen()
   
    
    while(1)
    end while
End Sub