Player = Class {}

PlayerIdFactory = 1

function Player:init(world)
    self.world = world

    self.x = 64
    self.y = 64
    self.direction = -math.pi / 4

    self.components = {}

    self.id = PlayerIdFactory
    PlayerIdFactory = PlayerIdFactory + 1 -- FIXME: Very nasty solution

    local function tween_direction(new_direction)
        Timer.tween(0.2, self, {direction = new_direction})
    end

    Signal.register('key:up', function()
        tween_direction(self.direction - math.pi / 90)
    end)

    Signal.register('key:down', function()
        tween_direction(self.direction + math.pi / 90)
    end)

    Signal.register('key:right_press', function()
        if self.direction < math.pi then
            self.direction = 2 * math.pi - self.direction
        end
    end)

    Signal.register('key:left_press', function()
        if self.direction >= math.pi then
            self.direction = 2 * math.pi - self.direction
        end
    end)
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
