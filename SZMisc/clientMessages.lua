function _clientErrorMsg(message)
    local errorMsg = "#DD0606[Error]#FFFFFF"
    local msg = errorMsg.. " "..message

    outputChatBox(msg, 255, 255, 255, true)
end

function _clientInformationMsg(message)
    local informationMsg = "#009999[Information]#FFFFFF"
    local msg = informationMsg.. " "..message

    outputChatBox(msg, 255, 255, 255, true)
end