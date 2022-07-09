local AssetManager = require("engine.AssetManager")
local Offsets = require("engine.Offsets")
local EnemyBullet = require("objects.EnemyBullet")
local paths = require("engine.AssetPaths")

local Enemy = {
    sprite = AssetManager:loadImage(paths.sprites .. "HappyCat.png"),
    
    shoot_cooldown = 50,
    curr_shoot_cooldown = 0,

    x = 0,
    y = 0,

    scale_x = 1,
    scale_y = 1,
    
    bulletOffsets = {
        x = 0,
        y = 0,
    },

    setOffsets = function(self)
        self.x = Offsets.screenCenterX(self.sprite, self.scale_x)
        self.bulletOffsets = Offsets.middle(self.sprite, self.scale_x, self.scale_y)
    end,

    start = function(self)
        self:setOffsets()
    end,
    
    draw = function(self) 
        love.graphics.draw(self.sprite, self.x, self.y, 0, self.scale_x, self.scale_y)
        EnemyBullet:draw()
    end,

    update = function(self)
        EnemyBullet:update()

        if self.curr_shoot_cooldown > 0 then
            self.curr_shoot_cooldown = self.curr_shoot_cooldown - 1
        end
        if self.curr_shoot_cooldown == 0 then
            self.curr_shoot_cooldown = self.shoot_cooldown
            local activeBullet = EnemyBullet:pool()
            activeBullet.x = self.x + self.bulletOffsets.x
            activeBullet.y = self.y + self.bulletOffsets.y
        end
    end,

    ends = function(self)
        EnemyBullet:ends()
    end

}

return Enemy