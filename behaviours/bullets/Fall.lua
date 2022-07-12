local Fall = function(bullets, count)
    for i = 0, count, 1 do
        local bullet = bullets[i]
        bullet.y = bullet.y + (20 * i)
        bullet:translate(nil, love.graphics.getHeight())
    end
end

return Fall
