require("src.player.component")

WeaponComponent = Class {__includes = Component}

local LOAD_LAG  = 0.5
local RELOAD_TIME = 1
local ROUND_SIZE = 12

local DAMAGE   = 10
local RANGE    = 10000
local BULLET_RADIUS = 2.5
local BULLET_LIFETIME = 10

function WeaponComponent:init(world)
    self.world  = world
    self.active = false
    self.radius = 10

    self.load_level = 0
    self.ammo = ROUND_SIZE

    self.bullets = {}

    Signal.register("key:trigger_press", function()
        self.active = true
    end)

    Signal.register("key:trigger_relase", function()
        self.active = false
    end)
end

function WeaponComponent:update(player, dt)
    self.player = player

    if self.load_level < LOAD_LAG then
        self.load_level = self.load_level + dt
    elseif self.active then
        self.load_level = 0
        self:shoot()
    end

    _.each(self.bullets, function(bullet)
        bullet.life = bullet.life - dt
        if bullet.life < 0 then
            bullet.body:destroy()
        end
    end)

    self.bullets = _.reject(self.bullets, function(bullet)
        return bullet.life < 0
    end)
end

function WeaponComponent:shoot()
    if self.ammo > 0 and self.player then
        self:fire()
        self.ammo = self.ammo - 1
    else
        Timer.add(RELOAD_TIME, function ()
            self.ammo = ROUND_SIZE
        end)
    end
end

function WeaponComponent:fire()
    local bullet = {}
    bullet.life = BULLET_LIFETIME

    bullet.body = LP.newBody(self.world, self.player.x, self.player.y, "dynamic")
    bullet.body:setFixedRotation(true)
    bullet.body:setBullet(true)
    bullet.shape = LP.newCircleShape(BULLET_RADIUS)
    bullet.fixture = LP.newFixture(bullet.body, bullet.shape, 1)
    bullet.fixture:setRestitution(0.5)
    bullet.fixture:setUserData({type = "bullet", collision = nil})
    bullet.fixture:setCategory(self.player.id)
    bullet.fixture:setMask(self.player.id)

    local vec = Vector(0, -RANGE):rotated(-self.player.direction)
    bullet.body:applyLinearImpulse(vec.x, vec.y)

    _.push(self.bullets, bullet)
    Signal.emit("action:fire", vec)
end

function WeaponComponent:draw(player)
    LG.setColor(0, 0, 0, 255)
    local vec = Vector(player.x, player.y) + Vector(0, -RANGE):rotated(-player.direction)
    _.each(self.bullets, function(bullet)
        LG.circle("fill", bullet.body:getX(), bullet.body:getY(), BULLET_RADIUS)
    end)
    LG.setColor(255, 255, 255, 255)
end

return WeaponComponent
