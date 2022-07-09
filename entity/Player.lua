local AssetManager = require("engine.AssetManager")
local paths = require("engine.AssetPaths")
local inspect = require("utils.inspect")

local Player = {
    catFocusedMode = AssetManager:loadImage(paths.sprites .. "CatFocusedMode.png"),
    catDefault = AssetManager:loadImage(paths.sprites .. "CatUnfocused.png"),

    x = 0,
    y = 0,

    draw = function(self)
        love.graphics.draw(self.catDefault, self.x, self.y, 0, 0.3, 0.3)
    end,
    start = function() end,
    ends = function() end,
    update = function(self)
        
    end,

    keyActions = {
        ["s"] = function(player) 
            player.y = player.y + 1
        end,
        ["w"] = function(player) 
            player.y = player.y - 1
        end,
        ["d"] = function(player) 
            player.x = player.x + 1
        end,
        ["a"] = function(player) 
            player.x = player.x - 1
        end,
    },
    keypressed = function(self, key, scancode, isrepeat) 
        if self.keyActions[scancode] ~= nil then
            self.keyActions[scancode](self)
        end
    end
}

return Player