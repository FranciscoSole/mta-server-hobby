addCommandHandler("devmode",
    function(thePlayer)
		if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(thePlayer)), aclGetGroup("Console")) then
			setDevelopmentMode(true)
			outputChatBox("#009999[Info]#FFFFFF Devmode: ON",thePlayer, 0, 255, 0, true)
		end
    end
)