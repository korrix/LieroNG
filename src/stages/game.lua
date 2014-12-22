--- Main game stage.
require("src.player")
require("src.controller")
require("src.world")
require("src.hud")

local game = {}

local world        = nil
local local_player = nil
local players      = {}
local controller   = nil
local hud          = nil

function create_player(world, x, y)
    local player =  Player(world, x, y)
    local c_physics = Component.physics(player)
    Component.rope(player, c_physics.body)
    Component.flashlight(player)
    Component.sprite(player) -- TODO: Player sprites
    Component.weapon(player)
    Component.laser_sight(player)
    _.push(players, player)
    return player
end

function game:init()
    world        = World(Level.testmap)
    local_player = create_player(world, 64, 64)
    hud          = HUD(local_player)
create_player(world, 192, 64)
    local c_camera = Component.camera(local_player)
    controller = Controller(local_player.id)
    world:set_camera(c_camera:get_camera())
end

function game:update(dt)
    controller:update(dt)
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
