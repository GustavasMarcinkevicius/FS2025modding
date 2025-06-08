print("DEBUG: SmartAgrometerHandTool class loaded")

SmartAgrometerHandTool = {}
local SmartAgrometerHandTool_mt = Class(SmartAgrometerHandTool, Flashlight)
InitObjectClass(SmartAgrometerHandTool, "SmartAgrometerHandTool")

function SmartAgrometerHandTool:new(isServer, isClient)
    local self = Flashlight:new(isServer, isClient)
    setmetatable(self, SmartAgrometerHandTool_mt)
    return self
end

function SmartAgrometerHandTool:update(dt, allowInput)
    SmartAgrometerHandTool:superClass().update(self, dt, allowInput)

    -- Check if InputAction is available yet
    if InputAction == nil then
        print("DEBUG: InputAction is nil during update")
        return
    end

    -- Check if your custom input action exists
    if InputAction.SMARTAGROMETER_SCAN == nil then
        print("DEBUG: InputAction.SMARTAGROMETER_SCAN is nil during update")
        return
    end

    -- Check input and trigger scan
    if allowInput and g_inputBinding:getDigitalInputJustPressed(InputAction.SMARTAGROMETER_SCAN) then
        print("DEBUG: SMARTAGROMETER_SCAN triggered")
        self:scanFieldUnderPlayer()
    end
end
