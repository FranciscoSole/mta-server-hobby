local bankDepExt = createMarker (246.43359375, 118.5908203125, 1002.21875, "cylinder", 1.2, 250, 250, 7, 120, getRootElement())
setElementDimension(bankDepExt, 1)  
setElementInterior(bankDepExt, 10)

local getCard = createMarker(251.6865234375, 117.45703125, 1002.21875, "cylinder", 1.2, 250, 250, 7, 120, getRootElement())
setElementDimension(getCard, 1)  
setElementInterior(getCard, 10)

--Main events
addEventHandler("onMarkerHit", root,
	function(thePlayer)
		if getElementType(thePlayer) == "player" and not isPedInVehicle(thePlayer) then
			local check = exports.SZMisc:_get("bank", "getPlayerCard", thePlayer)
			if check then
				if (source == bankDepExt) then
					local dep = exports.SZMisc:_get("bank", "getPlayerBankDep", thePlayer)
					triggerClientEvent(thePlayer, "[SZBank]:refreshDep", thePlayer, dep)
					triggerClientEvent(thePlayer, "[SZBank]:open", thePlayer, "openMainBankPanel")
				elseif (source == getCard) then exports.SZMisc:_msgsv("bank", "err", "already", thePlayer)
				end
			else
				if (source == bankDepExt) then exports.SZMisc:_msgsv("bank", "err", "n/a", thePlayer)
				elseif (source == getCard) then triggerClientEvent(thePlayer, "[SZBank]:open", thePlayer, "openGetCardPanel")
				end
			end
		end
	end
)

function confirmar(thePlayer)
	if getPlayerMoney(thePlayer) >= 50000 then
		local cardNum = math.random(1000, 9999).."."..math.random(1000, 9999).."."..math.random(1000, 9999).."."..math.random(1000, 9999)
		local checkNum = exports.SZSQL:_QuerySingle("SELECT CardNumber FROM bank WHERE CardNumber = ?", cardNum)
		if not checkNum then
			local date = exports.SZMisc:_fecha()
			local user, nick, ip, serial = exports.SZMisc:_get("user", "getSomePlayerInfo", thePlayer)
			exports.SZSQL:_Exec("INSERT INTO bank(Usuario, CardNumber, IP, Serial, GotOn) VALUES(?, ?, ?, ?, ?)", user, cardNum, ip, serial, date)
			exports.SZMisc:_msgsv("bank", "info", "newCard", thePlayer)
			takePlayerMoney(thePlayer, 50000)
		else confirmar(thePlayer)
		end
	else exports.SZMisc:_msgsv("bank", "err", "amount", thePlayer)
	end
end
addEvent("[SZBank]:confirm", true)
addEventHandler("[SZBank]:confirm", getRootElement(), confirmar)

addEvent("[SZBank]:depext", true)
addEventHandler("[SZBank]:depext", getRootElement(),
	function(thePlayer, amount, whatDo)
		local user, ip, serial, actualDep, money = exports.SZMisc:_get("bank", "getSomePlayerBankInfo", thePlayer)
		local date = exports.SZMisc:_fecha()
		local reason
		triggerClientEvent(thePlayer, "[SZBank]:refreshDep", thePlayer, actualDep)

		if validar(amount, thePlayer) then
			local newDep
			if (actualDep + amount <= 2147483278 and whatDo == "bankDeposite" and money >= amount) then
				newDep = actualDep + amount
				takePlayerMoney(thePlayer, amount)
			elseif (amount + money <= 99999999 and whatDo == "bankExtraction" and actualDep >= amount) then
				newDep = actualDep - amount
				givePlayerMoney(thePlayer, amount)
			else 
				if actualDep < amount or money < amount then exports.SZMisc:_msgsv("bank", "err", "amount", thePlayer)
				else exports.SZMisc:_msgsv("bank", "err", "max", thePlayer)
				end
			end
			if newDep then
				exports.SZSQL:_Exec("UPDATE bank SET Deposited = ?, LastMovementOn = ? WHERE User = ?", newDep, date, user)
				triggerClientEvent(thePlayer, "[SZBank]:refreshDep", thePlayer, newDep)
				if whatDo == "bankDeposite" then reason = "[Deposited]" else reason = "[Extraction]" end
				if reason == "[Extraction]" then amount = "-"..amount end
				exports.SZSQL:_Exec("INSERT INTO banklog(User, Reason, LastDeposited, Amount, NewDeposited, Date, IP, Serial) VALUES(?, ?, ?, ?, ?, ?, ?, ?)", user, reason, actualDep, amount, newDep, date, ip, serial)
			end
		end
	end
)

--Main functions
function validar(amount, thePlayer)
	if tonumber(amount) then
		if tonumber(amount) >= 1 then
			return true
		else
			exports.SZMisc:_msgsv("bank", "err", "min", thePlayer)
		end
	else
		exports.SZMisc:_msgsv("gral", "err", "num", thePlayer)
	end
end
