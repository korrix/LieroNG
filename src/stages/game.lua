--- Main game stage.
require("src.player")
require("src.world")
require("src.hud")

local game = {}

local world        = nil
local local_player = nil
local players      = {}
local hud          = nil

function create_player(world, x, y, w, s, a, d, f, g, h, q)
    local player =  Player(world, x, y)
    local c_physics = Component.physics(player)
    Component.rope(player, c_physics.body)
    Component.flashlight(player)
    Component.sprite(player) -- TODO: Player sprites
    Component.weapon(player)
    Component.laser_sight(player)
    Component.controller(player, w, s, a, d, f, g, h, q)
    _.push(players, player)
    return player
end

function game:init()
    world        = World(Level.testmap)
    local_player = create_player(world, 64, 64, 'w', 's', 'a', 'd', 'f', 'g', 'h', 'q')
    hud          = HUD(local_player)

    create_player(world, 192, 64, 'up', 'down', 'left', 'right', 'kp1', 'kp2', 'kp3', 'kp0')

    local c_camera = Component.camera(local_player)
    -- controller = Controller(local_player.id, 'w', 's', 'a', 'd', 'f', 'g', 'h')
    world:set_camera(c_camera:get_camera())
end

function game:update(dt)
    world:update(dt)

    _.each(players, function (player)
        player:update(dt)
    end)

    hud:update(dt)
end

function game:draw()
    LG.clear()
    world:draw(players, hud)
end

function game:keypressed(key, code)
    if key == "escape" then
        love.event.quit()
    end

    _.each(players, function (player)
        player:keypressed(key)
    end)
end

function game:keyreleased(key, code)
    _.each(players, function (player)
        player:keyreleased(key)
    end)
end

function game:mousepressed(x, y, button)
end

function game:mousereleased(x, y, button)
end

return game
