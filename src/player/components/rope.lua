RopeComponent = Class {__includes = Component}

local RopeState = {inactive = -1, midair = 0, active = 1}
local ROPE_LENGTH = 150

function RopeComponent:init(world, player_body)
    self.length      = ROPE_LENGTH
    self.direction   = 0
    self.state       = RopeState.inactive
    self.player_body = player_body

    self.body = LP.newBody(world, 0, 0, "dynamic")
    self.body:setFixedRotation(true)
    self.body:setBullet(true)
    self.shape = LP.newCircleShape(PLAYER_RADIUS / 6)
    self.fixture = LP.newFixture(self.body, self.shape, 1)

    self.fixture:setUserData({type = "rope", collision = nil})

    self.rope_joint = nil
    self:catch()


    Signal.register("key:rope", function ()
        self:trigger()
    end)

    Signal.register("key:jump", function ()
        if self.state == RopeState.active then self:catch() end
    end)
end

function RopeComponent:getInactive()
    return Vector(self.player_body:getX(), self.player_body:getY()) - Vector(0, 2 * PLAYER_RADIUS):rotated(self.direction)
end

function RopeComponent:throw()
    self.state = RopeState.midair
    self.body:setActive(true)
    local vec = Vector(0, -10):rotated(self.direction)
    self.body:applyLinearImpulse(vec.x, vec.y)
end

function RopeComponent:catch()
    self.body:setActive(false)
    if self.rope_joint then
        self.rope_joint:destroy()
    end

    self.rope_joint = LP.newRopeJoint(self.player_body, self.body,
                                      self.player_body:getX(), self.player_body:getY(),
                                      self:getInactive().x, self:getInactive().y, ROPE_LENGTH, false)
    self.state = RopeState.inactive
end

function RopeComponent:trigger()
    if self.state == RopeState.inactive then
        self:throw()
    elseif self.state == RopeState.midair then
        self:catch()
    elseif self.state == RopeState.active then
        self:catch()
        -- self:throw()
        Timer.add(0.1, function () self:throw() end)
    end
end

function RopeComponent:update_inactive(player)
    self.body:setX(self:getInactive().x)
    self.body:setY(self:getInactive().y)
    self.body:setLinearVelocity(0, 0)
end

function RopeComponent:update_midair(player)
    local a_obj = self.fixture:getUserData()
    if a_obj.collision then
        -- Destroy rope joint
        self.body:setActive(false)

        -- Create swing joint
        local vec  = a_obj.collision.position
        local bvec = Vector(self.player_body:getX(), self.player_body:getY())

        local length = math.min(vec:dist(bvec), ROPE_LENGTH)

        self.rope_joint:destroy()
        self.rope_joint = LP.newRopeJoint(
            self.player_body, a_obj.collision.body,
            bvec.x, bvec.y, vec.x, vec.y, length, true)

        -- Set the marker position
        self.body:setX(vec.x)
        self.body:setY(vec.y)

        -- Clear the colision
        a_obj.collision = nil
        self.fixture:setUserData(a_obj)

        self.state = RopeState.active
    end
end

function RopeComponent:update_active(player)
    self.body:setLinearVelocity(0, 0)
end

function RopeComponent:update(player, dt)
    self.direction = -player.direction

    if self.state == RopeState.inactive then
        self:update_inactive(player)
    elseif self.state == RopeState.midair then
        self:update_midair(player)
    elseif self.state == RopeState.active then
        self:update_active(player)
    end
end

function RopeComponent:draw(player)
    LG.setColor(0, 0, 255, 255)
    LG.circle("fill", self.body:getX(), self.body:getY(), PLAYER_RADIUS / 3)
    LG.line(player.x, player.y, self.body:getX(), self.body:getY())
    LG.setColor(255, 255, 255, 255)
end
