Spring = {}
Spring.__index = Spring

function Spring:create(origin, length)
    local spring = {}
    setmetatable(spring, Spring)
    spring.origin = origin
    spring.length = length
    spring.k = 0.1
    return spring
end

function Spring:connect(mover)
    local f = mover.position - self.origin
    local d = f:mag()
    local stretch = d - self.length

    local f = f:norm()
    f:mul(-1 * self.k * stretch)
    mover:applyForce(f)
end

function Spring:constraintLength(mover, minlen, maxlen)
    local f = mover.position - self.origin
    local d = f:mag()
    if d < minlen then 
        local dir = f:norm()
        dir:mul(minlen)
        mover.position = self.origin + dir
        mover.velocity:mul(0)       
    elseif d > maxlen then
        local dir = f:norm()
        dir:mul(maxlen)
        mover.position = self.origin + dir
        mover.velocity:mul(0)  
    end
end   

function Spring:draw()
    love.graphics.rectangle("fill", self.origin.x -5, self.origin.y - 5, 10, 10)
end

function Spring:drawLine(mover)
    love.graphics.line(mover.position.x, mover.position.y, self.origin.x, self.origin.y)
end