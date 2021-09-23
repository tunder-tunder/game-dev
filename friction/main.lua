require("vector")
require("mover")

function love.load()
    width = love.graphics.getWidth()
    height = love.graphics.getHeight()
    love.graphics.setBackgroundColor(128 / 255, 128 / 255, 128 / 255)
    --location = Vector:create(width / 2, height / 2)
    location1 = Vector:create(width / 4, height / 2)
    location2 = Vector:create(width / 4 * 3, height / 2)
    velocity = Vector:create(0, 0)
    mover = Mover:create(location1, velocity)
    wmover = Mover:create(location2, velocity, 5)
    wmover.size = 20

    wind = Vector:create(0.01, 0)
    isWind = false
    gravity = Vector:create(0, 0.01)
    isGravity = false
    floating = Vector:create(0, -0.02)
    isFloating = false
end

function love.update()
    mover:applyForce(gravity)
    --mover:applyForce(wind)
    wmover:applyForce(gravity)
    --wmover:applyForce(wind)

    if (mover.location.x < width / 2) then
        friction = (mover.velocity * -1):norm()
        if friction then
            friction:mul(0.005)
            mover:applyForce(friction)
        end
    end

    if (wmover.location.x < width / 2) then
        friction = wmover.velocity:norm()
        if friction then
            friction:mul(0.005)
            wmover:applyForce(friction)
        end
    end
    
    -- if isGravity then
    --     mover:applyForce(gravity)
    -- end
    -- if isWind then
    --     mover:applyForce(wind)
    -- end
    -- if isFloating then
    --     mover:applyForce(floating)
    -- end
    mover:update()
    mover:checkBoundaries()

    -- if isGravity then
    --     wmover:applyForce(gravity)
    -- end
    -- if isWind then
    --     wmover:applyForce(wind)
    -- end
    -- if isFloating then
    --     wmover:applyForce(floating)
    -- end
    wmover:update()
    wmover:checkBoundaries()
end

function love.draw()
    mover:draw()
    wmover:draw()
    love.graphics.print(tostring(mover.velocity), mover.location.x + mover.size, mover.location.y)
    love.graphics.print(tostring(wmover.velocity), wmover.location.x + wmover.size, wmover.location.y)
    love.graphics.print("w: " .. tostring(isWind) .. " g: " .. tostring(isGravity) .. " f: " .. tostring(isFloating))
    
    local r,g,b,a = love.graphics.getColor()
    love.graphics.setColor(0, 119/255, 119/255, 0.5)
    love.graphics.rectangle("fill", 0, 0, 400, 800)
    love.graphics.setColor(r,g,b,a)

    local r,g,b,a = love.graphics.getColor()
    love.graphics.setColor(119/255, 0, 0, 0.5)
    love.graphics.rectangle("fill", width/2, 0, 400, 800)
    love.graphics.setColor(r,g,b,a)
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