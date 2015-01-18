require("src.player.component")

LaserSightComponent = Class {__includes = Component}

local RANGE = 2000
function LaserSightComponent:init(player)
    player:register_component(self)
    self.player = player
    self.world = player.world.physics
end

function LaserSightComponent:update(dt)
end

local function draw_reflections(world, start, vend)
    local hits = {}
    local function callback(fixture, x, y, xn, yn, fraction)
        local userdata = fixture:getUserData()
        _.push(hits, {x = x, y = y, fraction = fraction, type = userdata.type})
        return 1
    end
    world:rayCast(start.x, start.y, vend.x, vend.y, callback)
    local first = _.min(hits, function(p) return p.fraction end) -- Box2D is unstable

    LG.setColor(255, 0, 0, 255)
    if type(first) == "table" then
        if first.type == "player" then
            LG.setColor(0, 255, 0, 255)
        end
        local vhit = Vector(first.x, first.y)
        LG.line(start.x, start.y, vhit.x, vhit.y)
    else
        LG.line(start.x, start.y, vend.x, vend.y)
    end
    LG.setColor(255, 255, 255, 255)
end

function LaserSightComponent:draw()
    local vstart = Vector(self.player.x, self.player.y)
    local vend = vstart + Vector(0, -RANGE):rotated(-self.player.direction)
    draw_reflections(self.world, vstart, vend, 255)
end

return LaserSightComponent
