function _msgcl(origen, opt, modo)
    local inf = "#009999[Info]#FFFFFF  "
    local err = "#DD0606[Error]#FFFFFF  "
    if origen == "gral" then  
        if opt == "err" then
            if modo == "nro" then outputChatBox(err.. "Solo podes poner números.", 255, 255, 255, true)
            elseif modo == "all" then outputChatBox(err.. "Rellena todos los campos.", 255, 255, 255, true)
            elseif modo == "some" then outputChatBox(err.. "Completa el campo.", 255, 255, 255, true)
            elseif modo == "func" then outputChatBox(err.. "Selecciona alguna función.", 255, 255, 255, true)
            elseif modo == "cl" then outputChatBox(err.. "Hubo un error del lado del cliente. Contactate con Seyer.", 255, 255, 255, true)
            end
        end
    elseif origen == "login" then
        if opt == "err" then
            if modo == "dist" then outputChatBox(err.. "Las contraseñas no son iguales.", 255, 255, 255, true)
            elseif modo == "uDig" then outputChatBox(err.. "Ingresa un usuario mayor o igual a 5 caracteres.", 255, 255, 255, true)
            elseif modo == "pwDig" then outputChatBox(err.. "Ingresa una contraseña mayor o igual a 6 caracteres.", 255, 255, 255, true)
            end
        end
    elseif origen == "admin" then
        if opt == "err" then
            if modo == "cant" then outputChatBox(err.. "La cantidad mínima es de un número mayor o igual a 1.", 255, 255, 255, true) end
        end
    end
end