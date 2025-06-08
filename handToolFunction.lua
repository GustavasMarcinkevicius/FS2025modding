print("DEBUG: SmartAgrometerHandTool class loaded")
print("DEBUG: InputAction.SMARTAGROMETER_SCAN =", InputAction.SMARTAGROMETER_SCAN)

SmartAgrometerHandTool = {}
local SmartAgrometerHandTool_mt = Class(SmartAgrometerHandTool, Flashlight)
InitObjectClass(SmartAgrometerHandTool, "SmartAgrometerHandTool")

function SmartAgrometerHandTool:update(dt, allowInput)
    SmartAgrometerHandTool:superClass().update(self, dt, allowInput)

    if InputAction.SMARTAGROMETER_SCAN == nil then
        print("DEBUG: InputAction.SMARTAGROMETER_SCAN is nil during update")
    end

    if allowInput and g_inputBinding:getDigitalInputJustPressed(InputAction.SMARTAGROMETER_SCAN) then
        print("DEBUG: SMARTAGROMETER_SCAN triggered")
        self:scanFieldUnderPlayer()
    end
end
