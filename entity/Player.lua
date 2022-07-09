local AssetManager = require("engine.AssetManager")
local PlayerBullet = require("objects.PlayerBullet")
local Offsets = require("engine.Offsets")
local paths = require("engine.AssetPaths")
local inspect = require("utils.inspect")

local Player = {
    catFocusedMode = AssetManager:loadImage(paths.sprites .. "CatFocusedMode.png"),
    catDefault = AssetManager:loadImage(paths.sprites .. "CatUnfocused.png"),

    default_speed = 1,
    focused_speed = 0.6,

    shoot_cooldown = 10,
    curr_shoot_cooldown = 0,

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

    setBulletOffsets = function(self)
        self.bulletOffsets.default = Offsets.middle(self.catDefault, self.scale_x, self.scale_y)
        self.bulletOffsets.focused = Offsets.middle(self.catFocusedMode, self.scale_x, self.scale_y)
    end,
    
    start = function(self) 
        self:setBulletOffsets()
        self.x = Offsets.screenCenterX(self.catDefault, self.scale_x)
        self.y = 400
    end,

    draw = function(self)
        love.graphics.draw(self.focused and self.catFocusedMode or self.catDefault, self.x, self.y, 0, self.scale_x, self.scale_y)
        PlayerBullet:draw()
    end,

    update = function(self)
        PlayerBullet:update()

        self.focused = false
        self.speed = self.default_speed

        if self.curr_shoot_cooldown > 0 then
            self.curr_shoot_cooldown = self.curr_shoot_cooldown - 1
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

        self.x = self.x + self.vel_x
        self.y = self.y + self.vel_y
        self.vel_x = 0
        self.vel_y = 0
    end,

    ends = function() 
        PlayerBullet:ends()
    end,
}

return Player