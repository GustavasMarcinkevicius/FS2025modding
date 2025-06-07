print("DEBUG: SmartAgrometer script started")

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

            if g_farmlandManager ~= nil and g_farmlandManager.farmlands ~= nil then
                local numFarmlands = #g_farmlandManager.farmlands
                print("DEBUG: Number of farmlands = " .. tostring(numFarmlands))

                local chemicalElements = {
                    "Nitrogen", "Phosphorus", "Potassium", "Calcium",
                    "Magnesium", "Sulfur", "Iron", "Zinc",
                    "Copper", "Manganese", "Boron", "Molybdenum"
                }

                local xmlFile = createXMLFile("SmartAgrometerData", filePath, "farmlands")

                for i = 1, numFarmlands do
                    local farmland = g_farmlandManager.farmlands[i]
                    if farmland ~= nil then
                        local randomElement = chemicalElements[math.random(#chemicalElements)]
                        local keyBase = string.format("farmlands.farmland(%d)", i - 1) -- zero-based index for XML
                        setXMLInt(xmlFile, keyBase .. "#id", i)  -- just assign ID = i
                        setXMLString(xmlFile, keyBase .. ".chemicalElement", randomElement)
                        print(string.format("DEBUG: Farmland %d assigned element %s", i, randomElement))
                    else
                        print(string.format("DEBUG: Farmland %d is nil", i))
                    end
                end

                saveXMLFile(xmlFile)
                delete(xmlFile)
                print("DEBUG: XML file saved at " .. filePath)
            else
                print("DEBUG: g_farmlandManager or farmlands is nil")
            end
        else
            print("DEBUG: Save directory is nil, cannot create XML file")
        end
    end
end

addModEventListener(SmartAgrometer)