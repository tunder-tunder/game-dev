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

function FlowMap:init()
    local cols = width / self.size
    local rows = height / self.size
    local xoff = 0 
    local yoff = 0
    for i = 1, cols  do 
        yoff = 0
        self.field[i] = {}
        for j = 1, rows do 
            -- self.field[i][j] = Vector:create(1, 1)
            local theta = math.map(love.math.noise(xoff, yoff), 0, 1, 0, math.pi * 2)
            self.field[i][j] = Vector:create(math.cos( theta ), 
                                math.sin( theta ))
            yoff = yoff + 0.1
        end
        xoff = xoff +0.1
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