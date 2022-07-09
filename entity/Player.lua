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

    draw = function(self)
        love.graphics.draw(self.catDefault, self.x, self.y, 0, 0.3, 0.3)
    end,
    start = function() end,
    ends = function() end,
    update = function(self)
        -- looping through keyActions would probably be more expensive so this is what we're left with ;-;
        if love.keyboard.isDown("w") then 
            self.vel_y = self.vel_y - self.speed
        elseif love.keyboard.isDown("s") then
            self.vel_y = self.vel_y + self.speed
        end
        if love.keyboard.isDown("a") then
            self.vel_x = self.vel_x - self.speed
        elseif love.keyboard.isDown("d") then
            self.vel_x = self.vel_x + self.speed
        end
        self.x = self.x + self.vel_x
        self.y = self.y + self.vel_y
        self.vel_x = 0
        self.vel_y = 0
    end,

    
}

return Player