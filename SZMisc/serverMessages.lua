 function _serverErrorMsg(message)
    local errorMsg = "#DD0606[Error]#FFFFFF"
    local msg = errorMsg.. " "..message

    outputChatBox(msg, thePlayer, 255, 255, 255, true)
end

function _serverInformationMsg(message)
    local informationMsg = "#009999[Information]#FFFFFF"
    local msg = informationMsg.. " "..message

    outputChatBox(msg, thePlayer, 255, 255, 255, true)
end