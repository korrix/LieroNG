--- Main game stage.
require("src.player")
require("src.world")
require("src.hud")

local game = {}

local game_view = nil
local world     = nil
local hud       = nil

local player1   = nil
local player2   = nil

function create_player(world, x, y, w, s, a, d, f, g, h, q)
    local player =  Player(world, x, y)
    local c_physics = Component.physics(player)
    Component.rope(player, c_physics.body)
    Component.flashlight(player)
    Component.sprite(player) -- TODO: Player sprites
    Component.weapon(player)
    Component.laser_sight(player)
    Component.controller(player, w, s, a, d, f, g, h, q)

    return player
end

function game:init()
    world   = World(Level.testmap)
    player1 = create_player(world, 24 * 2.5 , 24 * 2, 'w', 's', 'a', 'd', 'f', 'g', 'h', 'q')
    player2 = create_player(world, 24 * 45.5, 24 * 2, 'up', 'down', 'left', 'right', 'kp1', 'kp2', 'kp3', 'kp0')
    hud     = HUD()

    game_view = LG.newCanvas(2048, 2048)

    Signal.register("action:over", function ()
        Gamestate.switch(Stage.over, player1.kills, player2.kills)
    end)

    Sound.ussr:play()
end

function game:update(dt)
    world:update(dt)

    player1:update(dt)
    player2:update(dt)

    hud:update(dt)
end

function game:draw()
    LG.clear()
    game_view:clear()

    love.postshader.setBuffer("render")
        world:draw(player1, player2)
        love.postshader.addEffect("bloom", 2.0, 2.0)
        love.postshader.addEffect("scanlines")
    love.postshader.draw(game_view)

    LG.setScissor(0, 0, Width/2, Height)
    LG.push()
        LG.translate(Width/4 - player1.x, Height/2 - player1.y)
        LG.draw(game_view)
    LG.pop()
    LG.setScissor()

    LG.setScissor(Width/2, 0, Width/2, Height)
    LG.push()
        LG.translate(3*Width/4 - player2.x, Height/2 - player2.y)
        LG.draw(game_view)
    LG.pop()
    LG.setScissor()

    hud:draw(player1, player2)
end

function game:keypressed(key, code)
    if key == "escape" then love.event.quit() end

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
