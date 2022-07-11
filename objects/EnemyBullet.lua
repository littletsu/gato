local TableUtils = require("utils.table")
local inspect = require("utils.inspect")
local Translatable = require("engine.Translatable")
local AssetManager = require("engine.AssetManager")
local ObjectPool = require("engine.ObjectPool")
local Player = require("entity.Player")
local FallBehaviour = require("behaviours.bullets.Fall")
local CircleSpreadBehaviour = require("behaviours.bullets.CircleSpread")

local paths = require("engine.AssetPaths")

local bullet = AssetManager:loadImage(paths.sprites .. "Bullet.png")
local bullet_w = bullet:getWidth()

local newEnemyBullet = function(initiate_active)
    return TableUtils.mergeTable({
        active = initiate_active,
        x = 0, 
        y = 0,
        translatable_setInactive = true,
        speed = 240,

        draw = function(self)
            love.graphics.draw(bullet, self.x, self.y)
        end,

        translatable_update = function(self) 
            if Player:isCollidingWith(self.x, self.y, bullet_w) then
                self.active = false
                Player:onEnemyBulletHit()
            end
        end,
    }, Translatable)
end  

local EnemyBulletPool = ObjectPool.new(newEnemyBullet)

EnemyBulletPool:fill(70)

local EnemyBulletManager = {
    pool = EnemyBulletPool,
    fire_behavior = CircleSpreadBehaviour,
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
