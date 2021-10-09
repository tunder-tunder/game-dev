require("vector")
require("mover")

function love.load()
    width = love.graphics.getWidth()
    height = love.graphics.getHeight()

    location = Vector:create(200, height/2)
    wlocation = Vector:create(500, height/2)
    velocity = Vector:create(0.5, 0.5) 

    mover = Mover:create(location, velocity)
    mover.size = 50
    mover.aAcceleration = 0.05

    wmover = Mover:create(wlocation, velocity, 5)
    wmover.size = 50
    wmover.aAcceleration = 0.01

end

function love.update()

    x, y = love.mouse.getPosition()
    mouse = Vector:create(x,y)
    dir = mouse - mover.location
    acceleration = dir:norm() * 0.4
    mover.acceleration = acceleration


    mover:update()
    -- mover:checkBoundaries()
    mover.velocity = mover.velocity:limit(5)
    
    wmover:update()
    wmover:checkBoundaries()
end

function love.draw()
    mover:draw()
    wmover:draw()

end