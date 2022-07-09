local ObjectPool = {
    new = function(instantiate_new) 
        return {
            -- pooling
            objects = {},

            _instantiate_new = function(self, active) 
                local new = instantiate_new(active)
                table.insert(self.objects, new)
                return new
            end,

            fill = function(self, amount, active)
                for _ = amount, 1, -1 do
                    self:_instantiate_new(active or false)
                end
            end,

            pool = function(self) 
                for _, obj in ipairs(self.objects) do
                    if not obj.active then
                        obj.active = true
                        return obj
                    end
                end
                return self:_instantiate_new(true)
            end,

            -- game
            draw = function(self)
                for _, obj in ipairs(self.objects) do
                    if obj.active then
                        obj:draw()
                    end
                end
            end,

            update = function(self)
                for _, obj in ipairs(self.objects) do
                    if obj.active then
                        obj:update()
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