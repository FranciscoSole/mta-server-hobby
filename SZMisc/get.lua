function _get(where, whatDo, thePlayer)
    if getElementType(thePlayer) == "player" then
        local user = getAccountName(getPlayerAccount(thePlayer))
        if where == "bank" then
            local check = exports.SZSQL:_QuerySingle("SELECT * FROM bank WHERE User = ?", user)
            if check then
                if whatDo == "getSomePlayerBankInfo" then return user, getPlayerIP(thePlayer), getPlayerSerial(thePlayer), check.Deposited, getPlayerMoney(thePlayer)
                elseif whatDo == "getPlayerCard" then return true
                elseif whatDo == "getPlayerBankDep" then return check.Deposited
                elseif whatDo == "admin" then return check.Deposited, check.CardNumber, check.Lvl
                elseif whatDo == "targetLog" then
                    local bankUserLog = {}

                    local checkUserLog = exports.SZSQL:_QuerySingle("SELECT * FROM banklog WHERE User = ?", user)
                    if checkUserLog then bankUserLog = exports.SZSQL:_Query("SELECT * FROM banklog WHERE User = ?", user) end
                    
                    local checkStaffLog = exports.SZSQL:_QuerySingle("SELECT * FROM staffbanklog WHERE TargetAcc = ?", user)
                    if (checkUserLog and checkStaffLog) or (checkStaffLog and not checkUserLog) then
                        local bankStaffLog = exports.SZSQL:_Query("SELECT * FROM staffbanklog WHERE TargetAcc = ?", user)
                        for _, v in ipairs(bankStaffLog) do table.insert(bankUserLog, v) end
                    end
                    
                    return bankUserLog 
                end
            end
        elseif where == "veh" then
            local check = exports.SZSQL:_Query("SELECT * FROM vehicles WHERE Usuario = ?", user)
            if check then
                if whatDo == "getVehicle" then return true 
                elseif whatDo == "getAllVehiclesFromPlayer" then return check.Vehicles
                end
            end

        elseif where == "user" then
            local check = exports.SZSQL:_QuerySingle("SELECT * FROM users WHERE Usuario = ?", user)
            if check then
                if whatDo == "getSomePlayerInfo" then return user, getPlayerName(thePlayer), getPlayerIP(thePlayer), getPlayerSerial(thePlayer)
                elseif whatDo == "getDBPlayerInfo" then return check.Skin, check.Money, check.Armor, check.HP, check.x, check.y, check.z, check.xr, check.yr, check.zr, check.Interior, check.Dimension, check.Team
                elseif whatDo == "getAllActualPlayerInfo" then 
                    local x, y, z = getElementPosition(thePlayer)
                    local xr, yr, zr = getElementRotation(thePlayer)
                    local team
                    if getPlayerTeam(thePlayer) then team = getTeamName(getPlayerTeam(thePlayer)) else team = "Desempleado" end
                    return getElementModel(thePlayer) or 26, getPlayerMoney(thePlayer), getPedArmor(thePlayer), getElementHealth(thePlayer), x, y, z, xr, yr, zr, getElementInterior(thePlayer), getElementDimension(thePlayer), team
                end
            else
                if whatDo == "getRegistration" then
                    local checkS = exports.SZSQL:_QuerySingle("SELECT * FROM users WHERE Serial = ?", getPlayerSerial(thePlayer))
                    if checkS then return true, getPlayerName(thePlayer), getPlayerIP(thePlayer), getPlayerSerial(thePlayer), checkS, checkS.Usuario
                    else return false, getPlayerName(thePlayer), getPlayerIP(thePlayer), getPlayerSerial(thePlayer), false, false
                    end
                end
            end
        elseif where == "admin" then
            if whatDo == "load" then
                local vehName, vehHp, vehModel, vehOwner, cardDep, cardNum, cardLvl, team
                local vehicle = getPedOccupiedVehicle(thePlayer)
                if vehicle then 
                    vehName = getVehicleName(vehicle)
                    vehHp = getElementHealth(vehicle).."%"
                    vehModel = getElementModel(vehicle)
                end

                local checkBank = _get("bank", "getPlayerCard", thePlayer)
                if checkBank then 
                    cardDep, cardNum, cardLvl = _get("bank", "admin", thePlayer)
                    checkBank = "Sí" 
                end

                local checkLog = _get("bank", "targetLog", thePlayer)
                if getPlayerTeam(thePlayer) then team = getTeamName(getPlayerTeam(thePlayer)) end
                return user, getPlayerName(thePlayer), getPlayerIP(thePlayer), getPlayerSerial(thePlayer), getElementHealth(thePlayer), getPedArmor(thePlayer), getPlayerMoney(thePlayer), getElementModel(thePlayer), team, getElementInterior(thePlayer), getElementDimension(thePlayer), vehOwner or "N/A", vehName or "No", vehHp or "N/A", vehModel or "N/A", checkBank or "No", cardDep or "N/A", cardNum or "N/A", cardLvl or "N/A", checkLog
            end
        end
        --[[local guns = { }
        for slot = 0, 12 do
            guns[slot] = 
            {
                gun = getPedWeapon (thePlayer, slot), 
                ammo = getPedTotalAmmo (thePlayer, slot) 
            }
        end]]
    end
end

function _loginget(user) --SZLogin, server, 42
    local check = exports.SZSQL:_QuerySingle("SELECT * FROM users WHERE Usuario = ?", user)
    if check then return check.Usuario, check.IP, check.Serial, check.Password, check.Rank end
end

function _respawnget(source) --SZSave, server, 49 | SZJobs -> sztab, server, 22
    local check = exports.SZSQL:_QuerySingle("SELECT * FROM users WHERE Usuario = ?", getAccountName(getPlayerAccount(source)))
    if check then return check.Skin, check.Team end
end


