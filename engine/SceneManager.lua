local SM = {
    current = nil,
    switch = function(self, newS)
        if self.current ~= nil then
            self.current:ends()
        end
        self.current = newS
        newS:start()
        
    end,
    draw = function(self)
        if self.current ~= nil then
            self.current:draw()
        end
    end,
    update = function(self, dt)
        if self.current ~= nil then
            self.current:update(dt)
        end
    end,
}

return SM