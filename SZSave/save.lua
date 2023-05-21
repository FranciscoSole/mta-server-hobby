addEventHandler("onPlayerQuit", getRootElement(),
	function()
		if not isGuestAccount(getPlayerAccount(source)) then
			local user = getAccountName(getPlayerAccount(source))
			local skin, money, armor, hp, x, y, z, xr, yr, zr, int, dim, team = exports.SZMisc:_get("user", "getAllActualPlayerInfo", source)
			exports.SZSQL:_Exec("UPDATE users SET Skin = ?, Money = ?, Armor = ?, HP = ?, x = ?, y = ?, z = ?, xr = ?, yr = ?, zr = ?, Interior = ?, Dimension = ?, Team = ? WHERE Usuario = ?", skin, money, armor, hp, x, y, z, xr, yr, zr, int, dim, team, user)
		end
	end
)

addEventHandler("onResourceStop", getRootElement(),
	function()
		for _,v in ipairs(getElementsByType("player")) do
			if not isGuestAccount(getPlayerAccount(v)) then
				local user = getAccountName(getPlayerAccount(v))
				local skin, money, armor, hp, x, y, z, xr, yr, zr, int, dim, team = exports.SZMisc:_get("user", "getAllActualPlayerInfo", v)
				exports.SZSQL:_Exec("UPDATE users SET Skin = ?, Money = ?, Armor = ?, HP = ?, x = ?, y = ?, z = ?, xr = ?, yr = ?, zr = ?, Interior = ?, Dimension = ?, Team = ? WHERE Usuario = ?", skin, money, armor, hp, x, y, z, xr, yr, zr, int, dim, team, user)	
			end
		end
	end
)

addEventHandler("onPlayerLogin", getRootElement(),
	function()
		local skin, money, armor, hp, x, y, z, xr, yr, zr, int, dim, team = exports.SZMisc:_get("user", "getDBPlayerInfo", source)
		local r, g, b = getTeamColor(getTeamFromName(team))
		setElementModel(source, skin)
		setPlayerMoney(source, money)
		setPedArmor(source, armor)
		setElementHealth(source, hp)
		setElementPosition(source, x, y, z)
		setElementRotation(source, xr, yr, zr)
		setElementInterior(source, int)
		setElementDimension(source, dim)
		setPlayerTeam(source, getTeamFromName(team))
		setBlipColor(source, r, g, b, 255)
		setPlayerNametagColor(source, r, g, b)
		--if (type(checkW) == "table") then 
		--	for _, weapon in pairs (checkW) do 
		--		if (weapon.gun and weapon.ammo) then 
		--			giveWeapon(source, weapon.gun, weapon.ammo)
		--		end 
		--	end
		--end
	end
)

addEventHandler("onPlayerSpawn", getRootElement(),
	function()
		if not isGuestAccount(getPlayerAccount(source)) then
			local skin, team = exports.SZMisc:_respawnget(source)
			setElementModel(source, skin)
			setPlayerTeam(source, getTeamFromName(team))
		end
	end
)
