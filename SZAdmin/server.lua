addEvent("[SZAdmin]:checkStaff", true)
addEventHandler("[SZAdmin]:checkStaff", getRootElement(), 
	function(thePlayer)
		if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(thePlayer)), aclGetGroup("Console")) then
			triggerClientEvent(thePlayer, "[SZAdmin]:abrir", thePlayer)
		end
	end
)

addEvent("[SZAdmin]:getInfo", true)
addEventHandler("[SZAdmin]:getInfo", getRootElement(),
	function(target)
		local user, nick, ip, serial, hp, armor, money, skin, team, int, dim, vehOwner, vehName, vehHp, vehModel, checkBank, cardDep, cardNum, cardLvl, log = exports.SZMisc:_get("admin", "load", target)
		if armor == 0 then armor = "No" end if int == 0 then int = "Normal" end if dim == 0 then dim = "Normal" end
		if int == 10 and dim == 1 then int = "Banco LV" dim = "Banco LV" end
		triggerClientEvent(source, "[SZAdmin]:showInfo", source, user, nick, ip, serial, hp, armor, money, skin, team, int, dim, vehOwner, vehName, vehHp, vehModel, checkBank, cardDep, cardNum, cardLvl, log) 
	end
)

addEvent("[SZAdmin]:adminReconnect", true)
addEventHandler("[SZAdmin]:adminReconnect", getRootElement(), function(target) redirectPlayer(target, "192.168.0.16", 0, "ksa") end)

addEvent("[SZAdmin]:bankAdmin", true)
addEventHandler("[SZAdmin]:bankAdmin", getRootElement(), 
	function(data, staffName, amount, whatDo, lvl)
		local target, targetName, targetIP, targetSerial = exports.SZMisc:_get("user", "getSomePlayerInfo", data)
		local staff, staffName, staffIP, staffSerial = exports.SZMisc:_get("user", "getSomePlayerInfo", source)
		local deposited, _, actualLvl = exports.SZMisc:_get("bank", "admin", data)
		local date = exports.SZMisc:_fecha()
		local reason

		if whatDo == "refreshLvl" then triggerClientEvent(source, "[SZAdmin]:refreshLvl", source, actualLvl) end

		if whatDo == "seeLog" then
			local log = exports.SZMisc:_get("bank", "targetLog", data)
			triggerClientEvent(source, "[SZAdmin]:refreshLog", source, log)
		end

		if whatDo == "dep" or whatDo == "ext" then reason = bankDepExt(data, staffName, amount, whatDo, target, deposited)
		elseif whatDo == "givedel" then reason = bankGiveDel(data, staffName, staff, target, targetIP, targetSerial, date)
		elseif whatDo == "changelvl" then reason = bankChangeLvl(data, staffName, target, lvl)
		end
		
		if reason == "[NewExt]" or reason == "[NewDep]" then
			if reason == "[NewExt]" then amount = "-"..amount end
			exports.SZSQL:_Exec("INSERT INTO staffbanklog(Staff, TargetAcc, TargetName, LastDeposited, Amount, NewDeposited, Reason, Date, IP, Serial) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",  staffName.." ("..staff..")", target, targetName, deposited, amount, amount+deposited, reason, date, staffIP, staffSerial)
		elseif reason == "[ChangeLvl]" then exports.SZSQL:_Exec("INSERT INTO staffbanklog(Staff, TargetAcc, TargetName, OldLvl, NewLvl, Reason, Date, IP, Serial) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?)",  staffName.." ("..staff..")", target, targetName, actualLvl, lvl, reason, date, staffIP, staffSerial)
		elseif reason == "[DelCard]" or reason == "[GiveCard]" then exports.SZSQL:_Exec("INSERT INTO staffbanklog(Staff, TargetAcc, TargetName, Reason, Date, IP, Serial) VALUES(?, ?, ?, ?, ?, ?, ?)",  staffName.." ("..staff..")", target, targetName, reason, date, staffIP, staffSerial)
		end
	end
)

--Main functions
function bankDepExt(data, staffName, amount, whatDo, target, deposited)	
	local newDep, reason
	if whatDo == "dep" then
		if deposited + amount < 2147483278 then 
			newDep = deposited + amount 
			reason = "[NewDep]" 
		end
	elseif whatDo == "ext" then
		if deposited - amount > 0 then 
			newDep = deposited - amount 
			reason = "[NewExt]" 
		end
	end

	if newDep then
		if whatDo == "dep" then exports.SZMisc:_msgsvstaff("bankdep", staffName, amount, data)
		else exports.SZMisc:_msgsvstaff("bankext", staffName, amount, _, data)
		end
		exports.SZSQL:_Exec("UPDATE bank SET Deposited = ? WHERE User = ?", newDep, target)
		triggerClientEvent(source, "[SZAdmin]:refreshDep", source, "$"..newDep)
	else exports.SZMisc:_msgsv("admin", "err", "bankmin", source)
	end
	
	return reason
end

function bankGiveDel(data, staffName, staffacc, target, ip, serial, date)
	local reason
	local check = exports.SZMisc:_get("bank", "getPlayerCard", data)
	if check then
		exports.SZSQL:_Exec("DELETE FROM bank WHERE User = ?", target)
		triggerClientEvent(source, "[SZAdmin]:AdmininstrateCard", source, "No")
		triggerClientEvent(source, "[SZAdmin]:refreshTar", source, "No", "N/A", "N/A", "N/A")
		exports.SZMisc:_msgsvstaff("bankdelCard", staffName, _, _, data)
		reason = "[DelCard]"
	else
		local cardNum = math.random(1000, 9999).."."..math.random(1000, 9999).."."..math.random(1000, 9999).."."..math.random(1000, 9999)
		local checkN = exports.SZSQL:_QuerySingle("SELECT * FROM bank WHERE CardNumber = ?", cardNum)
		if not checkN then
			exports.SZSQL:_Exec("INSERT INTO bank(User, CardNumber, GotOn, GiftedBy, IP, Serial) VALUES(?, ?, ?, ?, ?, ?)", target, cardNum, date, staffName.." ("..staffacc..")", ip, serial)
			triggerClientEvent(source, "[SZAdmin]:AdmininstrateCard", source, "Yes")
			triggerClientEvent(source, "[SZAdmin]:refreshTar", source, "Sí", "$0", 'Normal', cardNum)
			exports.SZMisc:_msgsvstaff("bankgiveCard", staffName, _, _, data)
			reason = "[GiveCard]"
		else
			bankGiveDel(data, staffName, target, ip, serial, date)
		end
	end

	return reason
end

function bankChangeLvl(data, staffName, target, lvl)
	exports.SZSQL:_Exec("UPDATE bank SET Lvl=? WHERE User = ?", lvl, target)
	exports.SZMisc:_msgsvstaff("bankchglvl", staffName, _, lvl, data)
	triggerClientEvent(source, "[SZAdmin]:refreshLvl", source, lvl)

	return "[ChangeLvl]"
end