require("vector")
require("attractor")
require("mover")

function love.load()
    width = love.graphics.getWidth()
    height = love.graphics.getHeight()
    love.graphics.setBackgroundColor(128 / 255, 128 / 255, 128 / 255)
    
    G = 0.4

    local location = Vector:create( 50, height/2)

    attractors = {}
    attractors.objs = {}
    n = 0
    velocity_attr = Vector:create(0.1 , 0.1)
    for i=1, 11 do
        n = n + 100 
        local location = Vector:create(n, height/ 2)
        attractors.objs[i] = Attractor:create(location, velocity_attr ,20)
    end
    
    
    local location = Vector:create(300, 350)
    local velocity = Vector:create(0.5,0.5)
    mover = Mover:create(location, velocity, 1)
    
end

function love.update()
    
    -- mover:update()
    for i=1, 11 do
        attractors.objs[i]:checkBoundaries()
        attractors.objs[i]:update()
    end

    for i=1, 11 do
        for j=1, 11 do 
            if i ~= j then
                attractors.objs[i]:attract(attractors.objs[j])
            end
        end
    end
    -- for attractor in attractors do
    --     for attractor 
    -- end
    
    -- wmover:update()
    -- wmover:checkBoundaries()
end

function love.draw()
    for i=1, 11 do
        attractors.objs[i]:draw()
    end

    -- mover:draw()
    -- wmover:draw()
    
    -- love.graphics.print(tostring(mover.velocity), mover.location.x + mover.size, mover.location.y)
    -- love.graphics.print(tostring(wmover.velocity), wmover.location.x + wmover.size, wmover.location.y)
    -- love.graphics.print("w: " .. tostring(isWind) .. " g: " .. tostring(isGravity) .. " f: " .. tostring(isFloating))
    
    -- local r, g, b, a = love.graphics.getColor()
	-- love.graphics.setColor(0, 199/255, 90/255, 0.5)
	-- love.graphics.rectangle("fill", 100, 100, 200, 200)
	
    -- love.graphics.setColor(0, 230/255, 52/255, 0.5)
	-- love.graphics.rectangle("fill", 400, 100, 200, 200)
    -- love.graphics.setColor(r, g, b, a)

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
