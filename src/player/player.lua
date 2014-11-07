Player = Class {}

function Player:init(components)
    self.x = 0
    self.y = 0

    self.components = components
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
    LG.setColor(255, 0, 0, 255)
    LG.circle("fill", self.x, self.y, PLAYER_RADIUS)
    LG.setColor(255, 255, 255, 255)
end



-- function Player:look_up()
-- end

-- function Player:look_down()
-- end

-- function Player:shoot()
-- end

-- function Player:rope()
-- end
