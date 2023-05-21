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
local login_tab = dgsCreateTabPanel(x*0, y*(-22), x*323, y*283.5, false, login_panel)-- x*20 => x*0 
local register_tab = dgsCreateTabPanel(x*0, y*(-22), x*326, y*339.5, false, register_panel)-- x*20 => x*0 

---[Labels]---
local user_login = dgsCreateLabel(x*33, y*38, x*48, y*15, "Usuario:", false, login_tab)
local max_login = dgsCreateLabel(x*257, y*63, x*56, y*15, "(máx. 25)", false, login_tab)
local pw_login = dgsCreateLabel(x*10, y*102, x*71, y*16, "Contraseña:", false, login_tab)
local max2_login = dgsCreateLabel(x*257, y*128, x*56, y*15, "(máx. 25)", false, login_tab)

local user_register = dgsCreateLabel(x*33, y*38, x*48, y*15, "Usuario:", false, register_tab)
local max_register = dgsCreateLabel(x*257, y*63, x*56, y*15, "(máx. 25)", false, register_tab)
local pw_register = dgsCreateLabel(x*10, y*102, x*71, y*16, "Contraseña:", false, register_tab)
local max2_register = dgsCreateLabel(x*257, y*128, x*56, y*15, "(máx. 25)", false, register_tab)
local pw2_register = dgsCreateLabel(x*25, y*157, x*45, y*13, "Repetir", false, register_tab)
local pw2nd_register = dgsCreateLabel(x*10, y*170, x*71, y*16, "contraseña:", false, register_tab)
local max3_register = dgsCreateLabel(x*257, y*186, x*56, y*15, "(máx. 25)", false, register_tab)

---[Buttons]---
local gologin = dgsCreateButton(x*9, y*163, x*304, y*48, "Login", false, login_tab, _, _, _, _, _, _, tocolor(66, 134, 244, 150), tocolor(10, 250, 244, 150), tocolor(130, 200, 244, 150))
local turnreg = dgsCreateButton(x*9, y*226, x*304, y*48, "Register", false, login_tab, _, _, _, _, _, _, tocolor(66, 134, 244, 150), tocolor(66, 134, 244, 150), tocolor(66, 134, 244, 150))

local goregister = dgsCreateButton(x*9, y*224, x*304, y*48, "Register", false, register_tab, _, _, _, _, _, _, tocolor(66, 134, 244, 150), tocolor(66, 134, 244, 150), tocolor(66, 134, 244, 150))
local turnlog = dgsCreateButton(x*9, y*283, x*304, y*48, "Login", false, register_tab, _, _, _, _, _, _, tocolor(66, 134, 244, 150), tocolor(66, 134, 244, 150), tocolor(66, 134, 244, 150))

---[Edits]---
local user_edit_login = dgsCreateEdit(x*87, y*30, x*226, y*33, "", false, login_tab)
dgsEditSetMaxLength(user_edit_login, 25)

local pw_edit_login = dgsCreateEdit(x*87, y*95, x*226, y*33, "", false, login_tab)
dgsEditSetMaxLength(pw_edit_login, 25)
dgsEditSetMasked(pw_edit_login, true)

local user_edit_reg = dgsCreateEdit(x*87, y*30, x*226, y*33, "", false, register_tab)
dgsEditSetMaxLength(user_edit_reg, 25)

local pw_edit_reg = dgsCreateEdit(x*87, y*95, x*226, y*33, "", false, register_tab)
dgsEditSetMaxLength(pw_edit_reg, 25)
dgsEditSetMasked(pw_edit_reg, true)

local pw2_edit_reg = dgsCreateEdit(x*87, y*153, x*226, y*33, "", false, register_tab)
dgsEditSetMaxLength(pw2_edit_reg, 25)
dgsEditSetMasked(pw2_edit_reg, true)

