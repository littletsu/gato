local AM = {
    loadedImages = {},
    loadedFonts = {},
    loadedAudio = {},

    loadImage = function(self, path)
        if self.loadedImages[path] == nil then
            self.loadedImages[path] = love.graphics.newImage(path)
        end

        return self.loadedImages[path]
    end,

    loadFont = function(self, path)
        if self.loadedFonts[path] == nil then
            self.loadedFonts[path] = love.graphics.newFont(path)
        end

        return self.loadedFonts[path]
    end,

    loadAudio = function(self, path, type)
        if self.loadedAudio[path] == nil then
            self.loadedAudio[path] = love.audio.newSource(path, type)
        end

        return self.loadedAudio[path]
    end
}

return AM