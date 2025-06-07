SmartAgrometerHandTool = {}
local SmartAgrometerHandTool_mt = Class(SmartAgrometerHandTool, HandTool)

function SmartAgrometerHandTool:new(isServer, isClient)
    local self = HandTool.new(self, isServer, isClient)
    setmetatable(self, SmartAgrometerHandTool_mt)
    return self
end

function SmartAgrometerHandTool:onActivate()
    -- Get farmland under player using your SmartAgrometer method
    local farmlandId = SmartAgrometer:getFarmlandUnderPlayer()
    if farmlandId ~= nil then
        local element = SmartAgrometer:scanField(farmlandId)
        if element ~= nil then
            -- Display to player (print for now)
            g_currentMission:addIngameNotification(FSBaseMission.INGAME_NOTIFICATION_OK, "Chemical element: " .. element)
        else
            g_currentMission:addIngameNotification(FSBaseMission.INGAME_NOTIFICATION_ERROR, "No chemical element data for field")
        end
    else
        g_currentMission:addIngameNotification(FSBaseMission.INGAME_NOTIFICATION_ERROR, "You are not on any farmland")
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

function SmartAgrometer:onActivate()
    local farmlandId = self:getFarmlandUnderPlayer()
    if farmlandId ~= nil then
        local element = self:scanField(farmlandId)
        if element ~= nil then
            -- Display the element
            -- For now, just print:
            print("Chemical element for farmland " .. farmlandId .. ": " .. element)
        else
            print("No chemical element data found for farmland " .. farmlandId)
        end
    else
        print("You are not standing on any farmland.")
    end