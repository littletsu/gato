-- position translate code from https://love2d.org/forums/viewtopic.php?p=207514#p207514

local Translatable = {
    target_x = 0, target_y = 0, vx = 0, vy = 0, old_x = 0, old_y = 0, dist = 0,
    moving = false,

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

    update = function(self, dt)
        if self.moving then
            self.x = self.x + self.vx * dt
            self.y = self.y + self.vy * dt

            local moved_dist = (self.old_x - self.x) ^ 2 + (self.old_y - self.y) ^ 2

            if moved_dist >= self.dist then
                self.x = self.target_x
                self.y = self.target_y
                self.vx = 0
                self.vy = 0
                self.moving = false
                if self.translatable_setInactive then self.active = false end
            end
        end
        if self.translatable_update then self:translatable_update(dt) end
    end,
}

return Translatable
