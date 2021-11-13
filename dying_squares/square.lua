Particle = {}
Particle.__index = Particle

function Particle:create(x, y)
    local particle = {}
    setmetatable(particle, Particle)

    particle.x = x or 0
    particle.y = y or 0
    -- particle.acceleration = Vector:create(0, 0.05)
    -- particle.velocity = Vector:create(math.random(-400, 400) / 100, math.random(-200, 0) / 100)
    -- particle.lifespan = 50
    -- particle.decay = math.random(3,8) / 10
    return particle
end

function Particle:update()
    -- self.velocity:add(self.acceleration)
    -- self.location:add(self.velocity)
    -- self.acceleration:mul(0)
    -- self.lifespan = self.lifespan - self.decay
end 

function Particle:applyForce(force)
    -- self.acceleration:add(force)
end 

function Particle:isDead()
    return self.lifespan < 0 
end 

function Particle:draw()
    local r, g, b, a = love.graphics.getColor()
	love.graphics.setColor(0, 199/255, 90/255, 1)
	love.graphics.rectangle("line", 100, 100, 200, 200)
end

ParticleSystem = {}
ParticleSystem.__index = ParticleSystem

function ParticleSystem:create(xmin, xmax, ymin, ymax, n)
    local system = {}
    setmetatable(system, ParticleSystem)
    system.origin = origin
    system.n = n or 10
    system.cls = cls or Particle
    system.particles = {}
    system.index = 1

    system.objs = {}
    for i=1, n do
        x = love.math.random(xmin, xmax)
        y = love.math.random(ymin, ymax)
        system.objs[i] = Particle:create(x, y)
    end
    return system
end

function ParticleSystem:draw()
    -- love.graphics.circle("line", self.origin.x, self.origin.y, 10)
    for k, v in pairs(system.particles) do
        v:draw()
    end
end

function ParticleSystem:update()
    -- if #self.particles < self.n then 
    --     self.particles[self.index] = self.cls:create(self.location:copy())
    --     self.index = self.index + 1
    -- end
    -- for k, v in pairs(self.particles) do 
    --     if v:isDead() then 
    --         v = self.cls:create(self.origin:copy())
    --         self.particles[k] = v
    --     end 
    --     v:update()
    -- end
end 