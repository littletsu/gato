local color = require("utils.color")

local rad = math.pi / 180

local CircleSpread = function(bullets, count, startAngle, endAngle, speed)
    local angleStep = ((startAngle or 360) - (endAngle or 0)) / count
    local angle = startAngle
    for i = 0, count, 1 do
        local bullet = bullets[i]
        bullet.r, bullet.g, bullet.b = color.HSL(i * 1/count, 1, 0.5, 1)
        if speed then bullet.speed = speed end
        local bulDirX = bullet.x + (math.sin(angle * rad) * love.graphics.getWidth());
        local bulDirY = bullet.x + (math.cos(angle * rad) * love.graphics.getHeight());

        bullet:translate(bulDirX, bulDirY)
        angle = angle + angleStep
    end
end

return CircleSpread
