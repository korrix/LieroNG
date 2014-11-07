--- Main game stage.
require("src.player")
require("src.world")

local game = {}

local world  = nil
local player = nil

local lightMouse = nil -- debug only

function game:init()
    world = World(Level.testmap)

    local c_physics = PhysicsComponent(world.physics, 48, 48)
    local c_light   = FlashlightComponent(world.light, 48, 48)
    local c_camera  = CameraComponent()
    player = Player({c_physics, c_light, c_camera})
    world:set_camera(c_camera:get_camera())

    lightMouse = world.light.newLight(0, 0, 255, 127, 63, 300)
    lightMouse.setGlowStrength(0.3)
end

function game:update(dt)
    world:update(dt)
    player:update(dt)
    -- hud:update() - TODO

    lightMouse.setPosition(world.mouse.x, world.mouse.y)
end

function game:draw()
    LG.clear()
    world:draw({player})
    -- hud:draw() - TODO
end

function game:keypressed(key, code)

end

function game:mousepressed(x, y, button)

end

function game:mousereleased(x, y, button)

end

return game
