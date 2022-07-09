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
    update = function(self)
        if self.current ~= nil then
            self.current:update()
        end
    end,

    keypressed = function(self, key, scancode, isrepeat)
        if self.current ~= nil then
            self.current:keypressed(key, scancode, isrepeat)
        end
    end
}

return SM