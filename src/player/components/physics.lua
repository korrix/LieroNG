require("src.player.component")

PhysicsComponent = Class {__includes = Component}

local JUMP_SIZE = 64

function PhysicsComponent:init(player)
    player:register_component(self)
    self.player = player

    self.body = LP.newBody(player.world.physics, player.x, player.y, "dynamic")
    self.body:setFixedRotation(true)
    self.shape = LP.newCircleShape(PLAYER_RADIUS - 0.5)
    self.fixture = LP.newFixture(self.body, self.shape, 1)
    self.fixture:setFriction(0.3)
    self.fixture:setRestitution(0.4)
    self.fixture:setCategory(player.id)

    self.canJump = false
    self.jumpDirection = Vector(0, 0)

    self.fixture:setUserData({
        type = "player",
        id = player.id,

        setCanJump = function (canJump)
            self.canJump = canJump
        end,

        setJumpDirection = function (x, y)
            self.jumpDirection = Vector(x, y):normalized() * JUMP_SIZE
        end
    })

    player:register('key:right', function()
        self:move_right()
    end)

    player:register('key:left', function()
        self:move_left()
    end)

    player:register('key:jump', function()
        self:jump()
    end)

    player:register('action:fire', function(vec)
        local v = -vec / 100
        self.body:applyLinearImpulse(v.x, v.y)
    end)
end

function PhysicsComponent:update(dt)
    self.player.x = self.body:getX()
    self.player.y = self.body:getY()
end

function PhysicsComponent:move_right()
    self.body:applyForce(100, 0)
end

function PhysicsComponent:move_left()
    self.body:applyForce(-100, 0)
end

function PhysicsComponent:jump()
    if self.canJump then
        self.body:applyLinearImpulse(self.jumpDirection.x, self.jumpDirection.y)
    end
end

return PhysicsComponent
