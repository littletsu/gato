local AssetManager = require("engine.AssetManager")
local ObjectPool = require("engine.ObjectPool")
local paths = require("engine.AssetPaths")

local newEnemyBullet = function(initiate_active)
    return {
        bullet = AssetManager:loadImage(paths.sprites .. "Bullet.png"),
        active = initiate_active,

        speed = 4,

        x = 0,
        y = 0,

        yLimit = love.graphics.getHeight(),

        draw = function(self)
            love.graphics.draw(self.bullet, self.x, self.y)
        end,

        update = function(self)
            self.y = self.y + self.speed

            if self.y > self.yLimit then
                self.active = false
            end
        end
    }
end  

local EnemyBulletPool = ObjectPool.new(newEnemyBullet)

EnemyBulletPool:fill(20)

return EnemyBulletPool