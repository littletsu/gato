local CircleSpread = require("behaviours.bullets.CircleSpread")
local Fall = require("behaviours.bullets.Fall")

local EnemyBullet = require("objects.EnemyBullet")

local TestEnemy = {
    times = 0,
    bullets = 35,
    right = true,

    fire = function(self, enemy) 
        EnemyBullet.fire_behavior = CircleSpread
        EnemyBullet:fire(35, 0, 360, ((self.times % 10) * 20)+50)
        self.times = self.times + 1
        enemy.shoot_cooldown = (self.times % 10) * 5
    end,
    
    update = function(self, enemy, dt) 
        if right then
            if not (enemy.x > (love.graphics.getWidth()-enemy.sprite:getWidth())) then 
                enemy.x = enemy.x + 1
                enemy:setOffsets()
                return
            end
            
            right = false
        else 
            if not (enemy.x <= 0) then 
                enemy.x = enemy.x - 1
                enemy:setOffsets()
                return
            end
            
            right = true
        end
        
    end
}


return TestEnemy
