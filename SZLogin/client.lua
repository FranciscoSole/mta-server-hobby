loadstring(exports.DxLib:dgsImportFunction())()

local sx, sy = guiGetScreenSize()
local resX, resY = 1920, 1080
local x, y = (sx/resX), (sy/resY)

---[Windows]---
local login_panel = dgsCreateWindow(x*800, y*400, x*323, y*284, "[SZLogin] - by Seyer", false, _, _, _, _, _, _, _, true)
dgsWindowSetMovable(login_panel, false)
dgsWindowSetSizable(login_panel, false)
dgsSetVisible(login_panel, false)

local register_panel = dgsCreateWindow(x*800, y*400, x*326, y*340, "[SZRegister] - by Seyer", false, _, _, _, _, _, _, _, true)
dgsWindowSetMovable(register_panel, false)
dgsWindowSetSizable(register_panel, false)
dgsSetVisible(register_panel, false)

---[Tabs]---
local login_tab = dgsCreateTabPanel(x*0, y*(-22), x*323, y*283.5, false, login_panel)
local register_tab = dgsCreateTabPanel(x*0, y*(-22), x*326, y*339.5, false, register_panel)

---[Labels]---
local login_username_label = dgsCreateLabel(x*33, y*38, x*48, y*15, "Usuario:", false, login_tab)
local login_username_max = dgsCreateLabel(x*257, y*63, x*56, y*15, "(máx. 25)", false, login_tab)
local login_password_label = dgsCreateLabel(x*10, y*102, x*71, y*16, "Contraseña:", false, login_tab)
local login_password_max = dgsCreateLabel(x*257, y*128, x*56, y*15, "(máx. 25)", false, login_tab)

local register_username_label = dgsCreateLabel(x*33, y*38, x*48, y*15, "Usuario:", false, register_tab)
local register_username_max = dgsCreateLabel(x*257, y*63, x*56, y*15, "(máx. 25)", false, register_tab)
local register_password_label = dgsCreateLabel(x*10, y*102, x*71, y*16, "Contraseña:", false, register_tab)
local register_password_max = dgsCreateLabel(x*257, y*128, x*56, y*15, "(máx. 25)", false, register_tab)
local register_confirmedPassword_label = dgsCreateLabel(x*25, y*157, x*45, y*13, "Repetir", false, register_tab)
local register_confirmedPassword_label2 = dgsCreateLabel(x*10, y*170, x*71, y*16, "contraseña:", false, register_tab)
local register_confirmedPassword_max = dgsCreateLabel(x*257, y*186, x*56, y*15, "(máx. 25)", false, register_tab)

---[Buttons]---
local color = tocolor(66, 134, 244, 150) -- It's not a button, it's only a parametre to avoid repeating this function call 
local login_goLogIn_button = dgsCreateButton(x*9, y*163, x*304, y*48, "Login", false, login_tab, _, _, _, _, _, _, color, color, color)
local login_openRegister_button = dgsCreateButton(x*9, y*226, x*304, y*48, "Register", false, login_tab, _, _, _, _, _, _, color, color, color)

local register_goRegister_button = dgsCreateButton(x*9, y*224, x*304, y*48, "Register", false, register_tab, _, _, _, _, _, _, color, color, color)
local register_openLogIn_button = dgsCreateButton(x*9, y*283, x*304, y*48, "Login", false, register_tab, _, _, _, _, _, _, color, color, color)

---[Edits -> Are writables boxes]---
local login_username_edit = dgsCreateEdit(x*87, y*30, x*226, y*33, "", false, login_tab)
dgsEditSetMaxLength(login_username_edit, 25)

local login_password_edit = dgsCreateEdit(x*87, y*95, x*226, y*33, "", false, login_tab)
dgsEditSetMaxLength(login_password_edit, 25)
dgsEditSetMasked(login_password_edit, true)

local register_username_edit = dgsCreateEdit(x*87, y*30, x*226, y*33, "", false, register_tab)
dgsEditSetMaxLength(register_username_edit, 25)

local register_password_edit = dgsCreateEdit(x*87, y*95, x*226, y*33, "", false, register_tab)
dgsEditSetMaxLength(register_password_edit, 25)
dgsEditSetMasked(register_password_edit, true)

local register_confirmedPassword_edit = dgsCreateEdit(x*87, y*153, x*226, y*33, "", false, register_tab)
dgsEditSetMaxLength(register_confirmedPassword_edit, 25)
dgsEditSetMasked(register_confirmedPassword_edit, true)

