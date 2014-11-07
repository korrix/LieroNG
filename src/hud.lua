HUD = Class {}

function HUD:init()
    self.fps = 0
end

function HUD:update(dt)
    self.fps = love.timer.getFPS()
end

function HUD:draw()
    LG.print("Current FPS: " .. tostring(self.fps), 12, 10)
end
