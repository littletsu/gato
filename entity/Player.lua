local AssetManager = require("engine.AssetManager")
local SceneManager = require("engine.SceneManager")
local MainMenu = require("scenes.MainMenu")
local PlayerBullet = require("objects.PlayerBullet")
local Offsets = require("engine.Offsets")
local paths = require("engine.AssetPaths")
local Dialog = require("entity.Dialog")
local inspect = require("utils.inspect")

local Player = {
    catFocusedMode = AssetManager:loadImage(paths.sprites .. "CatFocusedMode.png"),
    catDefault = AssetManager:loadImage(paths.sprites .. "CatFocusedMode.png"),
    catIcon = AssetManager:loadImage(paths.ui .. "CatIcon.png"),
    hitbox = AssetManager:loadImage(paths.sprites .. "Hitbox.png"),

    default_speed = 145,
    focused_speed = 72,

    shoot_cooldown = 10,
    curr_shoot_cooldown = 10,

    default_lives = 9,
    curr_lives = 9,

    default_shield_time = 100,
    curr_shield_time = 0,

    x = 0,
    y = 0,
    
    scale_x = 0.35,
    scale_y = 0.35,
    
    focused_scale_x = 0.3,
    focused_scale_y = 0.3,
    
    hitbox_scale_x = 0.8,
    hitbox_scale_y = 0.8,

    vel_x = 0,
    vel_y = 0,

    speed = 1,

    focused = false,
    
    focusedOffsets = {
        x = 0, 
        y = 0,
    },
    
    defaultOffsets = {
        x = 0,
        y = 0,
    },

    getDrawParams = function(self) 
        return self.focused 
                and 
            {self.x + self.focusedOffsets.x, self.y + self.focusedOffsets.y, 0, self.focused_scale_x, self.focused_scale_y} 
                or 
            {self.x + self.defaultOffsets.x, self.y + self.defaultOffsets.y, 0, self.scale_x, self.scale_y}
    end,
    
    isCollidingWith = function(self, x, y, w) 
        local hitbox_w = self.hitbox:getWidth() * self.hitbox_scale_x
        local dist = (self.x - x)^2 + (self.y - y)^2
        return dist <= ((hitbox_w / 2) + (w/2))^2
    end,

    onEnemyBulletHit = function(self)
        if self.curr_shield_time > 0 then return end 
        self.curr_shield_time = self.default_shield_time
        self.curr_lives = self.curr_lives - 1
        if self.curr_lives <= -1 then
            SceneManager:switch(MainMenu)
        end
        print("hit")
        
    end,
    
    setSpriteOffsets = function(self)
        self.focusedOffsets = {
            x = 0 - (self.catFocusedMode:getWidth() / 2 * self.focused_scale_x),
            y = 0 - (self.catFocusedMode:getHeight() / 2 * self.focused_scale_y),
        }
        self.defaultOffsets = {
            x = 0 - (self.catDefault:getWidth() / 2 * self.scale_x),
            y = 0 - (self.catDefault:getHeight() / 2 * self.scale_y),
        }
    end,
    
    reset = function(self)
        self.x = Offsets.screenCenterX(self.catDefault, self.scale_x)
        self.y = 400
        
        self.curr_lives = self.default_lives
        self.curr_shield_time = 0
    end,
  
    start = function(self) 
        self:setSpriteOffsets()
        self:reset()
    end,

    draw = function(self)
        if (self.curr_shield_time % 3) ~= 2 or Dialog.in_dialog then
            love.graphics.draw(self.catDefault, unpack(self:getDrawParams()))
        end
        
        PlayerBullet:draw()
        love.graphics.draw(self.hitbox, self.x, self.y, 0, self.hitbox_scale_x, self.hitbox_scale_y)
    end,

    update = function(self, dt)
        PlayerBullet:update(dt)

        self.focused = false
        self.speed = self.default_speed

        if self.curr_shoot_cooldown > 0 then
            self.curr_shoot_cooldown = self.curr_shoot_cooldown - 1
        end

        if self.curr_shield_time > 0 then
            self.curr_shield_time = self.curr_shield_time - 1
        end

        if love.keyboard.isDown("lshift") then
            self.focused = true
            self.speed = self.focused_speed
        end

        if love.keyboard.isDown("up") then 
            self.vel_y = self.vel_y - self.speed
        elseif love.keyboard.isDown("down") then
            self.vel_y = self.vel_y + self.speed
        end

        if love.keyboard.isDown("left") then
            self.vel_x = self.vel_x - self.speed
        elseif love.keyboard.isDown("right") then
            self.vel_x = self.vel_x + self.speed
        end

        if love.keyboard.isDown("z") and (self.curr_shoot_cooldown == 0) then
            self.curr_shoot_cooldown = self.shoot_cooldown

            local activeBullet = PlayerBullet:pool()
            activeBullet.x = self.x
            activeBullet.y = self.y
        end
        self.x = self.x + self.vel_x * dt
        self.y = self.y + self.vel_y * dt
        self.vel_x = 0
        self.vel_y = 0
    end,

    ends = function() 
        PlayerBullet:ends()
    end,
}

return Player
