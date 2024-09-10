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
		print("Updating account ID '"..accountID.."' information...")
	end
end

addEventHandler("onPlayerQuit", root, 
	function()
		savePlayerInfo(source)
	end
)

addEventHandler("onResourceStop", getRootElement(), 
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
			setElementModel(source, result.Skin)
			setPlayerMoney(source, result.Money)
			setElementInterior(source, result.Interior)
			setElementDimension(source, result.Dimension)
			setElementPosition(source, result.X, result.Y, result.Z)
			setElementRotation(source, result.Rx, result.Ry, result.Rz)
			-- setPlayerTeam(source, getTeamFromName(team))
			-- setBlipColor(source, r, g, b, 255)
			-- setPlayerNametagColor(source, r, g, b)
			-- local skin, money, armor, hp, x, y, z, xr, yr, zr, int, dim, team = exports.SZMisc:_get("user", "getDBPlayerInfo", source)
			-- local r, g, b = getTeamColor(getTeamFromName(team))
			
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
	function()
		if not isGuestAccount(getPlayerAccount(source)) then
			local skin, team = exports.SZMisc:_respawnget(source)
			setElementModel(source, skin)
			setPlayerTeam(source, getTeamFromName(team))
		end
	end
)
