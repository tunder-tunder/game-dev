Harmony = {}
Harmony.__index = Harmony

function Harmony:create(x, x1, height, A, angleVel, angle, r)
    local harmony = {}
    setmetatable(harmony, Harmony)

    harmony.x = x or 0
    harmony.x1 = x1 or 0
    harmony.height = height
    harmony.A = A or 40
    harmony.angleVel = angleVel or 0.001
    harmony.angle = angle or 0.1
    harmony.c =  math.random(1, 15)
    harmony.r =r or 10

    return harmony
end 

function Harmony:draw()
    for x = 0, self.x1, 8 do
        y = A * math.sin((self.angle + x / 200) * self.c)
        y = y + A * math.sin((self.angle + x / 200) * self.c)

        distx = x / self.x1
        disty = y /(self.height/8)

        love.graphics.setColor(255, 255, 255)
        love.graphics.circle("line", x, y + self.height, self.r)
        love.graphics.setColor(distx, 0.8 ,disty , 0.5) 
        love.graphics.circle("fill", x, y + self.height, self.r)
        
    end
    self.angle = self.angle + self.angleVel 

end 
