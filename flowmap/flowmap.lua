FlowMap = {}
FlowMap.__index = FlowMap

function FlowMap:create(size)
    local map = {}
    setmetatable(map, FlowMap)
    map.field = {}
    map.size = size
    love.math.setRandomSeed(10000)
    return map 
end


function spiralCoordinates( fraction, maxRadius, maxTheta )
    local radius = maxRadius * fraction
    local theta = maxTheta * fraction
    return math.cos( theta ) * radius, math.sin( theta ) * radius
end
   
function FlowMap:init()
    local a=1
    local b=1
    local cycles=40
    local step=0.001
    local cols = width / self.size
    local rows = height / self.size
    local xoff = love.graphics.getWidth()/2
    local yoff = love.graphics.getHeight()/2
  
    for i = 1, cols  do 
        self.field[i] = {}
        for j = 1, rows do 
            self.field[i][j] = Vector:create(1, 1)
            -- local theta = math.map(love.math.noise(xoff, yoff), 0, 1, 0, math.pi * 2)

            -- j = cycles*math.pi
            for i=0,cycles*math.pi,step do
              one = xoff+(a + b*i)*math.cos(i)
              two = yoff+(a + b*i)*math.sin(i)
           end
            self.field[i][j] = Vector:create(one, 
                                            two)
        
        end
        
    end 
end

function FlowMap:draw()
    for i = 1, #self.field  do 
        for j = 1, #self.field[1] do
            drawVector(self.field[i][j], (i -1) * self.size, (j) * self.size, self.size - 2)
        end
    end
end

function drawVector(v, x ,y, s)
    love.graphics.push()
    love.graphics.translate(x,y)
    love.graphics.rotate(v:heading())
    local len = v:mag() * s
    love.graphics.line(0,0,len, 0)
    love.graphics.circle("fill", len, 0, 5)
    love.graphics.pop()
end

function FlowMap:lookup(v)
	local col = math.constrain(math.floor(v.x/self.size)+1, 1, #self.field)
	local row = math.constrain(math.floor(v.y/self.size)+1, 1, #self.field[1])
	return self.field[col][row]:copy()
end

    --- в середине клетки должен рисоваться вектор