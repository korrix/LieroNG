PhysicsComponent = Class {__includes = Component}

local JUMP_SIZE = 64

function PhysicsComponent:init(world, x, y)
    self.body = LP.newBody(world, x, y, "dynamic")
    self.body:setFixedRotation(true)
    self.shape = LP.newCircleShape(PLAYER_RADIUS - 0.5)
    self.fixture = LP.newFixture(self.body, self.shape, 1)
    self.fixture:setFriction(0.3)
    self.fixture:setRestitution(0.4)

    self.canJump = false
    self.jumpDirection = Vector(0, 0)

    self.fixture:setUserData({
        type = "player",

        setCanJump = function (canJump)
            self.canJump = canJump
        end,

        setJumpDirection = function (x, y)
            self.jumpDirection = Vector(x, y):normalized() * JUMP_SIZE
        end
    })

    Signal.register('key:right', function()
        self:move_right()
    end)

    Signal.register('key:left', function()
        self:move_left()
    end)

    Signal.register('key:jump', function()
        self:jump()
    end)
end

function PhysicsComponent:update(player, dt)
    player.x = self.body:getX()
    player.y = self.body:getY()
end

function PhysicsComponent:move_right()
    self.body:applyForce(100, 0)
end

function PhysicsComponent:move_left()
    self.body:applyForce(-100, 0)
end

function PhysicsComponent:jump()
    -- TODO Proper jumping
    if self.canJump then
        self.body:applyLinearImpulse(self.jumpDirection.x, self.jumpDirection.y)
    end
end
