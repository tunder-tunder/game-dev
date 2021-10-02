Rect = {}
Rect.__index = Rect

function Rect:create(location, velocity)
    local rect = {}
    setmetatable(rect, Rect)
    rect.location = location
    rect.velocity = velocity
    rect.acceleration = Vector:create(0, 0)
    rect.width = 50
    rect.height = 50
    rect.weight = weight or 1
    return rect
end

function Rect:applyForce(force)
    self.acceleration:add(force / self.weight)
end

function Rect:checkBoundaries()
    if self.location.x > width - self.width then
        self.location.x = width - self.width
        self.velocity.x = -1*self.velocity.x
    elseif self.location.x < self.width then
        self.location.x = self.width
        self.velocity.x = -1*self.velocity.x
    end
    if self.location.y > height - self.height then
        self.location.y = height - self.height
        self.velocity.y = -1*self.velocity.y
    elseif self.location.y < self.width then
        self.location.y = self.width
        self.velocity.y = -1*self.velocity.y
    end
end

function Rect:draw()
    love.graphics.rectangle("fill", self.location.x, self.location.y, self.width, self.height)
end

function Rect:update()
    self.velocity = self.velocity + self.acceleration
    self.location = self.location + self.velocity
    self.acceleration:mul(0)
end