local Fall = function(bullets, count)
    for i = 0, count, 1 do
        local bullet = bullets[i]
        --bullet.y = bullet.y + (i * 30)
        bullet:translate(nil, 300)
    end
end

return Fall