--Main events
addEventHandler("onDgsMouseClick", dgsRoot,
	function(_, state)
		if state == "down" then
			if (source == turnreg) then changeVisibility("openRegisterPanel")
			elseif (source == turnlog) then changeVisibility("openLoginPanel")
			elseif (source == gologin) or (source == goregister) then
				local user, pw, pw2 = getText(source)
				if isOK(user, pw, pw2) then
					if (source == gologin) then triggerServerEvent("[SZLogin]:login", localPlayer, localPlayer, user, pw)
					else triggerServerEvent("[SZLogin]:register", localPlayer, localPlayer, user, pw)
					end
				end
			end
		end
	end
)

addEvent("[SZLogin]:openClose", true)
addEventHandler("[SZLogin]:openClose", getLocalPlayer(),
	function(whatDo)
		if whatDo == "openLoginPanel" then
			dgsSetVisible(login_panel, true)
			showCursor(true)
		elseif whatDo == "closeLoginRegisterPanels" then
			dgsSetVisible(login_panel, false)
			dgsSetVisible(register_panel, false)
			showCursor(false)
		end
	end
)

--Main functions
function getText(source)
	local user, pw, pw2
	if (source == gologin) then
		user = dgsGetText(user_edit_login)
		pw = dgsGetText(pw_edit_login)
	elseif (source == goregister) then
		user = dgsGetText(user_edit_reg)
		pw = dgsGetText(pw_edit_reg)
		pw2 = dgsGetText(pw2_edit_reg)
	end
	return user, pw, pw2 or pw
end

function changeVisibility(whatDo)
	if whatDo == "openLoginPanel" then
		dgsSetVisible(register_panel, false)
		dgsSetVisible(login_panel, true)
	elseif whatDo == "openRegisterPanel" then
		dgsSetVisible(login_panel, false)
		dgsSetVisible(register_panel, true)
	end
end

function isOK(user, pw, pw2)
	if user == "" or pw == "" or pw2 == "" then exports.SZMisc:_msgcl("gral", "err", "all")
	elseif pw ~= pw2 then exports.SZMisc:_msgcl("login", "err", "dist")
	elseif (#user < 5) then exports.SZMisc:_msgcl("login", "err", "uDig")
	elseif (#pw < 6) then exports.SZMisc:_msgcl("login", "err", "pwDig")
	else return true 
	end
end

--Misc
addEventHandler("onClientResourceStart", getRootElement(), 
	function()
		local font = {
			[1] = dxCreateFont("font/medium.ttf", 10),
			[2] = dxCreateFont("font/medium.ttf", 14)
		}
		
		local elementsWithFont1 = {
			[1] = login_panel,
			[2] = register_panel,
			[3] = user_login,
			[4] = pw_login,
			[5] = user_register,
			[6] = pw_register,
			[7] = pw2_register,
			[8] = pw2nd_register,
			[9] = max_login,
			[10] = max2_login,
			[11] = max_register,
			[12] = max2_register,
			[13] = max3_register,
			[14] = user_edit_login,
			[15] = pw_edit_login,
			[16] = user_edit_reg,
			[17] = pw_edit_reg,
			[18] = pw2_edit_reg
		}
		for _, v in pairs(elementsWithFont1) do dgsSetFont(v, font[1]) end

		local white_labels = {
			[1] = user_login,
			[2] = pw_login,
			[3] = user_register,
			[4] = pw_register,
			[5] = pw2_register,
			[6] = pw2nd_register
		}
		for _, v in pairs(white_labels) do dgsLabelSetColor(v, 255, 255, 255) end
		
		local red_labels = {
			[1] = max_login,
			[2] = max2_login,
			[3] = max_register,
			[4] = max2_register,
			[5] = max3_register
		}
		for _, v in pairs(red_labels) do dgsLabelSetColor(v, 255, 0, 0) end

		local buttons = {
			[1] = gologin,
			[2] = turnreg,
			[3] = goregister,
			[4] = turnlog
		}
		for _, v in pairs(buttons) do dgsSetFont(v, font[2]) end
	end
)