Ball = {}
Ball.__index = Ball

function Ball:create(location)
    local ball = {}
    setmetatable(ball, Ball)

    ball.location = location
    ball.acceleration = Vector:create(0, 0)
    ball.velocity = Vector:create(math.random(-1.5, 1.5), math.random(-1.5, 1.5))
    ball.size = 10
    ball.maxSpeed = 2

    return ball
end

function Ball:applyForce(force)
    self.acceleration:add(force)
end

function Ball:draw()
    love.graphics.circle("fill", self.location.x, self.location.y, self.size)
end

function Ball:update()

    self.velocity:add(self.acceleration)
    self.velocity:limit(self.maxSpeed)
    self.acceleration:limit(self.maxSpeed)

    self.location:add(self.velocity)

    self.acceleration:mul(0)

    self:checkBoundaries()

end


function Ball:checkBoundaries()
    if self.location.y + self.size < 0 then
        local newVelocity = Vector:create(0, -self.velocity.y*2)
        self.velocity:add(newVelocity)
    end
    if self.location.y + self.size > height then
        local newVelocity = Vector:create(0, -self.velocity.y*2)
        self.velocity:add(newVelocity)
    end
end
