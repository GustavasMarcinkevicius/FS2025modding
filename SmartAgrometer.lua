print("DEBUG: SmartAgrometer script loaded")

SmartAgrometer = {}

local chemicalElements = {
    "Nitrogen", "Phosphorus", "Potassium", "Calcium",
    "Magnesium", "Sulfur", "Iron", "Zinc",
    "Copper", "Manganese", "Boron", "Molybdenum"
}

local function fileExists(path)
    local file = io.open(path, "r")
    if file then
        file:close()
        return true
    else
        return false
    end
end

function SmartAgrometer:update(dt)
    if not self.loadFinished and g_currentMission ~= nil and g_currentMission.isLoaded then
        self.loadFinished = true

        local saveDir = nil
        if g_currentMission.missionInfo ~= nil then
            saveDir = g_currentMission.missionInfo.savegameDirectory or g_currentMission.missionInfo.savegameName
        end

        print("DEBUG: saveDir = " .. tostring(saveDir))

        if saveDir == nil then
            print("DEBUG: Save directory is nil, cannot create XML file")
            return
        end

        local filePath = nil
        if string.match(saveDir, "^[a-zA-Z]:[/\\]") then
            -- absolute path (Windows)
            filePath = saveDir .. "/SmartAgrometerData.xml"
        else
            -- relative path, construct from base savegames folder
            local baseSavePath = getUserProfileAppPath() .. "savegames/"
            filePath = baseSavePath .. saveDir .. "/SmartAgrometerData.xml"
        end

        print("DEBUG: Full file path: " .. filePath)

        if fileExists(filePath) then
            print("DEBUG: XML file already exists at " .. filePath .. ", skipping creation.")
            return
        end

        if g_farmlandManager == nil or g_farmlandManager.farmlands == nil then
            print("DEBUG: g_farmlandManager or farmlands table is nil, cannot proceed")
            return
        end

        local numFarmlands = #g_farmlandManager.farmlands
        print("DEBUG: Number of farmlands = " .. tostring(numFarmlands))

        local xmlFile = createXMLFile("SmartAgrometerData", filePath, "farmlands")

        for i = 1, numFarmlands do
            local farmland = g_farmlandManager.farmlands[i]
            local farmlandId = i  -- just use 1-based index as ID
            local randomElement = chemicalElements[math.random(#chemicalElements)]

            local keyBase = string.format("farmlands.farmland(%d)", i - 1) -- XML uses 0-based index

            setXMLInt(xmlFile, keyBase .. "#id", farmlandId)
            setXMLString(xmlFile, keyBase .. ".chemicalElement", randomElement)
        end

        saveXMLFile(xmlFile)
        delete(xmlFile)

        print("DEBUG: XML file created and saved at " .. filePath)
    end
end

addModEventListener(SmartAgrometer)
