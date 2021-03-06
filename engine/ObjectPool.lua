local ObjectPool = {
    new = function(instantiate_new, create_sprite_batch)
        local sprite_batch, quad = create_sprite_batch()
        
        return {
            -- pooling
            objects = {},

            _instantiate_new = function(self, active, x, y) 
                local new = instantiate_new(active)
                if x then new.x = x end
                if y then new.y = y end
                table.insert(self.objects, new)
                return new
            end,

            fill = function(self, amount, active)
                for _ = amount, 1, -1 do
                    self:_instantiate_new(active or false)
                end
            end,

            pool = function(self, x, y) 
                for _, obj in ipairs(self.objects) do
                    if not obj.active then
                        obj.active = true
                        if x then obj.x = x end
                        if y then obj.y = y end
                        return obj
                    end
                end
                return self:_instantiate_new(true, x, y)
            end,

            -- game
            spriteBatch = sprite_batch,
            spriteQuad = quad,
            
            draw = function(self)
                self.spriteBatch:clear()
                for _, obj in ipairs(self.objects) do
                    if obj.active then
                        self.spriteBatch:setColor(obj.r, obj.g, obj.b)
                        self.spriteBatch:add(self.spriteQuad, obj.x, obj.y)
                    end
                end
                love.graphics.draw(self.spriteBatch)
            end,

            update = function(self, dt)
                for _, obj in ipairs(self.objects) do
                    if obj.active then
                        obj:update(dt)
                    end
                end
            end,

            ends = function(self)
                for _, obj in ipairs(self.objects) do
                    obj.active = false
                end
            end,
        }
    end
}


return ObjectPool
