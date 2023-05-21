loadstring(exports.DxLib:dgsImportFunction())()

local sx, sy = guiGetScreenSize()
local resX, resY = 1920, 1080
local x, y = (sx/resX), (sy/resY)

---[Ventanas]---
local bank_getCard_panel = dgsCreateWindow(x*750, y*450, x*390, y*148, "Conseguir tarjeta", false, _, _, _, _, _, _, _, true)
dgsWindowSetMovable(bank_getCard_panel, false)
dgsWindowSetSizable(bank_getCard_panel, false)
dgsSetVisible(bank_getCard_panel, false)

local bank_confirmCard_panel = dgsCreateWindow(x*785, y*450, x*341, y*138, "Confirmar tarjeta", false, _, _, _, _, _, _, _, true)
dgsWindowSetMovable(bank_confirmCard_panel, false)
dgsWindowSetSizable(bank_confirmCard_panel, false)
dgsSetVisible(bank_confirmCard_panel, false)

local bank_main_panel = dgsCreateWindow(x*720, y*450, x*418, y*164, "[ZSBank] - by Seyer", false, _, _, _, _, _, _, _, true)
dgsWindowSetMovable(bank_main_panel, false)
dgsWindowSetSizable(bank_main_panel, false)
dgsSetVisible(bank_main_panel, false)

local bank_ext_panel = dgsCreateWindow(x*1138, y*450, x*284, y*289, "Extracción", false, _, _, _, _, _, _, _, true)
dgsWindowSetMovable(bank_ext_panel, false)
dgsWindowSetSizable(bank_ext_panel, false)
dgsSetVisible(bank_ext_panel, false)

local bank_dep_panel = dgsCreateWindow(x*436, y*450, x*284, y*289, "Depósito", false, _, _, _, _, _, _, _, true)
dgsWindowSetMovable(bank_dep_panel, false)
dgsWindowSetSizable(bank_dep_panel, false)
dgsSetVisible(bank_dep_panel, false)

---[Tab]---
local bank_getCard_tab = dgsCreateTabPanel(x*0, y*(-22), x*390, y*148.5, false, bank_getCard_panel)-- x*20 => x*0 
local bank_confirmCard_tab = dgsCreateTabPanel(x*0, y*(-22), x*341, y*137.5, false, bank_confirmCard_panel)-- x*20 => x*0 
local bank_main_tab = dgsCreateTabPanel(x*0, y*(-22), x*418, y*162.5, false, bank_main_panel)-- x*20 => x*0 
local bank_ext_tab = dgsCreateTabPanel(x*0, y*(-22), x*284, y*288.5, false, bank_ext_panel)-- x*20 => x*0 
local bank_dep_tab = dgsCreateTabPanel(x*0, y*(-22), x*284, y*288.5, false, bank_dep_panel)-- x*20 => x*0 

---[Botones]---
local bank_getCard_yes = dgsCreateButton(x*14, y*80, x*140, y*62, "Sí", false, bank_getCard_tab, _, _, _, _, _, _, tocolor(53, 198, 39, 150), tocolor(53, 198, 39, 150), tocolor(53, 198, 39, 150))
local bank_getCard_no = dgsCreateButton(x*235, y*80, x*140, y*62, "No", false, bank_getCard_tab, _, _, _, _, _, _, tocolor(53, 198, 39, 150), tocolor(53, 198, 39, 150), tocolor(53, 198, 39, 150))
local bank_confirmCard_yes = dgsCreateButton(x*8, y*70, x*140, y*62, "Confirmar", false, bank_confirmCard_tab, _, _, _, _, _, _, tocolor(53, 198, 39, 150), tocolor(53, 198, 39, 150), tocolor(53, 198, 39, 150))
local bank_confirmCard_no = dgsCreateButton(x*192, y*70, x*140, y*62, "Cancelar", false, bank_confirmCard_tab, _, _, _, _, _, _, tocolor(53, 198, 39, 150), tocolor(53, 198, 39, 150), tocolor(53, 198, 39, 150))
local bank_ext = dgsCreateButton(x*230, y*85, x*177, y*68, "Extraer", false, bank_main_tab, _, _, _, _, _, _, tocolor(53, 198, 39, 150), tocolor(53, 198, 39, 150), tocolor(53, 198, 39, 150))
local bank_dep = dgsCreateButton(x*10, y*85, x*177, y*68, "Depositar", false, bank_main_tab, _, _, _, _, _, _, tocolor(53, 198, 39, 150), tocolor(53, 198, 39, 150), tocolor(53, 198, 39, 150))
local bank_goext = dgsCreateButton(x*13, y*230, x*258, y*46, "Extraer", false, bank_ext_tab, _, _, _, _, _, _, tocolor(53, 198, 39, 150), tocolor(53, 198, 39, 150), tocolor(53, 198, 39, 150))
local bank_godep = dgsCreateButton(x*13, y*230, x*258, y*46, "Depositar", false, bank_dep_tab, _, _, _, _, _, _, tocolor(53, 198, 39, 150), tocolor(53, 198, 39, 150), tocolor(53, 198, 39, 150))

