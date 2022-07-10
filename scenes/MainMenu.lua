local inspect = require("utils.inspect")
local AssetManager = require("engine.AssetManager")
local paths = require('engine.AssetPaths')
print(inspect(AssetManager))


return {
    textImg = AssetManager:loadImage(paths.ui .. "TouhouNeko.png"),
    cat = AssetManager:loadImage(paths.sprites .. "CatUnfocused.png"),
    music = AssetManager:loadAudio(paths.bgm .. "KeyboardCat.mp3", "stream"),
    draw = function(self)
        --love.graphics.setBackgroundColor(255, 255, 255, 255)
        love.graphics.draw(self.cat, love.graphics.getWidth()/2, love.graphics.getHeight()/2, 0, 1, 1, self.cat:getWidth()/2, self.cat:getHeight()/2)
        love.graphics.draw(self.textImg, (love.graphics.getWidth()/2)-10, (love.graphics.getHeight()/2)+70, 0, 2.5, 2, self.textImg:getWidth()/2, self.textImg:getHeight()/2)
    end,
    start = function(self)
        self.music:setLooping(true)
        self.music:play()
        print(inspect(AssetManager))

    end,
    ends = function(self)
        self.music:stop()
    end,
    update = function() end,
}