require("vector")
require("square")

function love.load()
    width = love.graphics.getWidth()
    height = love.graphics.getHeight()
    gravity = Vector:create(0, 0.1)
    -- particle = Particle:create()
    system= ParticleSystem:create(1, 50, 1, 50, 10)
end

function love.update(dt)
    -- particle:update()
    -- system:update()
    
    -- system:applyForce(gravity)
end

function love.draw()
    -- particle:draw()
    system:draw()
end

