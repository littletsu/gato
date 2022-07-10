local AssetManager = require("engine.AssetManager")
local SceneManager = require("engine.SceneManager")
local MainMenu = require("scenes.MainMenu")
local PlayerBullet = require("objects.PlayerBullet")
local Offsets = require("engine.Offsets")
local paths = require("engine.AssetPaths")
local inspect = require("utils.inspect")

local Player = {
    catFocusedMode = AssetManager:loadImage(paths.sprites .. "CatFocusedMode.png"),
    catDefault = AssetManager:loadImage(paths.sprites .. "CatUnfocused.png"),

    default_speed = 120,
    focused_speed = 72,

    shoot_cooldown = 10,
    curr_shoot_cooldown = 0,

    default_lives = 5,
    curr_lives = 5,

    default_shield_time = 15,
    curr_shield_time = 0,

    x = 0,
    y = 0,

    scale_x = 0.3,
    scale_y = 0.3,

    vel_x = 0,
    vel_y = 0,

    speed = 1,

    focused = false,

    bulletOffsets = {
        default = {
            x = 0,
            y = 0
        },
        focused = {
            x = 0,
            y = 0
        }
    },

    getSprite = function(self) 
        return self.focused and self.catFocusedMode or self.catDefault
    end,

    isCollidingWith = function(self, x, y, w, h) 
        local self_w = self:getSprite():getWidth() * self.scale_x
        return self.x < x+w 
            and x < self.x + self_w 
            and self.y < y+h 
            and self.y < y+h
    end,

    onEnemyBulletHit = function(self)
        if self.curr_shield_time > 0 then return end 
        self.curr_shield_time = self.default_shield_time
        self.curr_lives = self.curr_lives - 1
        if self.curr_lives <= 0 then
            SceneManager:switch(MainMenu)
        end
        print("hit")
        
    end,

    setBulletOffsets = function(self)
        self.bulletOffsets.default = Offsets.middle(self.catDefault, self.scale_x, self.scale_y)
        self.bulletOffsets.focused = Offsets.middle(self.catFocusedMode, self.scale_x, self.scale_y)
    end,
    
    start = function(self) 
        self:setBulletOffsets()
        self.x = Offsets.screenCenterX(self.catDefault, self.scale_x)
        self.y = 400
        self.curr_lives = self.default_lives
        self.curr_shield_time = 0
    end,

    draw = function(self)
        if ((self.curr_shield_time % 3) == 2) then return end
        love.graphics.draw(self:getSprite(), self.x, self.y, 0, self.scale_x, self.scale_y)
        PlayerBullet:draw()
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
            local curr_offset = self.focused and self.bulletOffsets.focused or self.bulletOffsets.default
            local activeBullet = PlayerBullet:pool()
            activeBullet.x = self.x + curr_offset.x
            activeBullet.y = self.y + curr_offset.y
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