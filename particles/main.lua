require("vector")
require("particle")
require("repeller")

function love.load()
    width = love.graphics.getWidth()
    height = love.graphics.getHeight()
    gravity = Vector:create(0, 0.1)
    system= ParticleSystem:create(Vector:create(width/2, height/2))
    -- particle = Particle:create(Vector:create(width/2, height/2)) 
    repeller = Repeller:create(width/2, height/2 + 150, 40, 10)
end

function love.update(dt)
    -- particle:update()
    system:update()
    
    -- system:applyForce(gravity)
    x, y = love.mouse.getPosition()
    system:attraction(x,y)
    system:applyRepeller(repeller)
end

function love.draw()
    -- particle:draw()
    system:draw()
    repeller:draw()
end

