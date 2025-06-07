print("DEBUG: FIELDS.LUA ACCESSED")
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



function SmartAgrometer:scanField(fieldId)
    if self.xmlFile == nil then
        -- Try to load XML once
        local saveDir = nil
        if g_currentMission.missionInfo ~= nil then
            saveDir = g_currentMission.missionInfo.savegameDirectory or g_currentMission.missionInfo.savegameName
        end
        if saveDir == nil then
            print("DEBUG: Save directory is nil, cannot load XML")
            return
        end

        local filePath = nil
        if string.match(saveDir, "^[a-zA-Z]:[/\\]") then
            filePath = saveDir .. "/SmartAgrometerData.xml"
        else
            local baseSavePath = getUserProfileAppPath() .. "savegames/"
            filePath = baseSavePath .. saveDir .. "/SmartAgrometerData.xml"
        end

        if not fileExists(filePath) then
            print("DEBUG: XML file does not exist, cannot scan")
            return
        end

        self.xmlFile = loadXMLFile("SmartAgrometerData", filePath)
    end

    if self.xmlFile == nil then
        print("DEBUG: XML file not loaded")
        return
    end

    -- Search XML for farmland with id = fieldId
    local numFarmlands = getNumOfChildren(self.xmlFile, "farmlands.farmland")
    for i = 0, numFarmlands - 1 do
        local id = getXMLInt(self.xmlFile, string.format("farmlands.farmland(%d)#id", i))
        if id == fieldId then
            local element = getXMLString(self.xmlFile, string.format("farmlands.farmland(%d).chemicalElement", i))
            print("DEBUG: Field " .. tostring(fieldId) .. " scanned. Chemical element: " .. tostring(element))
            -- Here you can add code to show a UI message instead of print
            return element
        end
    end

    print("DEBUG: Field ID " .. tostring(fieldId) .. " not found in XML")
    return nil
end
