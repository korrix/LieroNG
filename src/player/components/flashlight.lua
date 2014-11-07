FlashlightComponent = Class {__includes = Component}

-- TODO Directional flashlight
function FlashlightComponent:init(world, x, y)
    self.light = world.newLight(x, y, 255, 127, 63, 500)
    self.light.setGlowStrength(0.1)
    self.light.setSmooth(0.5)

    self.body = world.newCircle(x, y, PLAYER_RADIUS)
end

function FlashlightComponent:update(player, dt)
    self.light.setPosition(player.x, player.y)
    self.body.setX(player.x)
    self.body.setY(player.y)
end
