require("vector")
require("ball")
require("board")
require("pong")


function love.load()
    width = love.graphics.getWidth()
    height = love.graphics.getHeight()

    pong = Pong:create()
end

function love.update(dt)
    pong:update()
end

function love.draw()
    pong:draw()
end

function love.keypressed(key, scancode, isrepeat)
    pong:processKeyPressed(key, scancode, isrepeat)
end

function love.keyreleased(key, scancode, isrepeat)
    pong:processKeyReleased(key, scancode, isrepeat)
end
