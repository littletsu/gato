local Offsets = {
    middle = function(image, sx, sy) 
        local w, h = image:getDimensions()
        return {
            x = (w * (sx or 1)) / 2,
            y = (h * (sy or 1)) / 2
        }
    end
}

return Offsets