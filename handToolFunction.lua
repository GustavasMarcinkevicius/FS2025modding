print("DEBUG: HANDTOOLFUNCTION.LUA ACCESSED")

SmartAgrometerHandTool = {}
local SmartAgrometerHandTool_mt = Class(SmartAgrometerHandTool, HandTool)

function SmartAgrometerHandTool:new(isServer, isClient)
    local self = HandTool:new(isServer, isClient)
    setmetatable(self, SmartAgrometerHandTool_mt)
    return self
end

function SmartAgrometerHandTool:onActivate()
    print("DEBUG: onActivate() called!")
    SmartAgrometerHandTool:superClass().onActivate(self)  -- call base onActivate

    -- Now your custom code here:
    local farmlandId = SmartAgrometer:getFarmlandUnderPlayer()
    if farmlandId ~= nil then
        local element = SmartAgrometer:scanField(farmlandId)
        if element ~= nil then
            g_currentMission:addIngameNotification(FSBaseMission.INGAME_NOTIFICATION_OK, "Chemical element: " .. element)
        else
            g_currentMission:addIngameNotification(FSBaseMission.INGAME_NOTIFICATION_ERROR, "No chemical element data for field")
        end
    else
        g_currentMission:addIngameNotification(FSBaseMission.INGAME_NOTIFICATION_ERROR, "You are not on any farmland")
    end
end
-- SmartAgrometerHandTool = {}
-- local SmartAgrometerHandTool_mt = Class(SmartAgrometerHandTool, HandTool)

-- function SmartAgrometerHandTool:new(isServer, isClient)
--     local self = HandTool:new(isServer, isClient)
--     setmetatable(self, SmartAgrometerHandTool_mt)
--     return self
-- end

-- -- Override activate() to add your behavior
-- function SmartAgrometerHandTool:activate()
--     print("DEBUG: activate() called")
--     -- Call the base class activate() so the game handles activation properly
--     SmartAgrometerHandTool:superClass().activate(self)
    
--     -- Run your custom logic when the tool is activated (used)
--     self:onActivate()
-- end

-- function SmartAgrometerHandTool:onActivate()
--     print("DEBUG: onActivate() called")
--     local farmlandId = SmartAgrometer:getFarmlandUnderPlayer()
--     if farmlandId ~= nil then
--         local element = SmartAgrometer:scanField(farmlandId)
--         if element ~= nil then
--             g_currentMission:addIngameNotification(FSBaseMission.INGAME_NOTIFICATION_OK, "Chemical element: " .. element)
--         else
--             g_currentMission:addIngameNotification(FSBaseMission.INGAME_NOTIFICATION_ERROR, "No chemical element data for field")
--         end
--     else
--         g_currentMission:addIngameNotification(FSBaseMission.INGAME_NOTIFICATION_ERROR, "You are not on any farmland")
--     end
-- end
