function open()
	if isGuestAccount(getPlayerAccount(source)) then 
		triggerClientEvent(source, "[SZLogin]:openClose", source, "openLoginPanel") 
	end
end
addEventHandler("onPlayerJoin", getRootElement(), open) -- When someone joins to this server, runs open()
addEventHandler("onPlayerLogout", getRootElement(), open) -- When someone logout from his/her account, runs open()
addEventHandler("onPlayerResourceStart", getRootElement(), open) -- When this resource starts, runs open()

addEvent("[SZLogin]:register", true) -- Creates a custom event
addEventHandler("[SZLogin]:register", getRootElement(),
	function(thePlayer, username, password)
		if not getAccount(username) then -- If that username doesn't exist into my internal MTA:SA database
			local serial = getPlayerSerial(thePlayer)
			local checkSerial = exports.SZSQL:_QuerySingle("SELECT Serial FROM accounts WHERE Serial = ?", serial) -- Tries to find a match between player's serial and any account in MySQL database

			if not checkSerial then -- And if it doesn't find any match
				local encryptedPassword = tostring(sha256(password)) -- Encrypts password
				local userAccount = addAccount(tostring(username), encryptedPassword) -- Tries to add this new account into the internal database. If was created, it returns an account object. Else, a false.

				if userAccount then -- If it's value isn't a false
					local query = "SELECT accounts_addAccount(?, ?, ?) as new_account_id" -- Defines a query with an internal database function to add users into database and return last ID.
					local result = exports.SZSQL:_QuerySingle(query, username, encryptedPassword, serial) -- Execute this query with all necesary values to add into MySQL database
					local accountID = result['new_account_id'] -- Gets last accountID that was created thanks to that internal database function
					local x, y, z, rx, ry, rz = 1680.4482421875, 1497.376953125, 10.768490791321, 0, 0, 262.657 -- Defines specifics map coordinates and rotations (Las Venturas Airport) to use later
					
					logIn(thePlayer, userAccount, encryptedPassword)
					
					setAccountData(userAccount, "SQL_ID", accountID)
					--[[ 
						Saves accountID into a key:value using a native method that can be used by using natives log-in and register system. It's useful because
						if I need to get some information about this user, I can do it just by using getAccountData(getAccount(username), "ID") and then execute
						a query to get whatever I need. It's a gigant performance improvement. 
					]]--
					
					spawnPlayer(thePlayer, x, y, z, rx, ry, rz) -- Set players position to those coordinates
					setElementModel(thePlayer, 26) -- Set players skins to 26, a tourist skin
					triggerClientEvent(thePlayer, "[SZLogin]:openClose", thePlayer, "closeLoginRegisterPanels") -- Calls to client event to close register window
					exports.SZMisc:_serverInformationMsg("You have been registered sucessfully.")
				else
					exports.SZMisc:_serverErrorMsg("There was an unknown error while creating your account, please contact with Seyer for support.")
				end
			else	
				exports.SZMisc:_serverErrorMsg("Your PC serial matches with an existing account. If you need create another, ask to Seyer.")
			end
		else 
			exports.SZMisc:_serverErrorMsg("This username already exists, please choose another.") 
		end
	end
)

addEvent("[SZLogin]:login", true) -- Creates a custom event
addEventHandler("[SZLogin]:login", getRootElement(),
	function(thePlayer, username, password)
		local account = getAccount(username)

		if account then
			local accountID = getAccountData(account, "SQL_ID") -- Get account ID that's being used in MySQL database
			local encryptedPassword = tostring(sha256(password)) -- Encrypts password
			local passwordQueryFunction = "accounts_checkPassword" -- Defines stored function name's to use into MySQL database

			if(areEqual(passwordQueryFunction, encryptedPassword, accountID)) then
				local serial = getPlayerSerial(thePlayer)
				local serialQueryFunction = "accounts_checkSerial"

				if(areEqual(serialQueryFunction, serial, accountID)) then
					logIn(thePlayer, account, encryptedPassword)
					triggerClientEvent(thePlayer, "[SZLogin]:openClose", thePlayer, "closeLoginRegisterPanels") -- Calls to client event to close register window
					exports.SZMisc:_serverInformationMsg("You have been logged-in succesfully.")
				else
					exports.SZMisc:_serverErrorMsg("This account belongs to another PC. Selling accounts is forbbiden and it's a ban reason.")
				end
			else
				exports.SZMisc:_serverErrorMsg("Password is invalid.")
			end
		else
			exports.SZMisc:_serverErrorMsg("That username doesn't exist.")
		end
	end
)

function areEqual(sqlFunction, value, accountID)
	local query = "SELECT "..sqlFunction.."(?, ?) as areEqual" -- Defines a query with an internal database function to check accountID's password with MySQL database and returns 0 as true or 1 as false.
	local queryResult = exports.SZSQL:_QuerySingle(query, value, accountID) -- Execute this query with all necesary values to check into MySQL database
	local areEqual = (queryResult["areEqual"] ~= 0) -- If it's different to 0, it's 1 so it's true

	return areEqual
end