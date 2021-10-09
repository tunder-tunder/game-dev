require("vector")
require("mover")

function love.load()
    width = love.graphics.getWidth()
    height = love.graphics.getHeight()
    background = love.graphics.newImage("res/stars_background.png")

    mover_images = {}
    mover_images[1] = love.graphics.newImage("res/ship_no_engine.png")
    mover_images[2] = love.graphics.newImage("res/ship_engine_on.png")
    mover_images[3] = love.graphics.newImage("res/ship_engine_full.png")
    
    location = Vector:create(200, height/2)
    wlocation = Vector:create(500, height/2)
    velocity = Vector:create(0, 0) 

    player = Mover:create(mover_images, Vector:create(100, 100), Vector:create(0, 0))

    obstacle_images = {}
    obstacle_images[1] = love.graphics.newImage("res/obstacle_round.png")
    obstacle = Mover:create(obstacle_images, Vector:create(50,50), Vector:create(0.5, 2))
    obstacle.aVelocity = 0.005

end

function love.update()

    if love.keyboard.isDown("left") then
        player.angle = player.angle - 0.05 
    end
    if love.keyboard.isDown("right") then
        player.angle = player.angle + 0.05 
    end
    if love.keyboard.isDown("up") then
        x =  0.1  * math.cos(player.angle)
        y =  0.1  * math.sin(player.angle)
        player:applyForce(Vector:create(x,y))
    end

    player:update()
    obstacle:update()

    player:checkBoundaries()
    obstacle:checkBoundaries()
end

function love.draw()
    love.graphics.draw(background, 0, 0)
    
    player:draw()
    obstacle:draw()
end