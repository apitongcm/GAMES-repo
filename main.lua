push = require 'push'

--third commit 
--adding the class module in the main code
Class = require 'class'
--adding the bird class 
require 'Bird'

--sixth commit
--adding pipe to the game 
require 'Pipe'

--constant variables 
WINDOW_WIDTH  = 1280 
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288 

local background = love.graphics.newImage('background.png')
local backgroundScroll = 0

local ground = love.graphics.newImage('ground.png')
local groundScroll = 0 

--second commit adding scrolling speed for the background
--speed at which we should scroll our image
local BACKGROUND_SCROLL_SPEED = 30 
local GROUND_SCROLL_SPEED = 60
local BACKGROUND_LOOPING_POINT = 413

--third commit define bird sprite
local bird = Bird()

--sixth commit: table of spawning Pipes
--empty array
local pipes = {}
--timer for spawning pipes
local spawnTimer = 0 

function love.load()
    --init nearest-neighbor filter
    love.graphics.setDefaultFilter('nearest', 'nearest')

    --app window title 
    love.window.setTitle('Fluffy Bird')

    --init virtual resolution 
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true, 
        fullscreen = false, 
        resizable = true
    })

    --sixth commit
    love.keyboard.keysPressed = {}
end 

function love.resize(w,h)
    push:resize(w,h)
end

function love.keypressed(key)
    --sixth commit 
    love.keyboard.keysPressed[key] = true

    if key == 'escape' then 
        love.event.quit()
    end
end

--fifth commit 
-- keyboard was pressed
function love.keyboard.wasPressed(key)
    if love.keyboard.keysPressed[key] then 
        return true
    else 
        return false 
    end
end

-- second commit 
--adding love.update for the background
function love.update(dt)
    --scroll background by preset speed * dt 
    backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED * dt) % BACKGROUND_LOOPING_POINT

    groundScroll = (groundScroll + GROUND_SCROLL_SPEED * dt) % VIRTUAL_WIDTH


    --sixth commit 
    spawnTimer = spawnTimer + dt 
    --spawn a new Pipe if timer is past 3 seconds
    if spawnTimer > 3 then 
        table.insert(pipes,Pipe())
        print('Added new Pipe!')
        spawnTimer = 0 
    end

    --fourth commit 
    --adding velocity/gravity to the bird 
    bird:update(dt)

    --sixth commit : update every pipe in the scene
    for k, pipe in pairs(pipes) do 
        pipe:update(dt)

        --if pipe no longer visible, remove from the scene
        if pipe.x < -pipe.width then 
            table.remove(pipes, k)
        end
    end

    

    --reset input table
    love.keyboard.keysPressed = {}
 
end


function love.draw()
    push:start()
    --for the second commit 
    --we changes the x position of the background and ground into
    -- -backgroundScroll and -groundScroll


    --draw the background starting from top left
    love.graphics.draw(background,-backgroundScroll,0)

    --sixth commit: render all the pipes 
    for k, pipe in pairs(pipes) do 
        pipe:render()
    end

    --draw the ground on top of the background
    love.graphics.draw(ground,-groundScroll, VIRTUAL_HEIGHT - 16)
    
    --third commit 
    --render the bird image 
    bird:render()


    push:finish()
end
