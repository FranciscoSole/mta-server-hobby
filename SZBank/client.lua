loadstring(exports.DxLib:dgsImportFunction())()

local sx, sy = guiGetScreenSize()
local resX, resY = 1920, 1080
local x, y = (sx/resX), (sy/resY)

---[Windows]---
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

local bank_withdraw_panel = dgsCreateWindow(x*1138, y*450, x*284, y*289, "Extracción", false, _, _, _, _, _, _, _, true)
dgsWindowSetMovable(bank_withdraw_panel, false)
dgsWindowSetSizable(bank_withdraw_panel, false)
dgsSetVisible(bank_withdraw_panel, false)

local bank_deposit_button = dgsCreateWindow(x*436, y*450, x*284, y*289, "Depósito", false, _, _, _, _, _, _, _, true)
dgsWindowSetMovable(bank_deposit_button, false)
dgsWindowSetSizable(bank_deposit_button, false)
dgsSetVisible(bank_deposit_button, false)

---[Tabs]---
local bank_getCard_tab = dgsCreateTabPanel(x*0, y*(-22), x*390, y*148.5, false, bank_getCard_panel)
local bank_confirmCard_tab = dgsCreateTabPanel(x*0, y*(-22), x*341, y*137.5, false, bank_confirmCard_panel)
local bank_main_tab = dgsCreateTabPanel(x*0, y*(-22), x*418, y*162.5, false, bank_main_panel) 
local bank_withdraw_tab = dgsCreateTabPanel(x*0, y*(-22), x*284, y*288.5, false, bank_withdraw_panel)
local bank_deposit_tab = dgsCreateTabPanel(x*0, y*(-22), x*284, y*288.5, false, bank_deposit_button)

---[Buttons]---
local color = tocolor(53, 198, 39, 150) -- It's not a button. It's just a color variable to not repeat this function.
local bank_getCard_yes_button = dgsCreateButton(x*14, y*80, x*140, y*62, "Sí", false, bank_getCard_tab, _, _, _, _, _, _, color, color, color)
local bank_getCard_no_button = dgsCreateButton(x*235, y*80, x*140, y*62, "No", false, bank_getCard_tab, _, _, _, _, _, _, color, color, color)
local bank_confirmCard_yes_button = dgsCreateButton(x*8, y*70, x*140, y*62, "Confirmar", false, bank_confirmCard_tab, _, _, _, _, _, _, color, color, color)
local bank_confirmCard_no_button = dgsCreateButton(x*192, y*70, x*140, y*62, "Cancelar", false, bank_confirmCard_tab, _, _, _, _, _, _, color, color, color)
local bank_openWithdraw_button = dgsCreateButton(x*230, y*85, x*177, y*68, "Extraer", false, bank_main_tab, _, _, _, _, _, _, color, color, color)
local bank_openDeposit_button = dgsCreateButton(x*10, y*85, x*177, y*68, "Depositar", false, bank_main_tab, _, _, _, _, _, _, color, color, color)
local bank_goWithdraw_button = dgsCreateButton(x*13, y*230, x*258, y*46, "Extraer", false, bank_withdraw_tab, _, _, _, _, _, _, color, color, color)
local bank_goDeposit_button = dgsCreateButton(x*13, y*230, x*258, y*46, "Depositar", false, bank_deposit_tab, _, _, _, _, _, _, color, color, color)

