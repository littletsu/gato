local AM = {
    loadedImages = {},
    loadedFonts = {},
    loadedAudio = {},
    loadedShaders = {},

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
    end,
    
    loadShader = function(self, path)
        if self.loadedShaders[path] == nil then
            self.loadedShaders[path] = love.graphics.newShader(path)
        end

        return self.loadedShaders[path]
    end,
}

return AM
