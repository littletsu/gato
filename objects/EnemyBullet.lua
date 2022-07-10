-- position translate code from https://love2d.org/forums/viewtopic.php?p=207514#p207514

local AssetManager = require("engine.AssetManager")
local ObjectPool = require("engine.ObjectPool")
local FallBehaviour = require("behaviours.bullets.Fall")

local paths = require("engine.AssetPaths")

local bullet = AssetManager:loadImage(paths.sprites .. "Bullet.png")


local newEnemyBullet = function(initiate_active)
    return {
        active = initiate_active,

        speed = 4,

        target_x = 0, target_y = 0, x = 0, y = 0, vx = 0, vy = 0, old_x = 0, old_y = 0, dist = 0,
        moving = false,

        yLimit = love.graphics.getHeight(),

        draw = function(self)
            love.graphics.draw(bullet, self.x, self.y)
        end,

        translate = function(self, x, y) 
            self.old_x = self.x
            self.old_y = self.y
            self.target_x = x or self.x
            self.target_y = y or self.y
            self.dist = (self.target_x - self.x) ^ 2 + (self.target_y - self.y) ^ 2

            if self.dist == 0 then
                self.vx = 0
                self.vy = 0
                self.moving = false
                return
            end

            local dist2 = math.sqrt(self.dist)
            self.vx = (self.target_x - self.x) / dist2 * self.speed
            self.vy = (self.target_y - self.y) / dist2 * self.speed
            
            self.moving = true
        end,

        update = function(self)
            
            if self.moving then
                self.x = self.x + self.vx
                self.y = self.y + self.vy

                local moved_dist = (self.old_x - self.x) ^ 2 + (self.old_y - self.y) ^ 2

                if moved_dist >= self.dist then
                    self.x = self.target_x
                    self.y = self.target_y
                    self.vx = 0
                    self.vy = 0
                    self.moving = false
                    self.active = false
                end
            end
        end,
    }
end  

local EnemyBulletPool = ObjectPool.new(newEnemyBullet)

EnemyBulletPool:fill(20)

local EnemyBulletManager = {
    pool = EnemyBulletPool,
    fire_behavior = FallBehaviour,
    bulletOffsets = { x = 0, y = 0 },
    fire = function(self, count) 
        local bullets = {}
        for i = 0, count, 1 do
            bullets[i] = self.pool:pool(self.bulletOffsets.x, self.bulletOffsets.y)
        end
        self.fire_behavior(bullets, count)
    end
}

return EnemyBulletManager