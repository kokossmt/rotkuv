sub SettingsMenu()

    background = CreateObject("roBitmap", "pkg:/images/settings_bg.jpg")
    background.SetAlphaEnable(true)
		
	icon = [
		CreateObject("roBitmap", "pkg:/images/set_avatar.png"),
		CreateObject("roBitmap", "pkg:/images/set_notebook.png"),
		CreateObject("roBitmap", "pkg:/images/set_tablet.png"),
		CreateObject("roBitmap", "pkg:/images/set_umbrella.png")
	]
	
	icon_sel = [
		CreateObject("roBitmap", "pkg:/images/set_avatar_sel.png"),
		CreateObject("roBitmap", "pkg:/images/set_notebook_sel.png"),
		CreateObject("roBitmap", "pkg:/images/set_tablet_sel.png"),
		CreateObject("roBitmap", "pkg:/images/set_umbrella_sel.png")
	]
    
	font = CreateObject("roFontRegistry")
    font.Register("pkg:/fonts/Gothic-Bold.ttf")
	font_26 = font.GetFont("Century Gothic", 26, True, False)
	font_16 = font.GetFont("Century Gothic", 16, True, False)
	
	menu = [
		{row_1 : "Вход", row_2 : ""},
		{row_1 : "Подписки", row_2 : ""},
		{row_1 : "Родительский", row_2 : "контроль"},
		{row_1 : "Ввести", row_2 : "промокод"}
	]
			
	coment = [
		{row_1 : "Смотрите фильмы на всех", row_2 : "устройствах"},
		{row_1 : "Подписки и другие услуги", row_2 : ""},
		{row_1 : "Отключён", row_2 : ""},
		{row_1 : "Введите промокод для", row_2 : "активации подписки"}
	]
	
	content = {
		background : background,
		logo : m.logo
		icon : icon,
		icon_sel : icon_sel,
		form : CreateObject("roBitmap", "pkg:/images/setting_form.png"),
		form_sel : CreateObject("roBitmap", "pkg:/images/setting_form_sel.png"),
		line : CreateObject("roBitmap", "pkg:/images/set_line.png"),
		font_menu : font_26,
		font_coment : font_16,
		color_text : &hebebebff,
		color_text_sel :  &h000000ff,
		menu : menu,
		coment : coment
	}
    
    index = 0
    last_index = 0
    
    DrawSettingMenu(index, content)
    
    while(true)
	
        msg = wait(0, m.port) 
        if type(msg) = "roUniversalControlEvent" then
            button = msg.GetInt()
            if((button = 3) or (button = 5)) then
                m.sound_change.Trigger(50)
                index = index + 1
                if(index > 3) then
                    index = 0
                end if
            else if((button = 2) or (button = 4)) then
                m.sound_change.Trigger(50)
                index = index - 1
                if(index < 0) then
                    index = 3
                end if         
            else if(button = 6) then
                m.sound_select.Trigger(50)
            else if(button = 0) then
                m.sound_select.Trigger(50)
                return
            end if
			
            if(m.set_index <>  last_index) then
                last_index = index
                DrawSettingMenu(index, content)      
            end if
        end if
		
    end while

end sub

function DrawSettingMenu(index, content)

	m.screen.Clear(&h000000FF)

    m.screen.DrawScaledObject(0, 0, 1, 1, content.background, &hFFFFFFFF)
    m.screen.DrawObject(100, 100, content.logo)
	
	for i = 0 to 3 step 1
	
		x% = 314 * i
		if(index = i) then
			m.screen.DrawObject(24 + x%, 400, content.form_sel)
			m.screen.DrawObject(137 + x%, 420, content.icon_sel[i])
		else
			m.screen.DrawObject(24 + x%, 400, content.form)
			m.screen.DrawObject(137 + x%, 420, content.icon[i])
		end if	
		
		color = content.color_text
		if(index = i) then
			color = content.color_text_sel
		end if	
		
		text = content.menu[i].row_1
		fw = content.font_menu.GetOneLineWidth(text, m.screen.GetWidth())
		x% = 314 * i + (290 - fw) / 2
		m.screen.DrawText(text, 24 + x%, 510, color, content.font_menu)
		
		text = content.menu[i].row_2
		fw = content.font_menu.GetOneLineWidth(text, m.screen.GetWidth())
		x% = 314 * i + (290 - fw) / 2
		m.screen.DrawText(text, 24 + x%, 540, color, content.font_menu)
		
		text = content.coment[i].row_1
		fw = content.font_coment.GetOneLineWidth(text, m.screen.GetWidth())
		x% = 314 * i + (290 - fw) / 2
		m.screen.DrawText(text, 24 + x%, 596, color, content.font_coment)
		
		text = content.coment[i].row_2
		fw = content.font_coment.GetOneLineWidth(text, m.screen.GetWidth())
		x% = 314 * i + (290 - fw) / 2
		m.screen.DrawText(text, 24 + x%, 620, color, content.font_coment)
		
		x% = 44 + (314 * i)
		m.screen.DrawObject(x%, 580, content.line)
		
	end for
    
    m.screen.SwapBuffers()
    
end function
