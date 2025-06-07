print("atejau iki cia")

SmartAgrometer = {}

function SmartAgrometer:update(dt)
    if not self.loadFinished and g_currentMission ~= nil and g_currentMission.isLoaded then
        self.loadFinished = true
        print("DEBUG: Mission fully loaded - do your XML init here")
        self:loadData()
    end
end

