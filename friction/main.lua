require("vector")
require("mover")

function love.load()
    width = love.graphics.getWidth()
    height = love.graphics.getHeight()
    love.graphics.setBackgroundColor(128 / 255, 128 / 255, 128 / 255)
    
    location = Vector:create(200, height/2)
    wlocation = Vector:create(500, height/2)
    velocity = Vector:create(0, 0)
    
    mover = Mover:create(location, velocity)
    mover.size = 20
    wmover = Mover:create(wlocation, velocity, 5)
    wmover.size = 20

    wind = Vector:create(0.01, 0)
    isWind = false
    
    gravity = Vector:create(0, 0.01)
    isGravity = false
    
    floating = Vector:create(0, -0.02)
    isFloating = false
end

function love.update()

    
    if isGravity then
        mover:applyForce(gravity)
        wmover:applyForce(gravity)
    end

    if isFloating then 
        mover:applyForce(floating)
        wmover:applyForce(floating)
    end

    if isWind then 
        mover:applyForce(wind)
        wmover:applyForce(wind)
    end

-- left rect 
    if wmover.location.x  > 100 and wmover.location.x + wmover.size < 300 then 
        if wmover.location.y > 100 and wmover.location.y + wmover.size < 300 then
            friction1 = (wmover.velocity):norm()
            friction1:mul(-0.5)
            wmover:applyForce(friction1)
        end
    end 

    if mover.location.x  > 100 and mover.location.x + mover.size < 300 then
        if mover.location.y > 100 and mover.location.y + mover.size < 300 then 
            friction = (mover.velocity):norm()
            friction:mul(-0.5)
            mover:applyForce(friction)
        end
    end 

-- right rect 
    if  wmover.location.x  > 400 and wmover.location.x + wmover.size < 600 then
        if wmover.location.y > 100 and wmover.location.y + wmover.size < 300 then 
            friction3 = wmover.velocity:norm()
            friction3:mul(0.05)
            wmover:applyForce(friction3)
        end
    end

    if mover.location.x  > 400 and mover.location.x + mover.size < 600 then 
        if mover.location.y > 100 and mover.location.y + mover.size < 300 then
            friction2 = mover.velocity:norm()
            friction2:mul(0.05)
            mover:applyForce(friction2)
        end
    end
    
    mover:update()
    mover:checkBoundaries()
    
    wmover:update()
    wmover:checkBoundaries()
end

function love.draw()
    mover:draw()
    wmover:draw()
    
    love.graphics.print(tostring(mover.velocity), mover.location.x + mover.size, mover.location.y)
    love.graphics.print(tostring(wmover.velocity), wmover.location.x + wmover.size, wmover.location.y)
    love.graphics.print("w: " .. tostring(isWind) .. " g: " .. tostring(isGravity) .. " f: " .. tostring(isFloating))
    
    local r, g, b, a = love.graphics.getColor()
	love.graphics.setColor(0, 199/255, 90/255, 0.5)
	love.graphics.rectangle("fill", 100, 100, 200, 200)
	
    love.graphics.setColor(0, 230/255, 52/255, 0.5)
	love.graphics.rectangle("fill", 400, 100, 200, 200)
    love.graphics.setColor(r, g, b, a)

end

function love.keypressed(key)
    
    if key == 'g' then
        isGravity = not isGravity
    end
    
    if key == 'f' then
        isFloating = not isFloating
    end
    
    if key == 'w' then
        isWind = not isWind
        if isWind then
            wind = wind * -1
        end
    end

end
