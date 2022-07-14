local AssetManager = require("engine.AssetManager")
local Offsets = require("engine.Offsets")
local EnemyBullet = require("objects.EnemyBullet")
local paths = require("engine.AssetPaths")

local TestEnemy = require("behaviours.enemy.TestEnemy")

local Enemy = {
    sprite = AssetManager:loadImage(paths.sprites .. "HappyCat.png"),
    fire_fx = AssetManager:loadAudio(paths.fx .. "EnemyFire.mp3", "static"),
    behavior = TestEnemy,
    
    default_shoot_cooldown = 50,
    shoot_cooldown = 50,
    curr_shoot_cooldown = 0,

    x = 0,
    y = 0,

    scale_x = 1,
    scale_y = 1,

    setOffsets = function(self) 
        EnemyBullet.bulletOffsets = Offsets.middle(self.sprite, self.scale_x, self.scale_y) -- todo: add x and y parameter to middle
        EnemyBullet.bulletOffsets.x = EnemyBullet.bulletOffsets.x + self.x
    end,

    start = function(self)
        self.x = Offsets.screenCenterX(self.sprite, self.scale_x)
        self:setOffsets()
        self.shoot_cooldown = self.default_shoot_cooldown
        self.behavior:reset()
    end,
    
    draw = function(self) 
        love.graphics.draw(self.sprite, self.x, self.y, 0, self.scale_x, self.scale_y)
        EnemyBullet.pool:draw()
    end,

    update = function(self, dt)
        EnemyBullet.pool:update(dt)

        if self.curr_shoot_cooldown > 0 then
            self.curr_shoot_cooldown = self.curr_shoot_cooldown - 1
        end
        if self.curr_shoot_cooldown == 0 then
            self.curr_shoot_cooldown = self.shoot_cooldown
            self.fire_fx:stop()
            self.fire_fx:play()
            self.behavior:fire(self)
        end
        self.behavior:update(self, dt)
    end,

    ends = function(self)
        EnemyBullet.pool:ends()
    end

}

return Enemy
