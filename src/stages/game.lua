--- Main game stage.
require("src.player")
require("src.controller")
require("src.world")
require("src.hud")

local game = {}

local world      = nil
local player     = nil
local controller = nil
local hud        = nil

local lightMouse = nil -- debug only

function game:init()
    world = World(Level.testmap)
    hud   = HUD()

    local c_physics = Component.physics(world.physics, 48, 48)
    local c_light   = Component.flashlight(world.light, 48, 48)
    local c_rope    = Component.rope(world.physics, c_physics.body)
    local c_camera  = Component.camera()
    local c_sprite  = Component.sprite()
    player = Player({c_physics, c_sprite, c_rope, c_light, c_camera})

    controller = Controller()
    world:set_camera(c_camera:get_camera())

    -- debug only
    lightMouse = world.light.newLight(0, 0, 255, 127, 63, 300)
    lightMouse.setGlowStrength(0.3)
end

function game:update(dt)
    controller:update(dt)
    world:update(dt)
    player:update(dt)
    hud:update(dt)

    lightMouse.setPosition(world.mouse.x, world.mouse.y)
end

function game:draw()
    LG.clear()
    world:draw({player})
    hud:draw()
end

function game:keypressed(key, code)
    controller:keypressed(key)
end

function game:keyreleased(key, code)
    controller:keyreleased(key)
end

function game:mousepressed(x, y, button)

end

function game:mousereleased(x, y, button)

end

return game
