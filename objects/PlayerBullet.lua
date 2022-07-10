local AssetManager = require("engine.AssetManager")
local ObjectPool = require("engine.ObjectPool")
local paths = require("engine.AssetPaths")

local bullet = AssetManager:loadImage(paths.sprites .. "Bullet.png")

local newPlayerBullet = function(initiate_active)
    return {
        active = initiate_active,

        speed = 4,

        x = 0,
        y = 0,

        yLimit = -1,

        draw = function(self)
            love.graphics.draw(bullet, self.x, self.y)
        end,

        update = function(self)
            self.y = self.y - self.speed

            if self.y < self.yLimit then
                self.active = false
            end
        end
    }
end  

local PlayerBulletPool = ObjectPool.new(newPlayerBullet)

PlayerBulletPool:fill(35)

return PlayerBulletPool