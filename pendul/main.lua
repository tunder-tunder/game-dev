require("vector")
require("pendulum")
require("mover")
require("spring")


function love.load()
    width = love.graphics.getWidth()
    height = love.graphics.getHeight()
    gravity = 0.4
    pend = Pendulum:create(Vector:create(width/2, 50), 200)
    pend2 = Pendulum:create(pend.position, 150)
    mover = Mover:create(width/2, height/2, 30)
    spring = Spring:create(Vector:create(width/2, height/ 2 - 100), 100)
end

function love.update(dt)
    pend:update()
    pend2:update()
    spring:connect(mover)
    spring:constraintLength(mover, 20, 400)
    mover:update()

end

function love.draw()
    pend:draw()
    pend2:draw()
    mover:draw()
    spring:draw()
    spring:drawLine(mover)
end

function love.mousepressed(x, y, button, istouch, presses)
    if button == 1 then 
        pend:startDragging(x, y)
        pend2:startDragging(x, y)
        mover:startDragging(x, y)
    end
end

function love.mousereleased(x, y, button, istouch, presses)
    if button == 1 then 
        pend:stopDragging()
        pend2:stopDragging()
        mover:stopDragging()
    end
end