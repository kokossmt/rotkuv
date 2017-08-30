sub SettingsMenu()

    m.screen.Clear(&h000000FF)
    
    m.background = CreateObject("roBitmap", "pkg:/images/settings_bg.jpg")
    m.background.SetAlphaEnable(true)

    m.avatar = CreateObject("roBitmap", "pkg:/images/set_avatar.png")
    m.notebook = CreateObject("roBitmap", "pkg:/images/set_notebook.png")
    m.tablet = CreateObject("roBitmap", "pkg:/images/set_tablet.png")    
    m.umbrella = CreateObject("roBitmap", "pkg:/images/set_umbrella.png")
    m.avatar_sel = CreateObject("roBitmap", "pkg:/images/set_avatar_sel.png")
    m.notebook_sel = CreateObject("roBitmap", "pkg:/images/set_notebook_sel.png")
    m.tablet_sel = CreateObject("roBitmap", "pkg:/images/set_tablet_sel.png")    
    m.umbrella_sel = CreateObject("roBitmap", "pkg:/images/set_umbrella_sel.png")
    
    m.form = CreateObject("roBitmap", "pkg:/images/setting_form.png")
    m.form_sel = CreateObject("roBitmap", "pkg:/images/setting_form_sel.png")
    
    m.fonta = m.fonts.GetFont("Open Sans", 28, True, False)
    
    m.set_xml = CreateObject("roXmlElement")
    if not m.set_xml.Parse(ReadAsciiFile("pkg:/xml/settings_menu.xml")) then print "Parse Fail" : return
    m.set_punkt_1 = m.set_xml.GetNamedElements("element")[0].GetText()
    m.set_punkt_2 = m.set_xml.GetNamedElements("element")[1].GetText()
    m.set_punkt_3 = m.set_xml.GetNamedElements("element")[2].GetText()
    m.set_punkt_4 = m.set_xml.GetNamedElements("element")[3].GetText()
    
    m.set_index = 0
    m.last_set_index = 0
    
    DrawSettingMenu()
    DrawSettingSelect()
    
    while(true)
        msg = wait(0, m.port) 
        if type(msg) = "roUniversalControlEvent" then
            button = msg.GetInt()
            if((button = 3) or (button = 5)) then
                m.sound_change.Trigger(50)
                m.set_index = m.set_index + 1
                if(m.set_index > 3) then
                    m.set_index = 0
                end if
            else if((button = 2) or (button = 4)) then
                m.sound_change.Trigger(50)
                m.set_index = m.set_index - 1
                if(m.set_index < 0) then
                    m.set_index = 3
                end if         
            else if(button = 6) then
                m.sound_select.Trigger(50)
            else if(button = 0) then
                m.sound_select.Trigger(50)
                mainScreen()
            end if          
            if(m.set_index <>  m.last_set_index) then
                m.last_set_index = m.set_index
                DrawSettingMenu()
                DrawSettingSelect()       
            end if
        end if
    end while

end sub

function DrawSettingMenu()

    m.screen.DrawScaledObject(0, 0, 1, 1, m.background, &hFFFFFFFF)
    m.screen.DrawObject(100, 100, m.logo)

    m.screen.DrawObject(137, 420, m.avatar)
    m.screen.DrawObject(451, 420, m.notebook)
    m.screen.DrawObject(765, 420, m.tablet)
    m.screen.DrawObject(1079, 420, m.umbrella)
    
    m.screen.DrawObject(24, 400, m.form)
    m.screen.DrawObject(338, 400, m.form)
    m.screen.DrawObject(652, 400, m.form)
    m.screen.DrawObject(966, 400, m.form)
    
    fw = m.fonta.GetOneLineWidth(m.set_punkt_1, m.screen.GetWidth())
    x% = (290 - fw) / 2
    m.screen.DrawText(m.set_punkt_1, 24 + x%, 520, &hebebebff, m.fonta)
    fw = m.fonta.GetOneLineWidth(m.set_punkt_2, m.screen.GetWidth())
    x% = (290 - fw) / 2
    m.screen.DrawText(m.set_punkt_2, 338 + x%, 520, &hebebebff, m.fonta)
    fw = m.fonta.GetOneLineWidth(m.set_punkt_3, m.screen.GetWidth())
    x% = (290 - fw) / 2
    m.screen.DrawText(m.set_punkt_3, 652 + x%, 520, &hebebebff, m.fonta)
    fw = m.fonta.GetOneLineWidth(m.set_punkt_4, m.screen.GetWidth())
    x% = (290 - fw) / 2
    m.screen.DrawText(m.set_punkt_4, 966 + x%, 520, &hebebebff, m.fonta)
    
    m.screen.Finish()
    
end function

function DrawSettingSelect()

    x = 314 * m.set_index  
    m.screen.DrawObject(24 + x, 400, m.form_sel)
    if(m.set_index = 0) then
        m.screen.DrawObject(137, 420, m.avatar_sel)
        fw = m.fonta.GetOneLineWidth(m.set_punkt_1, m.screen.GetWidth())
        x% = (290 - fw) / 2
        m.screen.DrawText(m.set_punkt_1, 24 + x%, 520, &h000000ff, m.fonta)
    else if(m.set_index = 1) then
        m.screen.DrawObject(451, 420, m.notebook_sel)
        fw = m.fonta.GetOneLineWidth(m.set_punkt_2, m.screen.GetWidth())
        x% = (290 - fw) / 2
        m.screen.DrawText(m.set_punkt_2, 338 + x%, 520, &h000000ff, m.fonta)
    else if(m.set_index = 2) then
        m.screen.DrawObject(765, 420, m.tablet_sel)
        fw = m.fonta.GetOneLineWidth(m.set_punkt_3, m.screen.GetWidth())
        x% = (290 - fw) / 2
        m.screen.DrawText(m.set_punkt_3, 652 + x%, 520, &h000000ff, m.fonta)
    else if(m.set_index = 3) then
        m.screen.DrawObject(1079, 420, m.umbrella_sel)
        fw = m.fonta.GetOneLineWidth(m.set_punkt_4, m.screen.GetWidth())
        x% = (290 - fw) / 2
        m.screen.DrawText(m.set_punkt_4, 966 + x%, 520, &h000000ff, m.fonta)
    end if
         
    m.screen.Finish()

end function