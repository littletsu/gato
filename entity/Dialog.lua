local AssetManager = require("engine.AssetManager")
local paths = require("engine.AssetPaths")

local Dialog = {
    in_dialog = false,
    name = "DialogName",
    text = "Test dialog",
    font = AssetManager:loadFont(paths.fonts .. "ARCADE_N.TTF"),
    sprite = AssetManager:loadImage(paths.sprites .. "Hadsdrunfel.png"),
    text_speed = 60,
    
    x = 50,
    y = love.graphics.getHeight() / 3 * 2,
    
    name_box_w = 0,
    name_box_h = 0,
    
    text_box_w = 0,
    text_box_h = 0,
    
    text_box_offset_y = 30,

    setText = function(self, text, dialogName) 
        self.text = text
        self.name = dialogName or self.name

        self.name_box_w, self.name_box_h = self.font:getWidth(self.name), self.font:getHeight(self.name)
     
        self.text_box_w, self.text_box_h = love.graphics.getWidth() - self.x, love.graphics.getHeight() - self.y
    end,

    show = function(self) 
        self.in_dialog = true
        self:setText("my text", "dialogName")
    end,
    
    update = function(self)
    
    end,
    
    draw = function(self)
        local text_box_y = self.y+self.name_box_h+self.text_box_offset_y
        love.graphics.setColor(0, 0, 0)
        love.graphics.rectangle("fill", self.x, self.y, self.name_box_w, self.name_box_h)
        love.graphics.rectangle("fill", self.x, text_box_y, self.text_box_w, self.text_box_h)

        love.graphics.setColor(1, 1, 1)

        love.graphics.print(self.name, self.font, self.x, self.y)

        love.graphics.print(self.text, self.font, self.x, text_box_y) -- use different y for different text offset (rectangle no offset, text offset)
    end,
}

return Dialog

