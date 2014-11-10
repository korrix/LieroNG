Player = Class {}

function Player:init(components)
    self.x = 0
    self.y = 0
    self.direction = -math.pi / 4

    self.components = components

    local function tween_direction(new_direction)
        Timer.tween(0.2, self, {direction = new_direction})
    end

    Signal.register('key:up', function()
        tween_direction(self.direction - math.pi / 45)
    end)

    Signal.register('key:down', function()
        tween_direction(self.direction + math.pi / 45)
    end)

    Signal.register('key:right_press', function()
        if self.direction < math.pi then
            self.direction = 2 * math.pi - self.direction
        end
    end)

    Signal.register('key:left_press', function()
        if self.direction >= math.pi then
            self.direction = 2 * math.pi - self.direction-- math.pi + self.direction
        end
    end)
end

function Player:register_component(component)
    _.push(self.components, component)
    return component
end

function Player:update(dt)
    self.direction = self.direction % (2 * math.pi)
    Signal.emit("hud:text", self.idrection)
    _.each(self.components, function(component)
        component:update(self, dt)
    end)
end

function Player:draw()
    _.each(self.components, function(component)
        component:draw(self)
    end)
end
