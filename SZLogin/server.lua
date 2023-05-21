function open()
	if isGuestAccount(getPlayerAccount(source)) then triggerClientEvent(source, "[SZLogin]:openClose", source, "openLoginPanel") end
end
addEventHandler("onPlayerJoin", getRootElement(), open)
addEventHandler("onPlayerLogout", getRootElement(), open)
addEventHandler("onPlayerResourceStart", getRootElement(), open)

addEvent("[SZLogin]:register", true)
addEventHandler("[SZLogin]:register", getRootElement(),
	function(thePlayer, user, pw)
		if isGuestAccount(getPlayerAccount(thePlayer)) then
			local check, nick, ip, serial, checkS, originalAcc = exports.SZMisc:_get("user", "getRegistration", thePlayer)
			local date = exports.SZMisc:_fecha()
			if not check and not getAccount(user) then
				if not checkS then
					local sha = tostring(sha256(pw))
					if addAccount(tostring(user), sha) then
						exports.SZSQL:_Exec("INSERT INTO users(Usuario, Password, IP, Serial, Registro, UltimaConexion) VALUES(?, ?, ?, ?, ?, ?)", user, sha, ip, serial, date, date)
						exports.SZMisc:_msgsv("login", "info", "reg", thePlayer)
						logIn(thePlayer, getAccount(user), sha)
						local skin, money, armor, vida, x, y, z, xr, yr, zr, int, dim, team = exports.SZMisc:_get("user", "getDBPlayerInfo", thePlayer)
						spawnPlayer(thePlayer, x, y, z, xr, yr, zr)
						setElementModel(thePlayer, skin)
						setPlayerTeam(thePlayer, getTeamFromName(team))
						givePlayerMoney(thePlayer, money)
						triggerClientEvent(thePlayer, "[SZLogin]:openClose", thePlayer, "closeLoginRegisterPanels")
					else exports.SZMisc:_msgsv("gral", "err", "sv", thePlayer)
					end
				else	
					exports.SZMisc:_msgsv("login", "err", "serial")
					exports.SZSQL:_Exec("INSERT INTO usersregduplog(Nickname, CuentaOriginal, IP, Serial, Fecha) VALUES(?, ?, ?, ?, ?)", nick, originalAcc, ip, serial, date)
				end
			else exports.SZMisc:_msgsv("login", "err", "existe", thePlayer)
			end
		else exports.SZMisc:_msgsv("login", "err", "on")
		end
	end
)

addEvent("[SZLogin]:login", true)
addEventHandler("[SZLogin]:login", getRootElement(),
	function(thePlayer, user, pw)
		local checkUser, checkIP, checkS, checkPw, checkR = exports.SZMisc:_loginget(user)
		local nick, ip, serial = getPlayerName(thePlayer), getPlayerIP(thePlayer), getPlayerSerial(thePlayer)
		if getAccount(user) then
			local date = exports.SZMisc:_fecha()
			if (checkS == serial) and (checkPw == tostring(sha256(pw))) then
				logIn(thePlayer, getAccount(user), tostring(sha256(pw)))
				triggerClientEvent(thePlayer, "[SZLogin]:openClose", thePlayer, "closeLoginRegisterPanels")
				exports.SZMisc:_msgsv("login", "info", "logged-in", thePlayer)
			elseif (checkS ~= serial) and (checkPw == tostring(sha256(pw))) then
				exports.SZMisc:_msgsv("login", "err", "pc", thePlayer)
				exports.SZSQL:_Exec("INSERT INTO usersloginseriallog(Nickname, IP, Serial, Usuario, IPOriginal, SerailOriginal, Fecha) VALUES(?, ?, ?, ?, ?, ?, ?)", nick, ip, serial, checkUser, checkIP, checkS, date)
			else exports.SZMisc:_msgsv("login", "err", "pwinv", thePlayer)
			end
		else exports.SZMisc:_msgsv("login", "err", "no", thePlayer)
		end
	end
)

addEventHandler("onPlayerQuit", getRootElement(),
	function()
		local user = getAccountName(getPlayerAccount(source))
		local date = exports.SZMisc:_fecha()
		exports.SZSQL:_Exec("UPDATE users SET UltimaConexion = ? WHERE Usuario = ?", date, user)
	end
)