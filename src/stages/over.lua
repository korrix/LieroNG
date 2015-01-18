require("src.snake")

local over = Gamestate.new()

local FONT = Font.proggy[36]
local FONT2 = Font.proggy[36*4]

local snake = nil

function over:enter(from, score1, score2)
    self.score1 = score1
    self.score2 = score2

    snake = Snake()

    Timer.addPeriodic(0.01, function ()
        snake:step()
    end)
end

function over:update(dt)
    Timer.update(dt)
end

function over:draw()
    LG.clear()
    love.postshader.setBuffer("render")

    LG.setColor(255,255,255)

    snake:draw()

    love.postshader.addEffect("bloom", 3.0, 3.0)
    love.postshader.addEffect("scanlines")
    love.postshader.draw()

    LG.setFont(FONT2)
    LG.printf(tostring(self.score1)..":"..tostring(self.score2), 0, Height/2 - 96, Width, 'center')

    LG.setFont(FONT)
    LG.printf('Game is over.\nPress any key to exit.', 0, Height/2, Width, 'center')
end


function over:keypressed(key, code)
    if key == "up" then snake.direction = 0
    elseif key == "right" then snake.direction = 1
    elseif key == "down" then snake.direction = 2
    elseif key == "left" then snake.direction = 3
    else love.event.quit() end
end

return over
