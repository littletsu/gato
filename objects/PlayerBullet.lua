local AssetManager = require("engine.AssetManager")
local ObjectPool = require("engine.ObjectPool")
local paths = require("engine.AssetPaths")

local bullet = AssetManager:loadImage(paths.sprites .. "Bullet.png")
local bullet_w, bullet_h = bullet:getDimensions()

local newPlayerBullet = function(initiate_active)
    return {
        active = initiate_active,

        speed = 240,

        x = 0,
        y = 0,

        yLimit = -1,

        draw = function(self)
            love.graphics.draw(bullet, self.x, self.y)
        end,

        update = function(self, dt)
            self.y = self.y - self.speed * dt

            if self.y < self.yLimit then
                self.active = false
            end
        end
    }
end  

local createSpriteBatch = function() 
    return love.graphics.newSpriteBatch(bullet), love.graphics.newQuad(0, 0, bullet_w, bullet_h, bullet_w, bullet_h)
end

local PlayerBulletPool = ObjectPool.new(newPlayerBullet, createSpriteBatch)

PlayerBulletPool:fill(35)

return PlayerBulletPool
