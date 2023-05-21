function centerWindow (center_window)
    local screenW, screenH = dgsGetScreenSize()
    local windowW, windowH = dgsGetSize(center_window, false)
    local x, y = (screenW - windowW) /2,(screenH - windowH) /2
    return dgsSetPosition(center_window, x, y, false)
end