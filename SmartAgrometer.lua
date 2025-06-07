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

            if g_fieldManager ~= nil and g_fieldManager.fields ~= nil then
            local numFields = #g_fieldManager.fields
            print("DEBUG: Number of fields = " .. tostring(numFields))
        else
            print("DEBUG: g_fieldManager or fields is nil")
        end
local chemicalElements = {
    "Nitrogen", "Phosphorus", "Potassium", "Calcium",
    "Magnesium", "Sulfur", "Iron", "Zinc",
    "Copper", "Manganese", "Boron", "Molybdenum"
}

        local xmlFile = createXMLFile("SmartAgrometerData", filePath, "fields")

        for i = 1, #g_fieldManager.fields do
            local field = g_fieldManager.fields[i]
            if field ~= nil then
                local fieldId = field.fieldId or i  -- fallback to index if no ID
                local randomElement = chemicalElements[math.random(#chemicalElements)]

                local key = string.format("root.field(%d)", i)  -- XML uses 0-based indices

                setXMLInt(xmlFile, key .. "#id", fieldId)
                setXMLString(xmlFile, key .. ".chemicalElement", randomElement)
            end
        end

        saveXMLFile(xmlFile)
        delete(xmlFile)
        print("DEBUG: XML file populated with field data and saved")
            print("DEBUG: XML file created at " .. filePath)
        else
            print("DEBUG: Save directory is nil, cannot create XML file")
        end
    end
end

addModEventListener(SmartAgrometer)