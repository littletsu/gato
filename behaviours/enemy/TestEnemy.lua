local CircleSpread = require("behaviours.bullets.CircleSpread")
local Fall = require("behaviours.bullets.Fall")
local Dialog = require("entity.Dialog")
local AssetManager = require("engine.AssetManager")
local paths = require("engine.AssetPaths")
local EnemyBullet = require("objects.EnemyBullet")

local inspect = require("utils.inspect")
local dialog = AssetManager:loadDialog(paths.dialogs .. "TestEnemy/0.txt")
print(inspect(dialog))

local Hadsdrunfel = AssetManager:loadImage(paths.sprites .. "Hadsdrunfel.png")

local TestEnemy = {
    times = 0,
    bullets = 35,
    right = true,
    
    start = function(self, enemy) 
        self.times = 0
        
        enemy.sprite = Hadsdrunfel
    end,
    
    fire = function(self, enemy)
        EnemyBullet.fire_behavior = CircleSpread
        EnemyBullet:fire(25, 0, 360, ((self.times % 10) * 20)+450)
        EnemyBullet:setOffsets((love.graphics.getWidth()/3)*((self.times%2)+1), (love.graphics.getWidth()/8)*((self.times%2)+1))
        EnemyBullet:fire(25, 0, 360, 500+((self.times%5)*50))
        self.times = self.times + 1
        if self.times == 5 then Dialog:showDialog(dialog) end
        enemy.shoot_cooldown = (self.times % 30)+10
    end,
    
    update = function(self, enemy, dt) 
        if right then
            if not (enemy.x > (love.graphics.getWidth()-enemy.sprite:getWidth())) then 
                enemy.x = enemy.x + enemy.speed * dt
                enemy:setOffsets()
                return
            end
            
            right = false
        else 
            if not (enemy.x <= 0) then 
                enemy.x = enemy.x - enemy.speed * dt
                enemy:setOffsets()
                return
            end
            
            right = true
        end
        
    end
}


return TestEnemy
