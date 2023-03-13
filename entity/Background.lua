local AssetManager = require("engine.AssetManager")
local paths = require("engine.AssetPaths")

local Background = {
    current_background = AssetManager:loadImage(paths.backgrounds .. "bg1.png"),
    
    draw = function(self) 
        love.graphics.draw(self.current_background)
    end
}

return Background

