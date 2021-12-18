Pong = {}
Pong.__index = Pong

local socket = require("socket")

function Pong:create()
    local pong = {}
    setmetatable(pong, Pong)
    pong.scoreA = 0
    pong.scoreB = 0
    pong.board1 = Board:create(Vector:create(0, height / 2), Vector:create(2, 0))
    pong.board2 = Board:create(Vector:create(width-10, height / 2), Vector:create(-2, 0))
    pong.ball = Ball:create(Vector:create(width / 2, height / 2))
    pong.is_end = false
    return pong
end

function Pong:drawScore()
    love.graphics.setNewFont(18)
    love.graphics.print(tostring(self.scoreA), (width / 2) - 15, 40)
    love.graphics.print(":", width / 2, 40)
    love.graphics.print("Score 3 to win", (width / 2) - 60, 60)
    love.graphics.print(tostring(self.scoreB), (width / 2) + 10, 40)
end


function Pong:draw()
    self:drawScore()
    self.board1:draw()
    self.board2:draw()
    if self.scoreA >= 3 then
        love.graphics.print("Player 1 wins!", (width / 4), height / 2)
    end
    if self.scoreB >= 3 then
        love.graphics.print("Player 2 wins!", (width / 4) * 3, height / 2)
    end
    if self.is_end then
        return
    end
    self.ball:draw()
end

function Pong:update()
    if self.is_end then
        return
    end
    self.board1:update()
    self.board2:update()
    self.ball:update()
    self:checkPlatformOnBall()
    self:checkGoal()

    if self.scoreA >= 3 then
        self.is_end = true
    end

    if self.scoreB >= 3 then
        self.is_end = true
    end
end

function Pong:processKeyPressed(key)
    if key == 'w' then
        self.board1:startChangePosition(-1)
    elseif key == 's' then
        self.board1:startChangePosition(1)
    end
    if key == 'up' then
        self.board2:startChangePosition(-1)
    elseif key == 'down' then
        self.board2:startChangePosition(1)
    end
end

function Pong:checkGoal()
    if self.ball.location.x < 0 then
        self.scoreB = self.scoreB + 1
        self:newRound()
    end
    if self.ball.location.x > width then
        self.scoreA = self.scoreA + 1
        self:newRound()
    end
end

function Pong:newRound()
    self.ball.location = Vector:create(width / 2, height / 2)
    self.ball:applyForce(Vector:create(math.random(-2, 2), math.random(-2, 2)))
    self.ball:applyForce(Vector:create(1, 0))
end


function Pong:checkPlatformOnBall()
    if (self.ball.location.x - self.ball.size < self.board1.location.x + 10) then
        if self.ball.location.y >= self.board1.location.y and
                self.ball.location.y <= self.board1.location.y + self.board1.size then
            local newVelocity = self.ball.velocity:copy()
            newVelocity.x = -newVelocity.x
            self.ball.velocity:add(newVelocity)
            self.ball.velocity:limit(1)
            self.ball:applyForce(self.board1.force)
        end
    end

    if (self.ball.location.x + self.ball.size > self.board2.location.x) then
        if self.ball.location.y >= self.board2.location.y and
                self.ball.location.y <= self.board2.location.y + self.board2.size then
            local newVelocity = self.ball.velocity:copy()
            newVelocity.x = -newVelocity.x
            self.ball.velocity:add(newVelocity)
            self.ball.velocity:limit(1)
            self.ball:applyForce(self.board2.force)
        end
    end
end

function Pong:processKeyReleased(key)
    if key == 'w' then
        self.board1:stopChangePosition(-1)
    elseif key == 's' then
        self.board1:stopChangePosition(1)
    end
    if key == 'up' then
        self.board2:stopChangePosition(-1)
    elseif key == 'down' then
        self.board2:stopChangePosition(1)
    end
end