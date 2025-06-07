
SmartAgrometer = SmartAgrometer or {}

function SmartAgrometer:getFarmlandUnderPlayer()
    local player = g_currentMission.controlPlayer
    if player == nil then
        print("DEBUG: No player found")
        return nil
    end
    
    local px, py, pz = getWorldTranslation(player.rootNode)
    local farmlandId = g_farmlandManager:getFarmlandAtWorldPosition(px, py, pz)
    
    if farmlandId == 0 then
        print("DEBUG: Player is not on any farmland")
        return nil
    else
        print("DEBUG: Player is on farmland ID " .. farmlandId)
        return farmlandId
    end
end