---[Labels]---
local bank_actuallyNoCard_label = dgsCreateLabel(x*14, y*30, x*370, y*30, "Actualmente no tenes tarjeta por lo que no podrás usar el banco, \n                                        ¿querés conseguirla?", false, bank_getCard_tab)
local bank_cardPrice_label = dgsCreateLabel(x*14, y*30, x*272, y*15, "                           ¿Estas seguro? Sale $50.000", false, bank_confirmCard_tab)
local bank_welcomeText_label = dgsCreateLabel(x*30, y*35, x*582, y*31, "                  El banco SZ te da la bienvenida, "..getPlayerName(localPlayer)..".\n                          Acá podrás extraer y depositar dinero.", false, bank_main_tab)
local bank_balanceOnWithdrawTab_label = dgsCreateLabel(x*10, y*30, x*261, y*22, "Dinero depositado: $0", false, bank_withdraw_tab)
local bank_howMuchWithdraw_label = dgsCreateLabel(x*74, y*65, x*143, y*17, "¿Cuánto querés extraer?", false, bank_withdraw_tab)
local bank_balanceOnDepositTab_label = dgsCreateLabel(x*10, y*30, x*261, y*22, "Dinero depositado: $0", false, bank_deposit_tab)
local bank_howMuchDeposit_label = dgsCreateLabel(x*72, y*65, x*143, y*17, "¿Cuánto querés depositar?", false, bank_deposit_tab)
local bank_closeMain_label = dgsCreateLabel(x*400, y*30, x*145, y*19, "X", false, bank_main_tab), dgsCreateLabel(x*-17, y*30, x*145, y*19, " ", false, bank_withdraw_tab), dgsCreateLabel(x*685, y*30, x*145, y*19, " ", false, bank_deposit_tab)
local bank_closeWithdraw_label = dgsCreateLabel(x*270, y*30, x*143, y*17, "X", false, bank_withdraw_tab)
local bank_closeDeposit_label = dgsCreateLabel(x*270, y*30, x*143, y*17, "X", false, bank_deposit_tab)

---[Radios]---
local bank_withdraw_5k_radio = dgsCreateRadioButton(x*12, y*105, x*60, y*15, " 5.000", false, bank_withdraw_tab, color, color, color, _, _, _, _)
local bank_withdraw_10k_radio = dgsCreateRadioButton(x*113, y*105, x*60, y*15, " 10.000", false, bank_withdraw_tab, color, color, color, _, _, _, _)
local bank_withdraw_25k_radio = dgsCreateRadioButton(x*207, y*105, x*60, y*15, " 25.000", false, bank_withdraw_tab, color, color, color, _, _, _, _)
local bank_withdraw_50k_radio = dgsCreateRadioButton(x*12, y*135, x*60, y*15, " 50.000", false, bank_withdraw_tab, color, color, color, _, _, _, _)
local bank_withdraw_100k_radio = dgsCreateRadioButton(x*113, y*135, x*65, y*15, " 100.000", false, bank_withdraw_tab, color, color, color, _, _, _, _)
local bank_withdraw_250k_radio = dgsCreateRadioButton(x*207, y*135, x*64, y*15, " 250.000", false, bank_withdraw_tab, color, color, color, _, _, _, _)
local bank_withdraw_custom_radio = dgsCreateRadioButton(x*92, y*165, x*99, y*17, " Personalizado", false, bank_withdraw_tab, color, color, color, _, _, _, _)
local bank_deposit_5k_radio = dgsCreateRadioButton(x*12, y*105, x*60, y*15, " 5.000", false, bank_deposit_tab, color, color, color, _, _, _, _)
local bank_deposit_10k_radio = dgsCreateRadioButton(x*113, y*105, x*60, y*15, " 10.000", false, bank_deposit_tab, color, color, color, _, _, _, _)
local bank_deposit_25k_radio = dgsCreateRadioButton(x*207, y*105, x*60, y*15, " 25.000", false, bank_deposit_tab, color, color, color, _, _, _, _)
local bank_deposit_50k_radio = dgsCreateRadioButton(x*12, y*135, x*60, y*15, " 50.000", false, bank_deposit_tab, color, color, color, _, _, _, _)
local bank_deposit_100k_radio = dgsCreateRadioButton(x*113, y*135, x*65, y*15, " 100.000", false, bank_deposit_tab, color, color, color, _, _, _, _)
local bank_deposit_250k_radio = dgsCreateRadioButton(x*207, y*135, x*64, y*15, " 250.000", false, bank_deposit_tab, color, color, color, _, _, _, _)
local bank_deposit_custom_radio = dgsCreateRadioButton(x*92, y*165, x*99, y*17, " Personalizado", false, bank_deposit_tab, color, color, color, _, _, _, _)

