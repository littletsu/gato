local inspect = require("utils.inspect")
local AssetManager = require("engine.AssetManager")
local paths = require("engine.AssetPaths")
local Player = require("entity.Player")
local Enemy = require("entity.Enemy")

return {
    font = AssetManager:loadFont(paths.fonts .. "ARCADE_N.TTF"),
    draw = function()
        --print("draw test")
        Enemy:draw()
        Player:draw()
    end,
    start = function(self) 
        print(inspect(AssetManager))
        Player:start()
        Enemy:start()
        --love.graphics.setColor(0, 255, 0)
        love.graphics.setFont(self.font)
    end,
    ends = function() 
        Player:ends()
        Enemy:ends()
    end,
    update = function(self, dt)
        Player:update(dt)
        Enemy:update(dt)
    end
}