sub mainScreen()
    
    m.screen.Clear(&h000000FF)
    
    m.background_1 = CreateObject("roBitmap", "pkg:/images/wallpaper1.jpg")
    m.background_1.SetAlphaEnable(true)
    m.background_2 = CreateObject("roBitmap", "pkg:/images/wallpaper2.jpg")
    m.background_2.SetAlphaEnable(true)
    m.background_3 = CreateObject("roBitmap", "pkg:/images/wallpaper3.jpg")
    m.background_3.SetAlphaEnable(true)
    m.background_4 = CreateObject("roBitmap", "pkg:/images/wallpaper4.jpg")
    m.background_4.SetAlphaEnable(true)
    m.background_5 = CreateObject("roBitmap", "pkg:/images/wallpaper5.jpg")
    m.background_5.SetAlphaEnable(true)
    
    m.screen.DrawScaledObject(0, 0, 1, 1, m.background_1, &hFFFFFF40)
    m.screen.DrawObject(100, 100, m.logo)
    m.screen.Finish()
    
    m.fontc = m.fonts.GetFont("Open Sans", 50, True, False)
    
    m.xml = CreateObject("roXmlElement")
    if not m.xml.Parse(ReadAsciiFile("pkg:/xml/main_menu.xml")) then print "Parse Fail" : return
    m.punkt_1 = m.xml.GetNamedElements("element")[0].GetText()
    m.punkt_2 = m.xml.GetNamedElements("element")[1].GetText()
    m.punkt_3 = m.xml.GetNamedElements("element")[2].GetText()
    m.punkt_4 = m.xml.GetNamedElements("element")[3].GetText()
    m.punkt_5 = m.xml.GetNamedElements("element")[4].GetText()
    
    DrawMenu()
 
    while(true)
        msg = wait(0, m.port) 
        if type(msg) = "roUniversalControlEvent" then
            button = msg.GetInt()
            if((button = 3) or (button = 5)) then
                m.sound_change.Trigger(50)
                m.index = m.index + 1
                if(m.index > 4) then
                    m.index = 0
                end if
            else if((button = 2) or (button = 4)) then
                m.sound_change.Trigger(50)
                m.index = m.index - 1
                if(m.index < 0) then
                    m.index = 4
                end if           
            else if(button = 6) then
                m.sound_select.Trigger(50)
                if(m.index = 4) then
                    SettingsMenu()
                end if
            end if
        end if
        
        if(m.index <> m.last_index) then
            m.last_index = m.index
            m.screen.Clear(&h000000FF)
            if(m.index = 0) then
                m.screen.DrawScaledObject(0, 0, 1, 1, m.background_1, &hFFFFFF40)
            end if
            if(m.index = 1) then
                m.screen.DrawScaledObject(0, 0, 1, 1, m.background_2, &hFFFFFF40)
            end if
            if(m.index = 2) then
                m.screen.DrawScaledObject(0, 0, 1, 1, m.background_3, &hFFFFFF40)
            end if
            if(m.index = 3) then
                m.screen.DrawScaledObject(0, 0, 1, 1, m.background_4, &hFFFFFF40)
            end if
            if(m.index = 4) then
                m.screen.DrawScaledObject(0, 0, 1, 1, m.background_5, &hFFFFFF40)
            end if
            m.screen.DrawObject(100, 100, m.logo)
            m.screen.Finish()
            DrawMenu()   
        end if
    end while

end sub

function DrawMenu()

    fw = m.fontc.GetOneLineWidth(m.punkt_1, m.screen.GetWidth())
    x% = (m.screen.GetWidth() - fw) / 2
    if(m.index = 0) then
        m.screen.DrawText(m.punkt_1, x%, 100, &h47b427ff, m.fontc)
        DrawSelect()
    else
        m.screen.DrawText(m.punkt_1, x%, 100, &hebebebff, m.fontc)
    end if
    
    fw = m.fontc.GetOneLineWidth(m.punkt_2, m.screen.GetWidth())
    x% = (m.screen.GetWidth() - fw) / 2
    if(m.index = 1) then
        m.screen.DrawText(m.punkt_2, x%, 200, &h47b427ff, m.fontc)
        DrawSelect()
    else
        m.screen.DrawText(m.punkt_2, x%, 200, &hebebebff, m.fontc)
    end if
    
    fw = m.fontc.GetOneLineWidth(m.punkt_3, m.screen.GetWidth())
    x% = (m.screen.GetWidth() - fw) / 2
    if(m.index = 2) then
        m.screen.DrawText(m.punkt_3, x%, 300, &h47b427ff, m.fontc)
        DrawSelect()
    else
        m.screen.DrawText(m.punkt_3, x%, 300, &hebebebff, m.fontc)
    end if
    
    fw = m.fontc.GetOneLineWidth(m.punkt_4, m.screen.GetWidth())
    x% = (m.screen.GetWidth() - fw) / 2
    if(m.index = 3) then
        m.screen.DrawText(m.punkt_4, x%, 400, &h47b427ff, m.fontc)
        DrawSelect()
    else
        m.screen.DrawText(m.punkt_4, x%, 400, &hebebebff, m.fontc)
    end if
    
    fw = m.fontc.GetOneLineWidth(m.punkt_5, m.screen.GetWidth())
    x% = (m.screen.GetWidth() - fw) / 2
    if(m.index = 4) then
        m.screen.DrawText(m.punkt_5, x%, 500, &h47b427ff, m.fontc)
        DrawSelect()
    else
        m.screen.DrawText(m.punkt_5, x%, 500, &hebebebff, m.fontc)
    end if
    
    m.screen.Finish()
    
end function

function DrawSelect()

    y = m.index * 100
    m.screen.DrawLine(400, 90 + y, 880, 90 + y, &h47b427ff)
    m.screen.DrawLine(400, 190 + y, 880, 190 + y, &h47b427ff)
    m.screen.DrawLine(400, 90 + y, 400, 190 + y, &h47b427ff)
    m.screen.DrawLine(880, 90 + y, 880, 190 + y, &h47b427ff)
    m.screen.DrawLine(401, 91 + y, 879, 91 + y, &h47b427ff)
    m.screen.DrawLine(401, 189 + y, 879, 189 + y, &h47b427ff)
    m.screen.DrawLine(401, 91 + y, 401, 189 + y, &h47b427ff)
    m.screen.DrawLine(879, 91 + y, 879, 189 + y, &h47b427ff)
    
end function