---[Labels]---
local actuallyText = dgsCreateLabel(x*14, y*30, x*370, y*30, "Actualmente no tenes tarjeta por lo que no podrás usar el banco, \n                                        ¿querés conseguirla?", false, bank_getCard_tab)
local priceText = dgsCreateLabel(x*14, y*30, x*272, y*15, "                           ¿Estas seguro? Sale $50.000", false, bank_confirmCard_tab)
local welcomeText = dgsCreateLabel(x*30, y*35, x*582, y*31, "                  El banco Credicoop te da la bienvenida, "..getPlayerName(localPlayer)..".\n                          Acá podrás extraer y depositar dinero.", false, bank_main_tab)
local amountTextExt = dgsCreateLabel(x*10, y*30, x*261, y*22, "Dinero depositado: $0", false, bank_ext_tab)
local extText = dgsCreateLabel(x*74, y*65, x*143, y*17, "¿Cuánto querés extraer?", false, bank_ext_tab)
local amountTextDep = dgsCreateLabel(x*10, y*30, x*261, y*22, "Dinero depositado: $0", false, bank_dep_tab)
local depText = dgsCreateLabel(x*72, y*65, x*143, y*17, "¿Cuánto querés depositar?", false, bank_dep_tab)
local closeMain = dgsCreateLabel(x*400, y*30, x*145, y*19, "X", false, bank_main_tab), dgsCreateLabel(x*-17, y*30, x*145, y*19, " ", false, bank_ext_tab), dgsCreateLabel(x*685, y*30, x*145, y*19, " ", false, bank_dep_tab)
local closeExt = dgsCreateLabel(x*270, y*30, x*143, y*17, "X", false, bank_ext_tab)
local closeDep = dgsCreateLabel(x*270, y*30, x*143, y*17, "X", false, bank_dep_tab)

---[Radios]---
local ext5k = dgsCreateRadioButton(x*12, y*105, x*60, y*15, " 5.000", false, bank_ext_tab, tocolor(53, 198, 39, 150), _, _, _, _)
local ext10k = dgsCreateRadioButton(x*113, y*105, x*60, y*15, " 10.000", false, bank_ext_tab, tocolor(53, 198, 39, 150), _, _, _, _)
local ext25k = dgsCreateRadioButton(x*207, y*105, x*60, y*15, " 25.000", false, bank_ext_tab, tocolor(53, 198, 39, 150), _, _, _, _)
local ext50k = dgsCreateRadioButton(x*12, y*135, x*60, y*15, " 50.000", false, bank_ext_tab, tocolor(53, 198, 39, 150), _, _, _, _)
local ext100k = dgsCreateRadioButton(x*113, y*135, x*65, y*15, " 100.000", false, bank_ext_tab, tocolor(53, 198, 39, 150), _, _, _, _)
local ext250k = dgsCreateRadioButton(x*207, y*135, x*64, y*15, " 250.000", false, bank_ext_tab, tocolor(53, 198, 39, 150), _, _, _, _)
local ext = dgsCreateRadioButton(x*92, y*165, x*99, y*17, " Personalizado", false, bank_ext_tab, tocolor(53, 198, 39, 150), _, _, _, _)
local dep5k = dgsCreateRadioButton(x*12, y*105, x*60, y*15, " 5.000", false, bank_dep_tab, tocolor(53, 198, 39, 150), _, _, _, _)
local dep10k = dgsCreateRadioButton(x*113, y*105, x*60, y*15, " 10.000", false, bank_dep_tab, tocolor(53, 198, 39, 150), _, _, _, _)
local dep25k = dgsCreateRadioButton(x*207, y*105, x*60, y*15, " 25.000", false, bank_dep_tab, tocolor(53, 198, 39, 150), _, _, _, _)
local dep50k = dgsCreateRadioButton(x*12, y*135, x*60, y*15, " 50.000", false, bank_dep_tab, tocolor(53, 198, 39, 150), _, _, _, _)
local dep100k = dgsCreateRadioButton(x*113, y*135, x*65, y*15, " 100.000", false, bank_dep_tab, tocolor(53, 198, 39, 150), _, _, _, _)
local dep250k = dgsCreateRadioButton(x*207, y*135, x*64, y*15, " 250.000", false, bank_dep_tab, tocolor(53, 198, 39, 150), _, _, _, _)
local dep = dgsCreateRadioButton(x*92, y*165, x*99, y*17, " Personalizado", false, bank_dep_tab, tocolor(53, 198, 39, 150), _, _, _, _)

