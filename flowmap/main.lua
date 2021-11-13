require("vector")
require("flowmap")


function love.load()
    width = love.graphics.getWidth()
    height = love.graphics.getHeight()
    flow = FlowMap:create(40)
    flow:init()
end

function love.update(dt)

end

function love.draw()
    flow:draw()
end
