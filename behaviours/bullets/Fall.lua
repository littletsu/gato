local Fall = function(bullets, count)
    for i = 0, count, 1 do
        local bullet = bullets[i]
        --bullet.y = bullet.y + (i * 30)
        bullet:translate(nil, bullet.yLimit)
    end
end

return Fall