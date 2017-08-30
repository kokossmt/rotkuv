Sub Main()

    m.port = CreateObject("roMessagePort")
    
    m.screen = CreateObject("roScreen")
    m.screen.SetPort(m.port)
    m.screen.SetAlphaEnable(true)
    m.screen.Clear(&h000000FF)
    
    m.logo = CreateObject("roBitmap", "pkg:/images/logo.png")
    
    m.fonts = CreateObject("roFontRegistry")
    m.fonts.Register("pkg:/fonts/OpenSans-Bold.ttf")
    
    m.sound_select = CreateObject("roAudioResource", "select")
    m.sound_change = CreateObject("roAudioResource", "navsingle")
    m.sound_select.Trigger(50)
    
    m.index = 0
    m.last_index = 0
    
    mainScreen()
    
    while(1)
    end while
End Sub