local CircleSpread = require("behaviours.bullets.CircleSpread")
local Fall = require("behaviours.bullets.Fall")
local EnemyBullet = require("objects.EnemyBullet")

local TestEnemy = {
    times = 0,
    bullets = 35,
    right = true,

    fire = function(self) 
        EnemyBullet.fire_behavior = self.times % 3 == 2 and Fall or CircleSpread
        EnemyBullet:fire(self.times % 3 == 2 and 5 or self.bullets)
        self.times = self.times + 1
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
