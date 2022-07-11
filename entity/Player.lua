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
    hitbox = AssetManager:loadImage(paths.sprites .. "Bullet.png"),

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
    
    hitbox_scale_x = 0.8,
    hitbox_scale_y = 0.8,

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
    
    hitboxOffsets = {
        x = 0,
        y = 0
    },

    getSprite = function(self) 
        return self.focused and self.catFocusedMode or self.catDefault
    end,
    
    getHitboxPosition = function(self) 
        return self.x + self.hitboxOffsets.x, self.y + self.hitboxOffsets.y
    end,

    isCollidingWith = function(self, x, y, w) 
        local hitbox_w = self.hitbox:getWidth() * self.hitbox_scale_x
        local hitbox_x, hitbox_y = self:getHitboxPosition()
        local dist = (hitbox_x - x)^2 + (hitbox_y - y)^2
        return dist <= ((hitbox_w / 2) + (w/2))^2
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

    setOffsets = function(self)
        self.bulletOffsets.default = Offsets.middle(self.catDefault, self.scale_x, self.scale_y)
        self.bulletOffsets.focused = Offsets.middle(self.catFocusedMode, self.scale_x, self.scale_y)
        self.hitboxOffsets = self.bulletOffsets.focused
    end,
    
    start = function(self) 
        self:setOffsets()
        self.x = Offsets.screenCenterX(self.catDefault, self.scale_x)
        self.y = 400
        self.curr_lives = self.default_lives
        self.curr_shield_time = 0
    end,

    draw = function(self)
        if (self.curr_shield_time % 3) ~= 2 then
            love.graphics.draw(self:getSprite(), self.x, self.y, 0, self.scale_x, self.scale_y)
        end
        
        local hitbox_x, hitbox_y = self:getHitboxPosition()
        love.graphics.draw(self.hitbox, hitbox_x, hitbox_y, 0, self.hitbox_scale_x, self.hitbox_scale_y)
        
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
