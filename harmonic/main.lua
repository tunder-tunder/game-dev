require("harmony")

function love.load()
    width = love.graphics.getWidth()
    height = love.graphics.getHeight()

    A = 40 
    angleVel = 0.001
    angle = 0.1
    -- harmony = Harmony:create(0 , width - 250, 2, 40, 0.001, 0.1)
    harmony = Harmony:create(100 , width, 100, 40, 0.001, 0.01, 10)
    harmony1 = Harmony:create(100 , width, 500, 40, 0.01, 0.1, 5)
end

function love.update(dt)
    -- x = A * math.sin(math.pi * frame / x_period)
    -- y = A * math.sin(math.pi * frame / y_period)
    -- frame = frame + 1
end

function love.draw()
    -- for x = 0, width, 8 do
    --     y = A * math.sin((angle + x / 200) * 4)
    --     y = y + A * math.sin((angle + x / 200) * 12)
    --     love.graphics.setColor(255, 255, 255) 
    --     love.graphics.circle("line", x, y + height / 2, 10)
    --     love.graphics.setColor(181, 179, 179, 0.5) 
    --     love.graphics.circle("fill", x, y + height / 2, 10)
    -- end
    -- angle = angle + angleVel 
    harmony:draw()
    harmony1:draw()

end 