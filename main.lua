--local Scene = require("lib.Scene")
local SceneManager = require("engine.SceneManager")
local MainMenu = require("scenes.MainMenu")
local Test = require("scenes.Test")

local inspect = require("utils.inspect");

function love.load()
    print("load")
    love.keyboard.setKeyRepeat(true)
    SceneManager:switch(MainMenu)
end

function love.update()
    SceneManager:update()
end

function love.draw()
    SceneManager:draw()
end

function love.mousepressed(x, y, button, istouch)
    print(inspect(SceneManager.current))
    if SceneManager.current ~= MainMenu then
        SceneManager:switch(MainMenu)
    else
        SceneManager:switch(Test)
    end
end

function love.keypressed(key, scancode, isrepeat)
    SceneManager:keypressed(key, scancode, isrepeat)
end

function love.quit()
    print("quit")
end