--Main events
addEventHandler("onDgsMouseClick", dgsRoot,
	function(_, state)
		if state == "down" then
			if (source == login_openRegister_button) then 
				changeVisibility("openRegisterPanel")
			elseif (source == register_openLogIn_button) then 
				changeVisibility("openLoginPanel")
			elseif (source == login_goLogIn_button) or (source == register_goRegister_button) then
				local username, password, confirmedPassword = getText(source)

				if isOK(username, password, confirmedPassword) then
					if (source == login_goLogIn_button) then 
						triggerServerEvent("[SZLogin]:login", localPlayer, localPlayer, username, password)
					else 
						triggerServerEvent("[SZLogin]:register", localPlayer, localPlayer, username, password)
					end
				end
			end
		end
	end
)

addEvent("[SZLogin]:openClose", true)
addEventHandler("[SZLogin]:openClose", getLocalPlayer(),
	function(toDo)
		if toDo == "openLoginPanel" then
			dgsSetVisible(login_panel, true)
			showCursor(true)
		elseif toDo == "closeLoginRegisterPanels" then
			dgsSetVisible(login_panel, false)
			dgsSetVisible(register_panel, false)
			showCursor(false)
		end
	end
)

--Main functions
function getText(source)
	local username, password, confirmedPassword

	if (source == login_goLogIn_button) then -- If user wants to log-in
		username = dgsGetText(login_username_edit)
		password = dgsGetText(login_password_edit)
	elseif (source == register_goRegister_button) then -- If user wants to register
		username = dgsGetText(register_username_edit)
		password = dgsGetText(register_password_edit)
		confirmedPassword = dgsGetText(register_confirmedPassword_edit)
	end

	return username, password, confirmedPassword or password -- If confirmedPassword is null then player is trying to log-in and not registering. So, returns password again to generalize isOK function
end

function changeVisibility(toDo)
	if toDo == "openLoginPanel" then
		dgsSetVisible(register_panel, false)
		dgsSetVisible(login_panel, true)
	elseif toDo == "openRegisterPanel" then
		dgsSetVisible(login_panel, false)
		dgsSetVisible(register_panel, true)
	end
end

function isOK(username, password, confirmedPassword)
	if username == "" or password == "" or confirmedPassword == "" then
		exports.SZMisc:_clientErrorMsg("Please complete all the fields.")
	elseif password ~= confirmedPassword then
		exports.SZMisc:_clientErrorMsg("Passwords don't match.")
	elseif (#username < 5) then -- In Lua '#variable' returns variable's value length
		exports.SZMisc:_clientErrorMsg("Username must have 5 letters at least for security.")
	elseif (#password < 6) then -- In Lua '#variable' returns variable's value length
		exports.SZMisc:_clientErrorMsg("Passwords must have 6 letters at least for security.")
	else 
		return true 
	end
end

--Misc
addEventHandler("onClientResourceStart", getRootElement(), 
	function()
		local font = {
			[1] = dxCreateFont("font/medium.ttf", 10),
			[2] = dxCreateFont("font/medium.ttf", 14)
		}
		
		local smallerFontElements = {
			login_panel, login_username_label, login_password_label, 
			login_username_max, login_password_max,
			login_username_edit, login_password_edit,
			register_panel, register_username_label, register_password_label, register_confirmedPassword_label, register_confirmedPassword_label2, 
			register_username_max, register_password_max, register_confirmedPassword_max,
			register_username_edit, register_password_edit, register_confirmedPassword_edit
		}
		setFontToArray(smallFontElements, font[1])

		local biggerFontElements = {
			login_goLogIn_button, login_openRegister_button,
			register_goRegister_button, register_openLogIn_button
		}
		setFontToArray(biggerFontElements, font[2])

		local specialElements = {
			login_username_max, login_password_max,
			register_username_max, register_password_max, register_confirmedPassword_max
		}
		setFontColorToArray(specialElements, 255, 0, 0) -- 255, 0, 0 = red
	end
)

function setFontToArray(elementsArray, font)
	for index, element in pairs(elementsArray) do 
		dgsSetFont(element, font) 
	end
end

function setFontColorToArray(elementsArray, red, green, blue)
	for index, element in pairs(elementsArray) do 
		dgsLabelSetColor(element, red, green, blue) 
	end
end