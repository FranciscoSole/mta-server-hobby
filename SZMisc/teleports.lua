local BancoEntrada = createMarker(2127.498046875, 2378.1103515625, 11.4203125, "arrow", 1.2, 0, 0, 255, 255, getRootElement())
createBlipAttachedTo(BancoEntrada, 52)
createBlip(2127.498046875, 2378.1103515625, 11.4203125, 52)

local BancoSalida = createMarker(246.337890625, 108.4912109375, 1003.81875, "arrow", 1.2, 0, 255, 255, 255, getRootElement())
setElementDimension(BancoSalida, 1)
setElementInterior(BancoSalida, 10) 

local ComisariaEntrada = createMarker(2290.09765625, 2430.4970703125, 11.8203125, "arrow", 1.5, 0, 255, 255, 255, getRootElement())
createBlipAttachedTo(ComisariaEntrada, 30)
createBlip(2290.09765625, 2429.4970703125, 10.8203125, 30)

local ComisariaSalida = createMarker (246.7998046875, 63.287109375, 1004.640625, "arrow", 1.5, 0, 255, 255, 255, getRootElement())
setElementDimension(ComisariaSalida, 1)  
setElementInterior(ComisariaSalida, 6)

---------------------------------------------------------------------------------------------- [Banco] ----------------------------------------------------------------------------------------------
addEventHandler("onMarkerHit", getRootElement(),
	function(hitElement)
		if getElementType(hitElement) == "player" then
			if not isPedInVehicle(hitElement) then
				if (source == BancoEntrada) or (source == ComisariaEntrada) then
					toggleControl(hitElement, "fire", false)
					toggleControl(hitElement, "aim_weapon", false)
					toggleControl(hitElement, "next_weapon", false)
					toggleControl(hitElement, "previous_weapon", false)
					setElementDimension(hitElement, 1)
				elseif (source == BancoSalida) or (source == ComisariaSalida) then
					toggleControl(hitElement, "fire", true)
					toggleControl(hitElement, "aim_weapon", true)
					toggleControl(hitElement, "next_weapon", true)
					toggleControl(hitElement, "previous_weapon", true) 
					setElementDimension(hitElement, 0)
					setElementInterior(hitElement, 0)
				end

				if (source == BancoEntrada) then setElementPosition(hitElement, 246.267578125, 110.4228515625, 1003.2257080078) setElementInterior(hitElement, 10)
				elseif (source == BancoSalida) then setElementPosition(hitElement, 2127.5751953125, 2374.7587890625, 10.8203125)
				elseif (source == ComisariaEntrada) then setElementPosition(hitElement, 246.5634765625, 66.2470703125, 1003.640625) setElementInterior(hitElement, 6)
				elseif (source == ComisariaSalida) then setElementPosition(hitElement, 2289.86328125, 2427.109375, 10.8203125)
				end
			else exports.SZMisc:_msgsv("gral", "err", "tpveh", hitElement)
			end
		end
	end
)