--- Main game stage.
require("src.player")
require("src.world")
require("src.hud")

local game = {}

local world   = nil
local hud     = nil

local player1 = nil
local cam1    = nil

local player2 = nil
local cam2    = nil

function create_player(world, x, y, w, s, a, d, f, g, h, q)
    local player =  Player(world, x, y)
    local c_physics = Component.physics(player)
    local c_camera = Component.camera(player)
    Component.rope(player, c_physics.body)
    Component.flashlight(player)
    Component.sprite(player) -- TODO: Player sprites
    Component.weapon(player)
    Component.laser_sight(player)
    Component.controller(player, w, s, a, d, f, g, h, q)

    return player, c_camera
end

function game:init()
    world         = World(Level.testmap)
    player1, cam1 = create_player(world, 64, 64, 'w', 's', 'a', 'd', 'f', 'g', 'h', 'q')
    player2, cam2 = create_player(world, 192, 64, 'up', 'down', 'left', 'right', 'kp1', 'kp2', 'kp3', 'kp0')

    hud          = HUD(player1, player2)

    world:set_camera(cam1:get_camera())
end

function game:update(dt)
    world:update(dt)

    player1:update(dt)
    player2:update(dt)

    hud:update(dt)
end

function game:draw()
    LG.clear()
    world:draw(player1, player2, hud)
end

function game:keypressed(key, code)
    if key == "escape" then
        love.event.quit()
    end

    player1:keypressed(key)
    player2:keypressed(key)
end

function game:keyreleased(key, code)
    player1:keyreleased(key)
    player2:keyreleased(key)
end

function game:mousepressed(x, y, button)
end

function game:mousereleased(x, y, button)
end

return game
