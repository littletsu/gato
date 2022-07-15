local inspect = require("utils.inspect")

local AssetManager = require("engine.AssetManager")
local paths = require("engine.AssetPaths")

local Dialog = require("entity.Dialog")
local Background = require("entity.Background")
local Player = require("entity.Player")
local Enemy = require("entity.Enemy")

return {
    font = AssetManager:loadFont(paths.fonts .. "ARCADE_N.TTF"),
    draw = function()
        --print("draw test")
        Background:draw()
        Enemy:draw()
        Player:draw()
        if Dialog.in_dialog then 
            Dialog:draw()
        end
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
        if Dialog.in_dialog then 
            Dialog:update(dt)
            return
        end
        Player:update(dt)
        Enemy:update(dt)
    end
}