---[Edits]---
local bank_withdraw_custom_edit = dgsCreateEdit(x*13, y*190, x*258, y*30, "", false, bank_withdraw_tab)
local bank_deposit_custom_edit = dgsCreateEdit(x*13, y*190, x*258, y*30, "", false, bank_deposit_tab)

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
	function(bank_deposit_custom_radio)
		dgsSetText(bank_balanceOnWithdrawTab_label, "Dinero depositado: $"..bank_deposit_custom_radio)
		dgsSetText(bank_balanceOnDepositTab_label, "Dinero depositado: $"..bank_deposit_custom_radio)
	end
)

--Main functions
function cursor(source)
	if (source == bank_getCard_no_button) or (source == bank_confirmCard_yes_button) or (source == bank_confirmCard_no_button) or (source == bank_closeMain_label) then showCursor(false) end
end

function windows(source)
	if (source == bank_getCard_yes_button) then 
		dgsSetVisible(bank_confirmCard_panel, true)
	elseif (source == bank_openWithdraw_button) then 
		if not dgsGetVisible(bank_withdraw_panel) then 
			dgsSetVisible(bank_withdraw_panel, true) 
			reset("bank_deposit_custom_radio") 
		else 
			dgsSetVisible(bank_withdraw_panel, false) 
		end
	elseif (source == bank_openDeposit_button) then 
		if not dgsGetVisible(bank_deposit_button) then 
			dgsSetVisible(bank_deposit_button, true) 
			reset("bank_withdraw_custom_radio") 
		else 
			dgsSetVisible(bank_deposit_button, false) 
		end
	end
	
	if (source == bank_getCard_yes_button) or (source == bank_getCard_no_button) then dgsSetVisible(bank_getCard_panel, false)
	elseif (source == bank_confirmCard_no_button) or (source == bank_confirmCard_yes_button) then dgsSetVisible(bank_confirmCard_panel, false)
	elseif (source == bank_closeMain_label) then 
		dgsSetVisible(bank_main_panel, false)
		dgsSetVisible(bank_withdraw_panel, false)
		dgsSetVisible(bank_deposit_button, false)
	elseif (source == bank_closeWithdraw_label) then dgsSetVisible(bank_withdraw_panel, false) 
	elseif (source == bank_closeDeposit_label) then dgsSetVisible(bank_deposit_button, false)
	end
end

function go(source)
	local amount
	if (source == bank_confirmCard_yes_button) then 
		triggerServerEvent("[SZBank]:createCreditCard", getLocalPlayer(), getLocalPlayer()) 
	end

	if (source == bank_goDeposit_button) or (source == bank_goWithdraw_button) then
		if (source == bank_goWithdraw_button) then reset("bank_deposit_custom_radio") else reset("bank_withdraw_custom_radio") end
		if dgsRadioButtonGetSelected(bank_deposit_5k_radio) or dgsRadioButtonGetSelected(bank_withdraw_5k_radio) then amount = 5000
		elseif dgsRadioButtonGetSelected(bank_deposit_10k_radio) or dgsRadioButtonGetSelected(bank_withdraw_10k_radio) then amount = 10000
		elseif dgsRadioButtonGetSelected(bank_deposit_25k_radio) or dgsRadioButtonGetSelected(bank_withdraw_25k_radio) then amount = 25000
		elseif dgsRadioButtonGetSelected(bank_deposit_50k_radio) or dgsRadioButtonGetSelected(bank_withdraw_50k_radio) then amount = 50000
		elseif dgsRadioButtonGetSelected(bank_deposit_100k_radio) or dgsRadioButtonGetSelected(bank_withdraw_100k_radio) then amount = 100000
		elseif dgsRadioButtonGetSelected(bank_deposit_250k_radio) or dgsRadioButtonGetSelected(bank_withdraw_250k_radio) then amount = 250000
		elseif dgsRadioButtonGetSelected(bank_deposit_custom_radio) and dgsGetText(bank_deposit_custom_edit) ~= "" then amount = tonumber(dgsGetText(bank_deposit_custom_edit))
		elseif dgsRadioButtonGetSelected(bank_withdraw_custom_radio) and dgsGetText(bank_withdraw_custom_edit) ~= "" then amount = tonumber(dgsGetText(bank_withdraw_custom_edit))
		end

		if 	dgsRadioButtonGetSelected(bank_withdraw_5k_radio) or dgsRadioButtonGetSelected(bank_withdraw_10k_radio) or dgsRadioButtonGetSelected(bank_withdraw_25k_radio) or
			dgsRadioButtonGetSelected(bank_withdraw_50k_radio) or dgsRadioButtonGetSelected(bank_withdraw_100k_radio) or dgsRadioButtonGetSelected(bank_withdraw_250k_radio) or
			dgsRadioButtonGetSelected(bank_withdraw_custom_radio) then
			triggerServerEvent("[SZBank]:depext", getLocalPlayer(), getLocalPlayer(), amount, "bankExtraction")
		else triggerServerEvent("[SZBank]:depext", getLocalPlayer(), getLocalPlayer(), amount, "bankDeposite")
		end
	end
