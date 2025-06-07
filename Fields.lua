print("My mod script loaded GUSTAVAS1 fields!")

SaveTest = {}

-- function SaveTest:loadMap(name)
--     print("DEBUG SaveTest: Map loaded")
-- end

function SaveTest:saveToSavegameXMLFile(xmlFile, key)
    print("DEBUG SaveTest: Game is saving now!")
    setXMLString(xmlFile, key .. "#myMessage", "Hello Savegame!")
    setXMLInt(xmlFile, key .. "#myNumber", 123)
end

function SaveTest:loadFromSavegameXMLFile(xmlFile, key)
    local msg = getXMLString(xmlFile, key .. "#myMessage")
    local num = getXMLInt(xmlFile, key .. "#myNumber")
    print("DEBUG SaveTest: Loaded message =", msg or "nil")
    print("DEBUG SaveTest: Loaded number =", num or "nil")
end

addModEventListener(SaveTest)
