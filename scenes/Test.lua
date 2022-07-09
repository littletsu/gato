local inspect = require("utils.inspect")
local AssetManager = require("engine.AssetManager")
local paths = require("engine.AssetPaths")
local Player = require("entity.Player")

return {
    font = AssetManager:loadFont(paths.fonts .. "ARCADE_N.TTF"),
    draw = function()
        --print("draw test")
        
        Player:draw()
    end,
    start = function(self) 
        print(inspect(AssetManager))
        Player:start()
        love.graphics.setColor(0, 255, 0)
        love.graphics.setFont(self.font)
    end,
    ends = function() 
        Player:ends()
    end,
    update = function()
        Player:update()
    end
}