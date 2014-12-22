HUD = Class {}

local GS = 18 -- Grid size

function HUD:init(player)
    self.vars = player.hud_variables

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

    local player_life = self.vars.life()

    local bar_size   = self.vars.round_size() * GS
    local load_level = math.clamp(self.vars.load_level(), 0, 1) * bar_size

    local life = bar_size * player_life / 100
    local life_c = player_life * 255 / 100
    LG.setColor(255 - life_c, life_c, 0, 255)

    LG.rectangle("line", GS - 1, Height - 3.5*GS - 1, bar_size + 2, GS + 2)
    LG.rectangle("fill", GS, Height - 3.5*GS, life, GS)

    LG.setColor(255, 255, 255, 255)
    local ammo = self.vars.ammo() + 1
    _.each(_.range(0, self.vars.round_size()), function(i)
        local mode = i < self.vars.ammo() and "fill" or "line"
        local pos = GS * (i + 1.5)
        LG.circle(mode, pos, Height - 1.5*GS, GS / 4)
    end)

    if load_level > 0 then
        LG.rectangle("line", GS - 1, Height - 2*GS - 1, load_level + 2, GS + 2)
    end

    LG.setColor(255,255,255,255)
end
