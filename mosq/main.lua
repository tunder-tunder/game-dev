require("fly")
require("perlin")

function love.load()
    love.window.setTitle("Mosquito")
    background = love.graphics.newImage("res/background.png")
    love.window.setMode(background:getWidth(), background:getHeight())
    love.graphics.setBackgroundColor(3 / 255, 182 / 255, 252 / 255)

    herdflies = HerdFlies:create("res/mosquito.png", 1, 50, 1, 50, 1) -- image, xmin, xmax, ymin, ymax, n
    fly = Fly:create("res/mosquito.png", 10, 10, 2)

    noisex = Noise:create(1, 1, 256)
    noisey = Noise:create(1, 1, 256)

    tx = 0
    ty = -1


end

function love.update(dt)
    tx = tx + 0.01
    ty = ty + 0.015
    x = noisex:call(tx)
    y = noisey:call(ty)
    fly.x = remap(x, 0 , 1, 50, background:getWidth() - 50)
    fly.y = remap(y, 0 , 1, 50, background:getHeight() - 50)
    -- fly:update()
end

function love.draw()
    love.graphics.draw(background, 0, 0)
    fly:draw()
    love.graphics.print("Current fps: " .. tostring(love.timer.getFPS()), 10,10)

end