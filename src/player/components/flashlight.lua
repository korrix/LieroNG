require("src.player.component")

FlashlightComponent = Class {__includes = Component}

local FLASHLIGHT_RANGE = 500

function FlashlightComponent:init(world, x, y)
    self.light = world.newLight(x, y, 255, 127, 63, FLASHLIGHT_RANGE)
    self.light.setGlowStrength(0.1)
    self.light.setSmooth(0.5)

    self.body = world.newCircle(x, y, PLAYER_RADIUS)
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

function FlashlightComponent:update(player, dt)
    self.light.setPosition(player.x, player.y)
    self.light.setDirection(player.direction)

    self.body.setX(player.x)
    self.body.setY(player.y)
end

return FlashlightComponent