---[Edits]---
local extAmount = dgsCreateEdit(x*13, y*190, x*258, y*30, "", false, bank_ext_tab)
local depAmount = dgsCreateEdit(x*13, y*190, x*258, y*30, "", false, bank_dep_tab)

--Main events
addEventHandler("onDgsMouseClick", dgsRoot,
	function(_, state)
		if state == "down" then
			cursor(source)
			windows(source)
			go(source)
		end
	end
)

addEvent("[SZBank]:open", true)
addEventHandler("[SZBank]:open", getLocalPlayer(),
	function(whatDo)
		showCursor(true)
		if whatDo == "openMainBankPanel" then dgsSetVisible(bank_main_panel, true)
		elseif whatDo == "openGetCardPanel" then dgsSetVisible(bank_getCard_panel, true)
		end
	end
)


addEvent("[SZBank]:refreshDep", true)
addEventHandler("[SZBank]:refreshDep", getLocalPlayer(),
	function(dep)
		dgsSetText(amountTextExt, "Dinero depositado: $"..dep)
		dgsSetText(amountTextDep, "Dinero depositado: $"..dep)
	end
)

--Main functions
function cursor(source)
	if (source == bank_getCard_no) or (source == bank_confirmCard_yes) or (source == bank_confirmCard_no) or (source == closeMain) then showCursor(false) end
end

function windows(source)
	if (source == bank_getCard_yes) then dgsSetVisible(bank_confirmCard_panel, true)
	elseif (source == bank_ext) then 
		if not dgsGetVisible(bank_ext_panel) then dgsSetVisible(bank_ext_panel, true) reset("dep") 
		else dgsSetVisible(bank_ext_panel, false) 
		end
	elseif (source == bank_dep) then 
		if not dgsGetVisible(bank_dep_panel) then dgsSetVisible(bank_dep_panel, true) reset("ext") 
		else dgsSetVisible(bank_dep_panel, false) 
		end
	end
	
	if (source == bank_getCard_yes) or (source == bank_getCard_no) then dgsSetVisible(bank_getCard_panel, false)
	elseif (source == bank_confirmCard_no) or (source == bank_confirmCard_yes) then dgsSetVisible(bank_confirmCard_panel, false)
	elseif (source == closeMain) then 
		dgsSetVisible(bank_main_panel, false)
		dgsSetVisible(bank_ext_panel, false)
		dgsSetVisible(bank_dep_panel, false)
	elseif (source == closeExt) then dgsSetVisible(bank_ext_panel, false) 
	elseif (source == closeDep) then dgsSetVisible(bank_dep_panel, false)
	end
end

