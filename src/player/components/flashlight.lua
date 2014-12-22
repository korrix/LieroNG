require("src.player.component")

FlashlightComponent = Class {__includes = Component}

local FLASHLIGHT_RANGE = 500

function FlashlightComponent:init(player)
    player:register_component(self)
    self.player = player
    local world = player.world.light

    self.light = world.newLight(player.x, player.y, 255, 127, 63, FLASHLIGHT_RANGE)
    self.light.setGlowStrength(0.1)
    self.light.setSmooth(0.5)

    self.body = world.newCircle(player.x, player.y, PLAYER_RADIUS)
    self.light.setAngle(math.pi / 3)

    self.active = true

    Signal.register("key:flashlight_toggle", function()
        self.active = not self.active
        if self.active then
            self.light.setRange(FLASHLIGHT_RANGE)
        else
            self.light.setRange(0)
        end
    end)
end

function FlashlightComponent:update(dt)
    self.light.setPosition(self.player.x, self.player.y)
    self.light.setDirection(self.player.direction)

    self.body.setX(self.player.x)
    self.body.setY(self.player.y)
end

return FlashlightComponent
