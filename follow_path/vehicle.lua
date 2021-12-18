Vehicle = {}
Vehicle.__index = Vehicle

function Vehicle:create(x, y)
    local vehicle = {}
    setmetatable(vehicle, Vehicle)
    vehicle.acceleration = Vector:create(0, 0)
    vehicle.velocity = Vector:create(0, 0)
    vehicle.location = Vector:create(x, y)
    vehicle.r = 5
    vehicle.vertices = {0, - vehicle.r * 2, -vehicle.r, vehicle.r * 2, vehicle.r, 2 * vehicle.r}
    vehicle.maxSpeed = 4
    vehicle.maxForce = 0.1
    vehicle.wtheta = 0
    return vehicle
end

function Vehicle:update()
    self.velocity:add(self.acceleration)
    self.velocity:limit(self.maxSpeed)
    self.location:add(self.velocity)
    self.acceleration:mul(0)
end

function Vehicle:applyForce(force)
    self.acceleration:add(force)
end

function Vehicle:borders(path)
    if self.location.x > path.stop.x + self.r then
        self.location.x = path.start.x - self.r
        self.location.y = path.start.y + (self.location.y - path.stop.y)
    end
end

function Vehicle:seek(target)
    local desired = target - self.location
    if desired:mag() == 0 then 
        return 
    end 
    
    desired:norm()
    desired:mul(self.maxSpeed)
    local steer = desired - self.velocity
    steer:limit(self.maxForce)
    self:applyForce(steer)

end

function Vehicle:follow(path)
    local predict = self.velocity:copy()
    predict:norm()
    predict:mul(50)

    local pos = self.location + predict
    -- print(pos)
    local normal = getNormalPoint(pos, path.start, path.stop)
    local dir = path.stop - path.start
    dir:norm()
    dir:mul(10)
    local target = normal + dir
    local distance = pos:distTo(dir)
    if distance > path.d then 
        self:seek(target)
    end
end

function Vehicle:borders()
    if self.location.x < -self.r then
        self.location.x = width + self.r
    end
    if self.location.y < -self.r then
        self.location.y = height + self.r
    end
    if self.location.x > width + self.r then
        self.location.x = -self.r
    end
    if self.location.y > height + self.r then
        self.location.y = -self.r
    end
end


function Vehicle:draw()
    local theta = self.velocity:heading() + math.pi / 2
    love.graphics.push()
    love.graphics.translate(self.location.x, self.location.y)
    love.graphics.rotate(theta)
    love.graphics.polygon("fill", self.vertices)
    love.graphics.pop()
end
