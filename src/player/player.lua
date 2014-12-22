Player = Class {}

PlayerIdFactory = 1

local RESPAWN_TIME = 2.5
function Player:init(world, x, y)
    self.world = world

    self.life   = 100
    self.deaths = 0
    self.kills  = 0

    self.x = x
    self.y = y
    self.spawn_x = x
    self.spawn_y = y

    self.direction = -math.pi / 4

    self.components = {}
    self.hud_variables = {}

    self.id = PlayerIdFactory
    PlayerIdFactory = PlayerIdFactory + 1 -- FIXME: Very nasty solution

    local function tween_direction(new_direction)
        Timer.tween(0.2, self, {direction = new_direction})
    end

    self:register('key:up', function()
        tween_direction(self.direction - math.pi / 90)
    end)

    self:register('key:down', function()
        tween_direction(self.direction + math.pi / 90)
    end)

    self:register('key:right_press', function()
        if self.direction < math.pi then
            self.direction = 2 * math.pi - self.direction
        end
    end)

    self:register('key:left_press', function()
        if self.direction >= math.pi then
            self.direction = 2 * math.pi - self.direction
        end
    end)

    self:register('action:hit', function (cause, frag)
        self.life = self.life - frag
        if self.life < 0 then
            self.life = 0
            self:die()
            Signal.emit('action:killed', cause)
        end
    end)

    self:register('action:killed', function ()
        self.kills = self.kills + 1
    end)

    self:register_hud({
        life   = function () return self.life end,
        kills  = function () return self.kills end,
        deaths = function () return self.deaths end
    })
end

function Player:die()
    self.deaths = self.deaths + 1
    _.each(self.components, function(component)
        component:respawn()
    end)
    Timer.tween(RESPAWN_TIME, self, {life = 100})
end

function Player:register(signal, action)
    Signal.register(signal, function(id, ...)
        if id == self.id then
            action(...)
        end
    end)
end

function Player:emit(signal, ...)
    Signal.emit(signal, self.id, ...)
end

function Player:register_hud(variables)
    _.extend(self.hud_variables, variables)
end

function Player:register_component(component)
    _.push(self.components, component)
end

function Player:update(dt)
    self.direction = self.direction % (2 * math.pi)
    _.each(self.components, function(component)
        component:update(dt)
    end)
end

function Player:draw()
    _.each(self.components, function(component)
        component:draw()
    end)
end
