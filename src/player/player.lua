Player = Class {}

PlayerIdFactory = 1

function Player:init(world, x, y)
    self.world = world

    self.x = x
    self.y = y
    self.direction = -math.pi / 4

    self.components = {}

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
