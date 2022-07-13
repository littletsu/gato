local TableUtils = require("utils.table")
local inspect = require("utils.inspect")
local Translatable = require("engine.Translatable")
local AssetManager = require("engine.AssetManager")
local ObjectPool = require("engine.ObjectPool")
local Player = require("entity.Player")
local FallBehaviour = require("behaviours.bullets.Fall")
local CircleSpreadBehaviour = require("behaviours.bullets.CircleSpread")

local paths = require("engine.AssetPaths")

local bullet = AssetManager:loadImage(paths.sprites .. "EnemyBullet.png")
local bullet_w, bullet_h = bullet:getDimensions()

local newEnemyBullet = function(initiate_active)
    return TableUtils.mergeTable({
        active = initiate_active,
        x = 0, 
        y = 0,
        translatable_setInactive = true,
        speed = 240,
        
        r = 1,
        g = 0.17,
        b = 0.21,

        translatable_update = function(self, dt) 
            if Player:isCollidingWith(self.x, self.y, bullet_w) then
                self.active = false
                Player:onEnemyBulletHit()
            end
        end,
    }, Translatable)
end  

local createSpriteBatch = function() 
    return love.graphics.newSpriteBatch(bullet), love.graphics.newQuad(0, 0, bullet_w, bullet_h, bullet_w, bullet_h)
end

local EnemyBulletPool = ObjectPool.new(newEnemyBullet, createSpriteBatch)

EnemyBulletPool:fill(70)

local EnemyBulletManager = {
    pool = EnemyBulletPool,
    fire_behavior = CircleSpreadBehaviour,
    bulletOffsets = { x = 0, y = 0 },
    fire = function(self, count, ...) 
        local bullets = {}
        for i = 0, count, 1 do
            bullets[i] = self.pool:pool(self.bulletOffsets.x, self.bulletOffsets.y)
        end
        self.fire_behavior(bullets, count, ...)
    end,
    setOffsets = function(self, x, y) 
        self.bulletOffsets.x = x
        self.bulletOffsets.y = y
    end
}

return EnemyBulletManager
