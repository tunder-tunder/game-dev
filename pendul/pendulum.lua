Pendulum = {}
Pendulum.__index = Pendulum

function Pendulum:create(origin, length)
    local pendulum = {}
    setmetatable(pendulum, Pendulum)
    pendulum.origin = origin 
    pendulum.length = length
    pendulum.position = Vector:create(0,0)
    pendulum.aVelocity = 0
    pendulum.aAcceleration = 0 
    pendulum.damping = 0.995
    pendulum.angle = math.pi / 2
    pendulum.r = 20
    pendulum.dragging = false
    return pendulum
end

function Pendulum:draw()
    self:drag()
    self.position.x = self.length * math.sin(self.angle) + self.origin.x
    self.position.y = self.length * math.cos(self.angle) + self.origin.y
    love.graphics.circle("line", self.origin.x, self.origin.y, 5)
    love.graphics.line(self.origin.x, self.origin.y, self.position.x, self.position.y)
    
    r, g, b, a = love.graphics.getColor()
    if self.dragging then 
        love.graphics.setColor(1,0,0)
    end

    love.graphics.circle("fill", self.position.x, self.position.y, self.r)
    love.graphics.setColor(r, g, b ,a)
end

function Pendulum:update()
    self.aAcceleration = (-1 * gravity / self.length) * math.sin(self.angle)
    self.aVelocity = self.aVelocity + self.aAcceleration
    self.aVelocity = self.aVelocity * self.damping
    self.angle = self.angle + self.aVelocity
end


function math.dist(x1,y1, x2,y2) return ((x2-x1)^2+(y2-y1)^2)^0.5 end 

function Pendulum:startDragging(x, y)
    local d = math.dist(x,y, self.position.x, self.position.y)
    if d < self.r then 
        self.dragging = true 
    end
end

function Pendulum:stopDragging()
    if self.dragging then 
        self.dragging = false
    end 
end

function Pendulum:drag()
    if self.dragging then
        local x, y = love.mouse.getPosition()
        local diff =  Vector:create(x, y) - self.origin
        self.angle = math.atan2(diff.x, diff.y)
    end 
end