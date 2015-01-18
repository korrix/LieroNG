require("src.player.component")

RopeComponent = Class {__includes = Component}

local RopeState = {inactive = -1, midair = 0, active = 1}
local ROPE_LENGTH    = 250
local THROW_STRENGTH = 1000
local CLIMB_DRAG     = 1.3

function RopeComponent:init(player, player_body)
    player:register_component(self)
    self.player = player
    local world = player.world.physics

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
    self.spot = nil

    self:catch()

    player:register("key:rope", function ()
        self:trigger()
    end)

    player:register("key:jump", function ()
        if self.state == RopeState.active then self:catch() end
    end)

    player:register("key:climb", function ()
        if self.state == RopeState.active and self.spot then
            local antigravity = -Vector(world:getGravity()) * self.player_body:getMass()
            local direction = self.spot - Vector(self.player_body:getX(), self.player_body:getY())
            local rope_pull = direction:normalized() * antigravity:len() * CLIMB_DRAG
            self.player_body:applyForce(rope_pull:unpack())
        end
    end)
end

function RopeComponent:respawn()
    self.length      = ROPE_LENGTH
    self.direction   = 0
    self.state       = RopeState.inactive
end

function RopeComponent:getInactive()
    return Vector(self.player_body:getX(), self.player_body:getY()) - Vector(0, 2 * PLAYER_RADIUS):rotated(self.direction)
end

function RopeComponent:throw()
    self.state = RopeState.midair
    self.body:setActive(true)
    local vec = Vector(0, -THROW_STRENGTH):rotated(self.direction)
    self.body:applyForce(vec.x, vec.y)
end

function RopeComponent:catch()
    self.spot = nil
    self:update_inactive()
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
        Timer.add(0.1, function () self:throw() end)
    end
end

function RopeComponent:update_inactive()
    self.body:setX(self:getInactive().x)
    self.body:setY(self:getInactive().y)
    self.body:setLinearVelocity(self.player_body:getLinearVelocity())
end

function RopeComponent:update_midair()
    local a_obj = self.fixture:getUserData()
    if a_obj.collision then
        -- Destroy rope joint
        self.body:setActive(false)

        -- Create swing joint
        self.spot  = a_obj.collision.position
        local bvec = Vector(self.player_body:getX(), self.player_body:getY())

        self.rope_joint:destroy()
        self.rope_joint = LP.newRopeJoint(
            self.player_body, a_obj.collision.body,
            bvec.x, bvec.y, self.spot.x, self.spot.y, ROPE_LENGTH, true)

        -- Set the marker position
        self.body:setX(self.spot.x)
        self.body:setY(self.spot.y)

        -- Clear the colision
        a_obj.collision = nil
        self.fixture:setUserData(a_obj)

        self.state = RopeState.active
    end
end

function RopeComponent:update_active()
    self.body:setLinearVelocity(0, 0)
end

function RopeComponent:update(dt)
    self.direction = -self.player.direction

    if self.state == RopeState.inactive then
        self:update_inactive()
    elseif self.state == RopeState.midair then
        self:update_midair()
    elseif self.state == RopeState.active then
        self:update_active()
    end
end

function RopeComponent:draw()
    LG.setColor(0, 128, 0, 255)
    LG.circle("fill", self.body:getX(), self.body:getY(), PLAYER_RADIUS / 3)
    LG.line(self.player.x, self.player.y, self.body:getX(), self.body:getY())
    LG.setColor(255, 255, 255, 255)
end

return RopeComponent
