--- Main game stage.
require("src.player")

local game = {}

local active_level  = nil
local world         = nil
local player        = nil

local GFORCE       = 9.81

function game:init()
    -- Choose level
    active_level = Level.testmap

    -- Initialize physics
    LP.setMeter(24)
    world = LP.newWorld(0 * LP.getMeter(), GFORCE * LP.getMeter(), true)
    active_level:initWorldCollision(world)

    -- Create player
    player = Player()
    player:create_body(world, 48, 48)

    -- Initialize scene background
    LG.setBackgroundColor(128, 128, 128)

    -- TODO Dynamic lighting system
end

function game:update(dt)
    world:update(dt)
    player:update(dt)

    -- hud:update() - TODO
    -- active_level:setDrawRange(tx, ty, Width, Height) - TODO

    -- TODO refactor
    local d = love.keyboard.isDown
    if d("w") then player:look_up() end
    if d("s") then player:look_down() end
    if d("a") then player:move_left() end
    if d("d") then player:move_right() end
    if d("f") then player:shoot() end
    if d("g") then
        if d("h") then player:rope() else player:jump() end
    end
end

function game:draw()
    player.camera:attach()
        LG.clear()
        active_level:draw()
        player:draw()
    player.camera:detach()

    -- hud:draw() - TODO
end

function game:keypressed(key, code)

end

function game:mousepressed(x, y, button)

end

function game:mousereleased(x, y, button)

end

return game
