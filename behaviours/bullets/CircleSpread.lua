local startAngle = 90
local endAngle = 270

local CircleSpread = function(bullets, count)
    local angleStep = (startAngle - endAngle) / count
    local angle = startAngle
    for i = 0, count, 1 do
        local bullet = bullets[i]

        local bulDirX = bullet.x + (math.sin((angle * math.pi) / 180) * love.graphics.getWidth());
        local bulDirY = bullet.x + (math.cos((angle * math.pi) / 180) * love.graphics.getWidth());

        bullet:translate(bulDirX, bulDirY)
        angle = angle + angleStep
    end
end

return CircleSpread