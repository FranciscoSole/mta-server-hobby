function getAccountID(source)
	local account = getPlayerAccount(source)
	local accountID = getAccountData(account, "SQL_ID")

	return accountID
end

function savePlayerInfo(player)
	local accountID = getAccountID(player)

	if accountID then
		local lastLogInQueryProcedure = "CALL accounts_updateLastLogIn(?)"
		local updatePlayerInfoProcedure = "CALL players_updateInfo(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"
		
		local hp = getElementHealth(player)
		local armor = getPedArmor(player)
		local money = getPlayerMoney(player)
		local skin = getElementModel(player)
		local dimension = getElementDimension(player)
		local interior = getElementInterior(player)
		local x, y, z = getElementPosition(player)
		local rx, ry, rz = getElementRotation(player)

		exports.SZSQL:_Exec(lastLogInQueryProcedure, accountID)
		exports.SZSQL:_Exec(updatePlayerInfoProcedure, hp, armor, money, skin, dimension, interior, x, y, z, rx, ry, rz, accountID)
		print("Saving account ID '"..accountID.."' information...")
	end
end

addEventHandler("onPlayerQuit", root, 
	function()
		savePlayerInfo(source)
	end
)

addEventHandler("onResourceStop", root,
	function()
		for index, player in ipairs(getElementsByType("player")) do -- For each player connected
			savePlayerInfo(player)
		end
	end
)

addEventHandler("onPlayerLogin", root,
	function()
		local accountID = getAccountID(source)

		if accountID then
			local getPlayerInfoQuery = "SELECT * FROM players WHERE AccountID = "..accountID
			local result = exports.SZSQL:_QuerySingle(getPlayerInfoQuery)

			setElementHealth(source, result.HP)
			setPedArmor(source, result.Armor)
			setPlayerMoney(source, result.Money)
			setElementModel(source, result.Skin)
			setElementInterior(source, result.Interior)
			setElementDimension(source, result.Dimension)
			setElementPosition(source, result.X, result.Y, result.Z)
			setElementRotation(source, result.Rx, result.Ry, result.Rz)
			-- local r, g, b = getTeamColor(getTeamFromName(team))
			-- setPlayerNametagColor(source, r, g, b)
			-- setPlayerTeam(source, getTeamFromName(team))
			-- setBlipColor(source, r, g, b, 255)
			
			--if (type(checkW) == "table") then 
			--	for _, weapon in pairs (checkW) do 
			--		if (weapon.gun and weapon.ammo) then 
			--			giveWeapon(source, weapon.gun, weapon.ammo)
			--		end 
			--	end
			--end
		end
	end
)

addEventHandler("onPlayerSpawn", root,
	function() -- When some player dies, MTA:SA by itself changes player's skin to a random one. So, to avoid it, we have to set again every time that player dies
		local accountID = getAccountID(source)

		if accountID then
			local getPlayerSkinQuery = "SELECT Skin FROM players WHERE AccountID = "..accountID
			local result = exports.SZSQL:_QuerySingle(getPlayerSkinQuery)
			
			setElementModel(source, result.Skin)
			-- setPlayerTeam(source, getTeamFromName(team))
		end
	end
) 