print("DEBUG: SmartAgrometerHandTool class loaded")

SmartAgrometerHandTool = {}
local SmartAgrometerHandTool_mt = Class(SmartAgrometerHandTool, HandTool)
InitObjectClass(SmartAgrometerHandTool, "SmartAgrometerHandTool")

if allowInput and g_inputBinding:getDigitalInputJustPressed(InputAction.SMARTAGROMETER_SCAN) then
    print("DEBUG: Left click detected!")
    self:scanFieldUnderPlayer()
end

function SmartAgrometerHandTool:new(isServer, isClient)
    print("DEBUG: SmartAgrometerHandTool:new() called")
    local self = HandTool:new(isServer, isClient)
    setmetatable(self, SmartAgrometerHandTool_mt)
    return self
end

function SmartAgrometerHandTool:onEquip()
    print("DEBUG: SmartAgrometerHandTool equipped!")
end

function SmartAgrometerHandTool:update(dt, allowInput)
    SmartAgrometerHandTool:superClass().update(self, dt, allowInput)
    print("DEBUG: SmartAgrometerHandTool:update")

    if allowInput and g_inputBinding:getDigitalInputJustPressed(InputAction.SMARTAGROMETER_SCAN) then
        print("DEBUG: Scan input triggered!")
        self:scanFieldUnderPlayer()
    end
end

function SmartAgrometerHandTool:scanFieldUnderPlayer()
    print("DEBUG: Scanning field!")
    g_currentMission:addIngameNotification(FSBaseMission.INGAME_NOTIFICATION_OK, "Scan complete!")
end