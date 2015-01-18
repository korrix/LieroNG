HUD = Class {}

local GS = 18 -- Grid size

local FONT = Font.proggy[2 * GS]
local FONTB = Font.proggy[4 * GS]

function HUD:init()
    self.time = 120+56

    self.fps = 0
    self.text = {}
    Signal.register("hud:text", function(newtext)
        if #self.text > 30 then _.pop(self.text) end
        _.unshift(self.text, newtext)
    end)

    Timer.addPeriodic(1, function()
        if self.time > 0 then
            self.time = self.time - 1
        else
            Signal.emit("action:over")
        end
    end)
end

function HUD:update(dt)
    self.fps = love.timer.getFPS()
end

function HUD:draw_bars(v, side)

    local player_life = v.life()

    local bar_size   = v.round_size() * GS

    local offset = side == "right" and (Width - bar_size - 2*GS)  or 0

    local load_level = math.clamp(v.load_level(), 0, 1) * bar_size

    local life = bar_size * player_life / 100
    local life_c = player_life * 255 / 100

    local ammo = v.ammo() + 1

    LG.setColor(255 - life_c, life_c, 0, 255)

    LG.rectangle("line", offset + GS - 1, Height - 3.5*GS - 1, bar_size + 2, GS + 2)
    LG.rectangle("fill", offset + GS, Height - 3.5*GS, life, GS)

    LG.setColor(255, 255, 255, 255)

    _.each(_.range(0, v.round_size()), function(i)
        local mode = i < v.ammo() and "fill" or "line"
        local pos = GS * (i + 1.5)
        LG.circle(mode, offset + pos, Height - 1.5*GS, GS / 4)
    end)

    if load_level > 0 then
        LG.rectangle("line", offset + GS - 1, Height - 2*GS - 1, load_level + 2, GS + 2)
    end

    LG.setColor(255,255,255,200)
    LG.print('Player' .. tostring(v.id()) .. ' '
                       .. tostring(v.kills()) .. 'K / '
                       .. tostring(v.deaths()) .. 'D',
            offset + GS, Height - 4.9*GS - 1)
end

function HUD:draw(player1, player2)
    local time = string.format("%.2d:%.2d", self.time / 60, self.time % 60)
    LG.setFont(FONTB)
    LG.setColor(255,255,255,64)
    LG.print(time, Width/2 - FONTB:getWidth(time)/2, GS)

    LG.setColor(255,255,255,24)
    LG.rectangle("fill", Width/2-1, 2*GS + FONTB:getHeight(time), 2, Height)

    LG.setFont(FONT)
    local t = _.join(self.text, '\n')
    LG.print("FPS: " .. tostring(self.fps) .. "\n" .. t, GS, GS)

    self:draw_bars(player1.hud_variables, "left")
    self:draw_bars(player2.hud_variables, "right")
end
