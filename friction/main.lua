require("vector")
require("mover")

function love.load()
    width = love.graphics.getWidth()
    height = love.graphics.getHeight()
    love.graphics.setBackgroundColor(128 / 255, 128 / 255, 128 / 255)
    
    location = Vector:create(100, height/2)
    wlocation = Vector:create(500, height/2)
    velocity = Vector:create(0, 0)
    
    mover = Mover:create(location, velocity)
    mover.size = 20
    wmover = Mover:create(wlocation, velocity, 5)
    wmover.size = 20

    -- create rects somehow 

    -- rectangleBlue = 
    -- rectangleGreen =

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


    if (mover.location.x + mover.size < 100 and mover.location.y + mover.size < 100) then
        friction = (mover.velocity * -1):norm()
        if friction then
            friction:mul(0.05)
            mover:applyForce(friction)
        end
    end

    if (wmover.location.x + wmover.size < 400 and wmover.location.y + wmover.size < 100 ) then
        friction = wmover.velocity:norm()
        if friction then
            friction:mul(-0.05)
            wmover:applyForce(friction)
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