function go(source)
	local amount
	if (source == bank_confirmCard_yes) then triggerServerEvent("[SZBank]:confirm", getLocalPlayer(), getLocalPlayer()) end

	if (source == bank_godep) or (source == bank_goext) then
		if (source == bank_goext) then reset("dep") else reset("ext") end
		if dgsRadioButtonGetSelected(dep5k) or dgsRadioButtonGetSelected(ext5k) then amount = 5000
		elseif dgsRadioButtonGetSelected(dep10k) or dgsRadioButtonGetSelected(ext10k) then amount = 10000
		elseif dgsRadioButtonGetSelected(dep25k) or dgsRadioButtonGetSelected(ext25k) then amount = 25000
		elseif dgsRadioButtonGetSelected(dep50k) or dgsRadioButtonGetSelected(ext50k) then amount = 50000
		elseif dgsRadioButtonGetSelected(dep100k) or dgsRadioButtonGetSelected(ext100k) then amount = 100000
		elseif dgsRadioButtonGetSelected(dep250k) or dgsRadioButtonGetSelected(ext250k) then amount = 250000
		elseif dgsRadioButtonGetSelected(dep) and dgsGetText(depAmount) ~= "" then amount = tonumber(dgsGetText(depAmount))
		elseif dgsRadioButtonGetSelected(ext) and dgsGetText(extAmount) ~= "" then amount = tonumber(dgsGetText(extAmount))
		end

		if 	dgsRadioButtonGetSelected(ext5k) or dgsRadioButtonGetSelected(ext10k) or dgsRadioButtonGetSelected(ext25k) or
			dgsRadioButtonGetSelected(ext50k) or dgsRadioButtonGetSelected(ext100k) or dgsRadioButtonGetSelected(ext250k) or
			dgsRadioButtonGetSelected(ext) then
			triggerServerEvent("[SZBank]:depext", getLocalPlayer(), getLocalPlayer(), amount, "bankExtraction")
		else triggerServerEvent("[SZBank]:depext", getLocalPlayer(), getLocalPlayer(), amount, "bankDeposite")
		end
	end
end

function reset(modo)
	if modo == "ext" then
		dgsRadioButtonSetSelected(ext5k, false)
		dgsRadioButtonSetSelected(ext10k, false)
		dgsRadioButtonSetSelected(ext25k, false)
		dgsRadioButtonSetSelected(ext50k, false)
		dgsRadioButtonSetSelected(ext100k, false)
		dgsRadioButtonSetSelected(ext250k, false)
		dgsRadioButtonSetSelected(ext, false)
		dgsSetText(extAmount, "")
	else
		dgsRadioButtonSetSelected(dep5k, false)
		dgsRadioButtonSetSelected(dep10k, false)
		dgsRadioButtonSetSelected(dep25k, false)
		dgsRadioButtonSetSelected(dep50k, false)
		dgsRadioButtonSetSelected(dep100k, false)
		dgsRadioButtonSetSelected(dep250k, false)
		dgsRadioButtonSetSelected(dep, false)
		dgsSetText(depAmount, "")
	end
end

--Misc
addEventHandler("onClientResourceStart", getRootElement(), 
	function ()
		local font = {
			[1] = dxCreateFont("font/medium.ttf", 10),
			[2] = dxCreateFont("font/medium.ttf", 14)
		}

		local elements = {
			[1] = bank_getCard_panel,
			[2] = bank_confirmCard_panel,
			[3] = bank_main_panel,
			[4] = bank_ext_panel,
			[5] = bank_dep_panel,
			[6] = ext5k,
			[7] = ext10k,
			[8] = ext25k,
			[9] = ext50k,
			[10] = ext100k,
			[11] = ext250k,
			[12] = ext,
			[13] = dep5k,
			[14] = dep10k,
			[15] = dep25k,
			[16] = dep50k,
			[17] = dep100k,
			[18] = dep250k,
			[19] = dep,
			[20] = extAmount,
			[21] = depAmount,
			[22] = bank_goext,
			[23] = bank_godep
		}
		for _, v in pairs(elements) do dgsSetFont(v, font[1]) end

		local biggerElements = {
			bank_getCard_yes,
			bank_getCard_no,
			bank_confirmCard_yes,
			bank_confirmCard_no,
			bank_ext,
			bank_dep
		}
		for _, v in pairs(biggerElements) do dgsSetFont(v, font[2]) end

		local specialElements = {
			[1] = actuallyText,
			[2] = priceText,
			[3] = welcomeText,
			[4] = amountTextExt,
			[5] = extText,
			[6] = amountTextDep,
			[7] = depText,
			[8] = closeMain,
			[9] = closeExt,
			[10] = closeDep
		}
		for _, v in pairs(specialElements) do 
			dgsSetFont(v, font[1])
			dgsLabelSetColor(v, 53, 198, 39, 150)
		end
	end
)