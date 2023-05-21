function _fecha()
    local time = getRealTime()
    local dia, mes, anio = time.monthday, time.month + 1, time.year + 1900
    local hora, minuto, segundo = time.hour, time.minute, time.second
    if (mes < 10) then mes = 0 ..mes end
    if (dia < 10) then dia = 0 ..dia end
    if (hora < 10) then hora = 0 ..hora end
    if (minuto < 10) then minuto = 0 ..minuto end
    if (segundo < 10) then segundo = 0 ..segundo end
    return dia.."-"..mes.."-"..anio.." "..hora..":"..minuto..":"..segundo
end