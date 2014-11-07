PhysicsComponent = Class {__includes = Component}

function PhysicsComponent:init(world, x, y)
    self.body = LP.newBody(world, x, y, "dynamic")
    self.body:setFixedRotation(true)
    self.shape = LP.newCircleShape(PLAYER_RADIUS)
    self.fixture = LP.newFixture(self.body, self.shape, 1)
    self.fixture:setFriction(0.3)
    self.fixture:setRestitution(0.4)
end

function PhysicsComponent:update(player, dt)
    player.x = self.body:getX()
    player.y = self.body:getY()
end

function PhysicsComponent:move_right()
    self.body:applyForce(400, 0)
end

function PhysicsComponent:move_left()
    self.body:applyForce(-400, 0)
end

function PhysicsComponent:jump()
    -- TODO Proper jumping
    self.body:applyLinearImpulse(0, -30)
end
