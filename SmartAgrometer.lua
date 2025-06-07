print("DEBUG: atejau iki cia")

SmartAgrometer = {}

function SmartAgrometer:update(dt)
    if not self.loadFinished and g_currentMission ~= nil and g_currentMission.isLoaded then
        self.loadFinished = true

        local saveDir = nil

        if g_currentMission.missionInfo ~= nil then
            saveDir = g_currentMission.missionInfo.savegameDirectory
            if saveDir == nil then
                saveDir = g_currentMission.missionInfo.savegameName
            end
        end

        print("DEBUG: saveDir = " .. tostring(saveDir))

        local filePath = nil
        if saveDir ~= nil then
            -- Check if saveDir is an absolute path (Windows example)
            if string.match(saveDir, "^[a-zA-Z]:[/\\]") then
                filePath = saveDir .. "/SmartAgrometerData.xml"
            else
                local baseSavePath = getUserProfileAppPath() .. "savegames/"
                filePath = baseSavePath .. saveDir .. "/SmartAgrometerData.xml"
            end

            print("DEBUG: Full file path: " .. filePath)

            local xmlFile = createXMLFile("SmartAgrometerData", filePath, "root")
            saveXMLFile(xmlFile)
            delete(xmlFile)
            print("DEBUG: XML file created at " .. filePath)
        else
            print("DEBUG: Save directory is nil, cannot create XML file")
        end
    end
end

addModEventListener(SmartAgrometer)