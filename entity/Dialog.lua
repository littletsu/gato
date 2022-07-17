local AssetManager = require("engine.AssetManager")
local inspect = require("utils.inspect")
local paths = require("engine.AssetPaths")

local Dialog = {
    in_dialog = false,
    name = "DialogName",
    text = "Test dialog",
    font = AssetManager:loadFont(paths.fonts .. "ARCADE_N.TTF"),
    sprite = AssetManager:loadImage(paths.sprites .. "Hadsdrunfel.png"),
    
    skip_cooldown = 30,
    curr_skip_cooldown = 0,
    
    text_speed = 60,
    
    x = 50,
    y = love.graphics.getHeight() / 3 * 2,
    
    name_box_w = 0,
    name_box_h = 0,
    name_padding = 10,
    
    text_box_w = 0,    
    text_box_h = love.graphics.getHeight() / 4,
    
    text_padding = 25,
    
    text_box_offset_y = 25,
    
    sprite_flip = true,
    
    dialogs = {},
    curr_dialog = 1,
    
    characters = {},
    curr_character = "",

    setText = function(self, text, character)
        if self.curr_character ~= character then 
            local character_values = self.characters[character]
            self.sprite = character_values.sprite
            self.name = character_values.name[1]
            self.name_box_w, self.name_box_h = self.font:getWidth(self.name), self.font:getHeight(self.name)
            self.curr_character = character
        end
        self.text_box_w = love.graphics.getWidth() - self.x * 2
        self.text = text
    end,
    
    dialogActions = {
        ["set"] = function(dialog, action)
            print(inspect(action))
            if dialog.characters[action.character] == nil then 
                dialog.characters[action.character] = {}
            end
            
            if action.prop == "sprite" then 
                dialog.characters[action.character][action.prop] = AssetManager:loadImage(paths.sprites .. action.data[1])
                dialog:next()
                return
            end
            dialog.characters[action.character][action.prop] = action.data
            dialog:next()
        end,
        
        ["text"] = function(dialog, action)
            dialog:setText(action.text, action.character)
        end
    },
    
    next = function(self)
        local dialog = self.dialogs[self.curr_dialog]
        if not dialog then 
            self.in_dialog = false
            return
        end
        self.curr_dialog = self.curr_dialog + 1
        self.dialogActions[dialog.type](self, dialog)
    end,

    showDialog = function(self, dialogs) 
        self.in_dialog = true
        self.dialogs = dialogs
        self.curr_dialog = 1
        self:next()
    end,
    
    update = function(self)
        if self.curr_skip_cooldown > 0 then
            self.curr_skip_cooldown = self.curr_skip_cooldown - 1
            return
        end
        
        if love.keyboard.isDown("z") then 
            self.curr_skip_cooldown = self.skip_cooldown
            self:next()
        end
    end,
    
    draw = function(self)
        local text_box_y = self.y + self.name_box_h + self.text_box_offset_y
        local sprite_w, sprite_h = self.sprite:getDimensions()
        
        love.graphics.draw(self.sprite, self.text_box_w - self.x * 2, self.y - sprite_h + self.name_box_h + self.name_padding * 2, 0, self.sprite_flip and -1 or 1, 1, sprite_w, 0)
        
        love.graphics.setColor(0, 0, 0, 0.6)
        
        love.graphics.rectangle("fill", self.x, self.y, self.name_box_w + self.name_padding * 2, self.name_box_h + self.name_padding * 2)
        love.graphics.rectangle("fill", self.x, text_box_y, self.text_box_w, self.text_box_h)

        love.graphics.setColor(1, 1, 1)

        love.graphics.print(self.name, self.font, self.x + self.name_padding, self.y + self.name_padding)
        love.graphics.print(self.text, self.font, self.x + self.text_padding, text_box_y + self.text_padding)
        
    end,
}

return Dialog

