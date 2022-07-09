local AssetManager = require("engine.AssetManager")
local Offsets = require("engine.Offsets")
local paths = require("engine.AssetPaths")

local Enemy = {
    sprite = AssetManager:loadImage(paths.sprites .. "HappyCat.png"),
    
    x = 0,
    y = 0,

    start = function(self)
        self.x = Offsets.screenCenterX(self.sprite)
    end,
    
    draw = function(self) 
        love.graphics.draw(self.sprite, self.x, self.y)
    end,
}

return Enemy