local bankMainTransactions = createMarker (246.43359375, 118.5908203125, 1002.21875, "cylinder", 1.2, 250, 250, 7, 120, getRootElement())
setElementDimension(bankMainTransactions, 1)  
setElementInterior(bankMainTransactions, 10)

local getCard = createMarker(251.6865234375, 117.45703125, 1002.21875, "cylinder", 1.2, 250, 250, 7, 120, getRootElement())
setElementDimension(getCard, 1)  
setElementInterior(getCard, 10)

--Main events
addEventHandler("onMarkerHit", root,
	function(thePlayer)
		if getElementType(thePlayer) == "player" and not isPedInVehicle(thePlayer) then
			local account = getPlayerAccount(thePlayer)
			local bankID = getAccountData(account, "BANK_ID") -- Tries to get user's bankID, if doesn't exist return false

			if bankID then
				if (source == bankMainTransactions) then -- If hitted marked is bankMainTransactions
					local getBalanceQuery = "SELECT bank_getBalance(?) as balance" -- Defines a query to an internal database function
					local getBalanceQueryResult = exports.SZSQL:_QuerySingle(getBalanceQuery, bankID)
					local balance = getBalanceQueryResult['balance'] -- Gets player balance

					triggerClientEvent(thePlayer, "[SZBank]:refreshDep", thePlayer, balance)
					triggerClientEvent(thePlayer, "[SZBank]:open", thePlayer, "openMainBankPanel")
				elseif (source == getCard) then 
					exports.SZMisc:_msgsv("bank", "err", "already", thePlayer)
					setAccountData(account, "BANK_ID", nil) -- Sets this new ID as an internal property for further usage.

				end
			else
				if (source == bankMainTransactions) then 
					exports.SZMisc:_msgsv("bank", "err", "n/a", thePlayer)

				elseif (source == getCard) then 
					triggerClientEvent(thePlayer, "[SZBank]:open", thePlayer, "openGetCardPanel")
				end
			end
		end
	end
)

function createCreditCard(thePlayer)
	if getPlayerMoney(thePlayer) >= 50000 then
		local creditCardNumber = math.random(4000, 4999).." "..math.random(4000, 4999).." "..math.random(4000, 4999).." "..math.random(4000, 4999) -- Creates a 16 digits random number to simulate a credit card number, tried to create it as an BIGINT but didn't work properly
		local checkCreditCardNumber = exports.SZSQL:_QuerySingle("SELECT * FROM bank WHERE CreditCard = ", creditCardNumber) -- Tries to match this creditCardNumber with an existing one to avoid duplicated numbers

		if not checkCreditCardNumber then -- If that number doesn't exist on MySQL database
			local addBankAccountQuery = "SELECT bank_addAccount(?) as new_account_id" -- Defines a query to an internal database function 
			local addBankAccountQueryResult = exports.SZSQL:_QuerySingle(addBankAccountQuery, creditCardNumber) -- Creates a new bank account and returns last BankID created
			local bankID = addBankAccountQueryResult['new_account_id'] -- Gets last bankID that was created thanks to that internal database function
			
			local account = getPlayerAccount(thePlayer)
			local accountID = getAccountData(account, "SQL_ID") -- Get account ID to update BankID into accounts_index table
			local updateIndexBankIDQuery = "CALL accounts_index_addBankID(?, ?)"
			exports.SZSQL:_Exec(updateIndexBankIDQuery, bankID, accountID) 
			
			takePlayerMoney(thePlayer, 50000)
			setAccountData(account, "BANK_ID", bankID) -- Sets this new ID as an internal property for further usage.
			exports.SZMisc:_serverInformationMsg("Congratulations! You just got your new credit card! Now go to your left to do some transactions.")
		else 
			createCreditCard(thePlayer) -- Recursivily tries to create another number that doesn't exist on MySQL database. Doesn't need to be 'local example = createCreditCard(thePlayer)' 
		end
	else
		exports.SZMisc:_serverErrorMsg("You need more money.")
	end
end
addEvent("[SZBank]:createCreditCard", true)
addEventHandler("[SZBank]:createCreditCard", getRootElement(), createCreditCard)

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
