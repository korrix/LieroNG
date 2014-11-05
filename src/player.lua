Player = Class {}

local cameraMoveSoftness = 5

function Player:init()
    self.camera = Camera(0, 0)
end

function Player:create_body(world, x, y)
    self.body = LP.newBody(world, x, y, "dynamic")
    self.body:setFixedRotation(true)
    self.shape = LP.newCircleShape(12)
    self.fixture = LP.newFixture(self.body, self.shape, 1)
    self.fixture:setFriction(0.3)
    self.fixture:setRestitution(0.4)
end

function Player:update(dt)
    local camX, camY = self.camera:pos()
    local newX = camX - (camX - self.body:getX()) * dt * cameraMoveSoftness
    local newY = camY - (camY - self.body:getY()) * dt * cameraMoveSoftness
    self.camera:lookAt(newX, newY)
end

function Player:draw()
    LG.setColor(255, 0, 0, 255)
    LG.circle("fill", self.body:getX(), self.body:getY(), self.shape:getRadius())
    LG.setColor(255, 255, 255, 255)
end

function Player:move_right()
    self.body:applyForce(400, 0)
end

function Player:move_left()
    self.body:applyForce(-400, 0)
end

function Player:look_up()
end

function Player:look_down()
end

function Player:jump()
    -- TODO Proper jumping
    self.body:applyLinearImpulse(0, 30)
end

function Player:shoot()
end

function Player:rope()
end
