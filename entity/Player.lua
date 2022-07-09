local AssetManager = require("engine.AssetManager")
local paths = require("engine.AssetPaths")
local inspect = require("utils.inspect")

local Player = {
    catFocusedMode = AssetManager:loadImage(paths.sprites .. "CatFocusedMode.png"),
    catDefault = AssetManager:loadImage(paths.sprites .. "CatUnfocused.png"),

    x = 0,
    y = 0,
    vel_x = 0,
    vel_y = 0,
    speed = 1,
    

    keyActions = {
        ["w"] = function(player) 
            player.vel_y = player.vel_y - player.speed
        end,
        ["s"] = function(player) 
            player.vel_y = player.vel_y + player.speed
        end,
        ["a"] = function(player) 
            player.vel_x = player.vel_x - player.speed
        end,
        ["d"] = function(player) 
            player.vel_x = player.vel_x + player.speed
        end,
    },

    draw = function(self)
        love.graphics.draw(self.catDefault, self.x, self.y, 0, 0.3, 0.3)
    end,
    start = function() end,
    ends = function() end,
    update = function(self)
        -- looping through keyActions would probably be more expensive so this is what we're left with ;-;
        if love.keyboard.isDown("w") then 
            self.keyActions["w"](self)
        end
        if love.keyboard.isDown("s") then
            self.keyActions["s"](self)
        end
        if love.keyboard.isDown("a") then
            self.keyActions["a"](self)
        end
        if love.keyboard.isDown("d") then
            self.keyActions["d"](self)
        end
        self.x = self.x + self.vel_x
        self.y = self.y + self.vel_y
        self.vel_x = 0
        self.vel_y = 0
    end,

    
}

return Player