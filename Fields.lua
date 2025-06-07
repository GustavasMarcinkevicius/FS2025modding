-- local function createEmptyXML(saveDir)
--     if not fileExists(saveDir) then
--         createFolder(saveDir)
--     end

--     local filename = saveDir .. "/smartAgrometer.xml"
--     local xmlFile = createXMLFile("smartAgrometer", filename, "smartAgrometer")

--     -- No data added at all

--     saveXMLFile(xmlFile)
--     delete(xmlFile)
--     print("Empty XML file created at: " .. filename)
-- end

-- -- Example usage:
-- local saveDir = "C:/Users/User/Documents/My Games/FarmingSimulator2025/savegame1/modSettings"
-- createEmptyXML(saveDir)