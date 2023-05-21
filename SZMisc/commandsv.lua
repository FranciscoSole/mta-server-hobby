function findPlayer(name) 
    local matches = {} 
    for _,v in ipairs(getElementsByType("player")) do 
		local playerName = getPlayerName(v):gsub("#%x%x%x%x%x%x", "") 
		local playerName = playerName:lower() 
        if getPlayerName(v) == name or playerName:find(name:lower(), 0) then 
			table.insert(matches, v) 
			break
        end 
    end 
    --if #matches == 1 then return matches[1] end 
    return matches[1] or false 
end 

addCommandHandler("send", 
    function(player, cmd, name, amount, target) 
        local amount = tonumber(amount) 
        if name and amount then 
            local target = findPlayer(name)
			if target then
				if player ~= target then
					local money = getPlayerMoney(player)
					if money >= amount then 
						if amount > 0 then
							takePlayerMoney(player, amount) 
							givePlayerMoney(target, amount) 
							outputChatBox("#009999[Info]#FFFFFF  Le mandaste $"..amount.." a ".. getPlayerName(target).. ".", player, 0, 255, 0, true) 
							outputChatBox("#009999[Info]#FFFFFF  "..getPlayerName(player).. " te envió $" ..amount.. ".", target, 0, 255, 0, true)
						end
					else exports.SZMisc:_get("bank", "err", "cant", player)
					end
				else exports.SZMisc:_get("cmd", "err", "user", player)
				end
			else exports.SZMisc:_get("cmd", "err", "send", player)
			end 
		end
    end 
)

addCommandHandler("re", 
	function(thePlayer, cmd, name, target)
		if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(thePlayer)), aclGetGroup("Console")) then
			if name then redirectPlayer(findPlayer(name), gettok("190.245.179.118:22003",1,":"), tonumber(gettok("190.245.179.118:22003",2,":")), "ksa")
			else exports.SZMisc:_get("cmd", "err", "user", player)
			end
		end
	end
)

addCommandHandler("pos",
	function(thePlayer)
		if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(thePlayer)), aclGetGroup("Console")) then
			local x, y, z = getElementPosition(thePlayer)
			local rx, ry, rz = getElementRotation(thePlayer)
			outputChatBox("Tus coordenadas son: "..x..", "..y..", "..z, thePlayer)
			outputChatBox("Tu rotación es: "..rx..", "..ry..", "..rz, thePlayer)
		end
	end
)

addCommandHandler("admins",
	function(thePlayer, theVehicle)
		if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(thePlayer)), aclGetGroup("Console")) then
			setElementPosition(thePlayer, 1968.3653564453, 1299.79296875, 2070.1625976563)
		end
	end
)

addCommandHandler("m", 
	function(thePlayer)
		local currentState = isCursorShowing(thePlayer)
		local oppositeState = not currentState
		showCursor(thePlayer, oppositeState) 
	end
)