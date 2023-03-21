local AssetManager = require("engine.AssetManager")
local Player = require("entity.Player")
local Dialog = require("entity.Dialog")
local inspect = require("utils.inspect")
local paths = require("engine.AssetPaths")

local UI = {
    status_x = 5,
    status_y = 0,

    catIcon = AssetManager:loadImage(paths.ui .. "CatIcon.png"),
    catIcon_offset_x = 0,
    
    catIcon_scale_x = 0.5,
    catIcon_scale_y = 0.5,

    setUIOffsets = function(self) 
        local catIcon_h = self.catIcon:getWidth() * self.catIcon_scale_x
        
        self.status_y = love.graphics.getHeight() - catIcon_h - 5
        
        self.catIcon_offset_x = catIcon_h + 5
    end,

    start = function(self) 
        self:setUIOffsets()
    end,
    
    update = function(self)

    end,
    
    draw = function(self)
        if not Dialog.in_dialog then 
            for i = 0, Player.curr_lives, 1 do 
                love.graphics.draw(self.catIcon, self.status_x + (i * self.catIcon_offset_x), self.status_y, 0, self.catIcon_scale_x, self.catIcon_scale_y)
            end
        end
    end,
}

return UI