end

function reset(modo)
	if modo == "bank_withdraw_custom_radio" then
		dgsRadioButtonSetSelected(bank_withdraw_5k_radio, false)
		dgsRadioButtonSetSelected(bank_withdraw_10k_radio, false)
		dgsRadioButtonSetSelected(bank_withdraw_25k_radio, false)
		dgsRadioButtonSetSelected(bank_withdraw_50k_radio, false)
		dgsRadioButtonSetSelected(bank_withdraw_100k_radio, false)
		dgsRadioButtonSetSelected(bank_withdraw_250k_radio, false)
		dgsRadioButtonSetSelected(bank_withdraw_custom_radio, false)
		dgsSetText(bank_withdraw_custom_edit, "")
	else
		dgsRadioButtonSetSelected(bank_deposit_5k_radio, false)
		dgsRadioButtonSetSelected(bank_deposit_10k_radio, false)
		dgsRadioButtonSetSelected(bank_deposit_25k_radio, false)
		dgsRadioButtonSetSelected(bank_deposit_50k_radio, false)
		dgsRadioButtonSetSelected(bank_deposit_100k_radio, false)
		dgsRadioButtonSetSelected(bank_deposit_250k_radio, false)
		dgsRadioButtonSetSelected(bank_deposit_custom_radio, false)
		dgsSetText(bank_deposit_custom_edit, "")
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
			bank_getCard_panel, bank_confirmCard_panel,
			bank_main_panel,
			bank_withdraw_panel,
			bank_deposit_button,
			bank_withdraw_5k_radio,
			bank_withdraw_10k_radio,
			bank_withdraw_25k_radio,
			bank_withdraw_50k_radio,
			bank_withdraw_100k_radio,
			bank_withdraw_250k_radio,
			bank_withdraw_custom_radio,
			bank_deposit_5k_radio,
			bank_deposit_10k_radio,
			bank_deposit_250k_radio,
			bank_deposit_50k_radio,
			bank_deposit_100k_radio,
			bank_deposit_250k_radio,
			bank_deposit_custom_radio,
			bank_withdraw_custom_edit,
			bank_deposit_custom_edit,
			bank_goWithdraw_button,
			bank_goDeposit_button
		}
		for _, v in pairs(elements) do dgsSetFont(v, font[1]) end

		local biggerElements = {
			bank_getCard_yes_button,
			bank_getCard_no_button,
			bank_confirmCard_yes_button,
			bank_confirmCard_no_button,
			bank_openWithdraw_button,
			bank_openDeposit_button
		}
		for _, v in pairs(biggerElements) do dgsSetFont(v, font[2]) end

		local specialElements = {
			[1] = bank_actuallyNoCard_label,
			[2] = bank_cardPrice_label,
			[3] = bank_welcomeText_label,
			[4] = bank_balanceOnWithdrawTab_label,
			[5] = bank_howMuchWithdraw_label,
			[6] = bank_balanceOnDepositTab_label,
			[7] = bank_howMuchDeposit_label,
			[8] = bank_closeMain_label,
			[9] = bank_closeWithdraw_label,
			[10] = bank_closeDeposit_label
		}
		for _, v in pairs(specialElements) do 
			dgsSetFont(v, font[1])
			dgsLabelSetColor(v, 53, 198, 39, 150)
		end
	end
)