Board = {}
Board.__index = Board

function Board:create(location, force)
    local board = {}
    setmetatable(board, Board)

    board.location = location
    board.size = 90
    board.step = 4
    board.direction = 0
    board.force = force
    
    return board
end


function Board:draw()
    love.graphics.rectangle("fill", self.location.x, self.location.y, 10, self.size)
end

function Board:startChangePosition(direction)
    self.direction = direction
end

function Board:stopChangePosition()
    self.direction = 0
end

function Board:update()
    self.location:add(Vector:create(0, self.step * self.direction))
    self:checkBoundaries()
end

function Board:checkBoundaries()
    if self.location.y + self.size > height then
        self.location.y = height - self.size
    elseif  self.location.y < 0 then
        self.location.y = 0
    end
end