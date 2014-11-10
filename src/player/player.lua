Player = Class {}

function Player:init(components)
    self.x = 0
    self.y = 0
    self.direction = 3.14 / 45

    self.components = components

    Signal.register('key:up', function()
        Timer.tween(0.2, self, {direction = self.direction + 3.14 / 45})
    end)

    Signal.register('key:down', function()
        Timer.tween(0.2, self, {direction = self.direction - 3.14 / 45})
    end)
end

function Player:register_component(component)
    _.push(self.components, component)
    return component
end

function Player:update(dt)
    _.each(self.components, function(component)
        component:update(self, dt)
    end)
end

function Player:draw()
    _.each(self.components, function(component)
        component:draw(self)
    end)
end



-- function Player:look_up()
-- end

-- function Player:look_down()
-- end

-- function Player:shoot()
-- end

-- function Player:rope()
-- end
