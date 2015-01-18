require("src.snake")

local over = Gamestate.new()

local FONT = Font.proggy[36]
local FONT2 = Font.proggy[36*4]

function over:init()
    self.snake = Snake()

    Timer.addPeriodic(0.01, function ()
        self.snake:step()
    end)

    love.audio.stop()
    Sound.core:play()
end

function over:enter(from, score1, score2)
    self.score1 = score1
    self.score2 = score2
end

function over:update(dt)
    -- Timer.update(dt)
end

function over:draw()
    LG.clear()
    love.postshader.setBuffer("render")

    LG.setColor(255,255,255)

    self.snake:draw()

    love.postshader.addEffect("bloom", 3.0, 3.0)
    love.postshader.addEffect("scanlines")
    love.postshader.draw()

    LG.setFont(FONT2)
    LG.printf(tostring(self.score1)..":"..tostring(self.score2), 0, Height/2 - 96, Width, 'center')

    LG.setFont(FONT)
    LG.printf('Game is over.\nPress Esc to exit.', 0, Height/2, Width, 'center')
end


function over:keypressed(key, code)
    if key == "up" then self.snake.direction = 0
    elseif key == "right" then self.snake.direction = 1
    elseif key == "down" then self.snake.direction = 2
    elseif key == "left" then self.snake.direction = 3
    elseif key == "escape" then love.event.quit() end
end

return over
