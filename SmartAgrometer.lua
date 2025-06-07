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
                local chemicalElements = {
                    "Nitrogen", "Phosphorus", "Potassium", "Calcium",
                    "Magnesium", "Sulfur", "Iron", "Zinc",
                    "Copper", "Manganese", "Boron", "Molybdenum"
                }

                local xmlFile = createXMLFile("SmartAgrometerData", filePath, "fields")

                local fieldCount = 0
                for i, field in pairs(g_fieldManager.fields) do
                    if field ~= nil then
                        fieldCount = fieldCount + 1
                        local randomElement = chemicalElements[math.random(#chemicalElements)]
                        local keyBase = string.format("fields.field(%d)", fieldCount - 1) -- zero-based XML index

                        -- Write field ID (just numbering 1..n)
                        setXMLInt(xmlFile, keyBase .. "#id", fieldCount)
                        -- Write random chemical element
                        setXMLString(xmlFile, keyBase .. ".chemicalElement", randomElement)

                        print(string.format("DEBUG: Field %d, element %s written", fieldCount, randomElement))
                    end
                end

                print("DEBUG: Actual accessible fields counted: " .. tostring(fieldCount))

                saveXMLFile(xmlFile)
                delete(xmlFile)

                print("DEBUG: XML file created and saved at " .. filePath)
            else
                print("DEBUG: g_fieldManager or fields is nil")
            end
        else
            print("DEBUG: Save directory is nil, cannot create XML file")
        end
    end
end

addModEventListener(SmartAgrometer)
