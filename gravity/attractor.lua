Attractor = {}
Attractor.__index = Attractor 

function Attractor:create(location, velocity, weight)
    local attractor = {}
    setmetatable(attractor, Attractor)
    attractor.location = location
    attractor.velocity = velocity
    attractor.acceleration = Vector:create(0, 0)
    attractor.weight = weight
    attractor.size = 30 + 0.3 * weight
    attractor.inner_size = attractor.size
    return attractor
end

function Attractor:update()
    self.velocity = self.velocity + self.acceleration
    self.location = self.location + self.velocity
    self.acceleration:mul(0)
end

function Attractor:checkBoundaries()
    if self.location.x > width - self.size then
        self.location.x = width - self.size
        self.velocity.x = -1*self.velocity.x
    elseif self.location.x < self.size then
        self.location.x = self.size
        self.velocity.x = -1*self.velocity.x
    end
    if self.location.y > height - self.size then
        self.location.y = height - self.size
        self.velocity.y = -1*self.velocity.y
    elseif self.location.y < self.size then
        self.location.y = self.size
        self.velocity.y = -1*self.velocity.y
    end
end

function Attractor:draw()
    local r, g, b, a = love.graphics.getColor()
    self.inner_size = self.inner_size - 0.5
    
    if self.inner_size <= 0 then 
        self.inner_size = self.size 
    end

    love.graphics.circle("line", self.location.x, self.location.y, self.size)
    love.graphics.circle("line", self.location.x, self.location.y, self.inner_size)
    love.graphics.setColor(r, g, b, a)
end

function Attractor:attract(object)
    
    force = self.location - object.location
    distance = force:mag()
    
    if distance and force then

        if distance < 5 then
            distance = 5
        end

        if distance > 25 then 
            distance = 25
        end 
        
        force = force:norm()
        print(force)
        strength = (G * self.weight  * object.weight) / (distance * distance)
        force:mul(strength)
        mover:applyForce(force)
    end

end