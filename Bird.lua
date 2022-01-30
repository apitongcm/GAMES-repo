--third commit 
-- adding the class of Bird
Bird = Class{}

--fouth commit 
--adding gravity to the game 
local GRAVITY = 20

function Bird:init()
    --third commit 
    -- adding the image of the bird on the game 
    self.image = love.graphics.newImage('bird.png')
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()

    --third commit 
    --adding the starting position of the bird
    self.x = VIRTUAL_WIDTH / 2 - (self.width /2 )
    self.y = VIRTUAL_HEIGHT / 2 - (self.height / 2 )  

    --fourth commit 
    --adding starting velocity of the bird
    self.dy = 0 
end

--fourth commit 
--applying gravity to velocity
function Bird:update(dt)
    self.dy = self.dy + GRAVITY * dt 

    if love.keyboard.wasPressed('space') then 
        self.dy = -5
    end

    self.y = self.y + self.dy
end

function Bird:render()
    love.graphics.draw(self.image, self.x, self.y)
end