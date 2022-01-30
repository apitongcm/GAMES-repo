Pipe = Class{}

--define and import the pipe image 
local PIPE_IMAGE = love.graphics.newImage('pipe.png')
local PIPE_SCROLL = -60

--initial state: define the position and width of the pipe 
function Pipe:init()
    self.x = VIRTUAL_WIDTH

    --set the Y to random value halfway below the screen
    --set the min height and the max height of the pipe
    self.y = math.random(VIRTUAL_HEIGHT / 4, VIRTUAL_HEIGHT - 10)

    self.width = PIPE_IMAGE:getWidth()
end

-- update the position x of the pipe. 
function Pipe:update(dt)
    self.x  = self.x + PIPE_SCROLL * dt
end

--render the pipe image. 
function Pipe:render()
    love.graphics.draw(PIPE_IMAGE, math.floor(self.x + 0.5), math.floor(self.y))
end
