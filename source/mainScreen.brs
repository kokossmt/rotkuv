sub mainScreen()
    
	m.sound_select.Trigger(50)
	
	background = [
		CreateObject("roBitmap", "pkg:/images/wallpaper1.jpg"),
		CreateObject("roBitmap", "pkg:/images/wallpaper2.jpg"),
		CreateObject("roBitmap", "pkg:/images/wallpaper3.jpg"),
		CreateObject("roBitmap", "pkg:/images/wallpaper4.jpg"),
		CreateObject("roBitmap", "pkg:/images/wallpaper5.jpg")
	]
	
	font = CreateObject("roFontRegistry")
    font.Register("pkg:/fonts/Gothic-Bold.ttf")
	font_50 = font.GetFont("Century Gothic", 50, True, False)
	
	menu = ["Телеканалы", "Фильмы", "Мультфильми", "Сериалы", "Настройки"]
	
	content = {
		background : background,
		logo : m.logo,
		select : CreateObject("roBitmap", "pkg:/images/main_menu_sel.png"),
		font : font_50,
		color_text : &hebebebff,
		color_text_sel : &h52D681ff,
		menu : menu
	}
    
	index = 0
    last_index = 0
    
    DrawMenu(index, content)
 
    while(true)
        msg = wait(0, m.port) 
        if type(msg) = "roUniversalControlEvent" then
            button = msg.GetInt()
            if((button = 3) or (button = 5)) then
                m.sound_change.Trigger(50)
                index = index + 1
                if(index > 4) then
                    index = 0
                end if
            else if((button = 2) or (button = 4)) then
                m.sound_change.Trigger(50)
                index = index - 1
                if(index < 0) then
                    index = 4
                end if           
            else if(button = 6) then
                m.sound_select.Trigger(50)
                if(index = 4) then
                    SettingsMenu()
				else if(index = 0)
					TvChanels()	
                end if
				last_index = 5
            end if
        end if     
        if(index <> last_index) then
            last_index = index
            DrawMenu(index, content)   
        end if
    end while

end sub

function DrawMenu(index, content)

	m.screen.Clear(&h000000FF)
	
	m.screen.DrawScaledObject(0, 0, 1, 1, content.background[index], &hFFFFFF40)	
    m.screen.DrawObject(100, 100, content.logo)
	
	for i = 0 to 4 step 1
		color = content.color_text
		if(index = i) then
			color = content.color_text_sel
			m.screen.DrawObject(400, 85 + index * 100, content.select)
		end if
		fw = content.font.GetOneLineWidth(content.menu[i], m.screen.GetWidth())
		x% = (m.screen.GetWidth() - fw) / 2
		y% = i * 100 + 100
		m.screen.DrawText(content.menu[i], x%, y%, color, content.font)	
	end for

	m.screen.SwapBuffers()
  
end function
