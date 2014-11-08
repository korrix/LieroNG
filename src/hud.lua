HUD = Class {}

function HUD:init()
    self.fps = 0
    self.text = {}
    Signal.register("hud:text", function(newtext)
        if #self.text > 30 then _.pop(self.text) end
        _.unshift(self.text, newtext)
    end)
end

function HUD:update(dt)
    self.fps = love.timer.getFPS()
end

function HUD:draw()
    local t = _.join(self.text, '\n')
    LG.print("Current FPS: " .. tostring(self.fps) .. "\n" .. t, 12, 10)
end
