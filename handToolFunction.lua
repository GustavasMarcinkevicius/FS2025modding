-- HandToolFunction = {}
-- local HandToolFunction_mt = Class(HandToolFunction, PlayerHandTool)

-- function HandToolFunction.new(isServer, isClient, customMt)
--     local self = PlayerHandTool.new(isServer, isClient, customMt or HandToolFunction_mt)
--     return self
-- end

-- function HandToolFunction:load(xmlFilename, player, superFunc)
--     local result = superFunc(self, xmlFilename, player)
--     -- Your custom behavior setup here
--     return result
-- end

-- function HandToolFunction:update(dt, allowInput)
--     -- Called every frame while the tool is equipped
--     -- Add logic here: spray something, play sounds, interact with world, etc.
-- end