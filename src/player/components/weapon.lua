require("src.player.component")

WeaponComponent = Class {__includes = Component}

local LOAD_LAG  = 0.1
local RELOAD_TIME = 1
local ROUND_SIZE = 12

local DAMAGE   = 10
local RANGE    = 10000
local BULLET_RADIUS = 2.5
local BULLET_LIFETIME = 10
local BULLET_FRAG = 10

function WeaponComponent:init(player)
    player:register_component(self)
    self.player = player
    self.world  = player.world.physics

    self.active = false

    self.load_level = 0
    self.ammo = ROUND_SIZE

    self.bullets = {}

    player:register("key:trigger_press", function()
        self.active = true
    end)

    player:register("key:trigger_relase", function()
        self.active = false
    end)

    player:register_hud({
        load_level  = function () return self.load_level end,
        ammo        = function () return self.ammo end,
        round_size  = function () return ROUND_SIZE end
    })
end

function WeaponComponent:update(dt)
    if self.load_level < 1 and self.ammo > 0 then
        self.load_level = self.load_level + dt * (1 - LOAD_LAG)
    elseif self.active then
        self.load_level = 0
        self:shoot()
    end

    local alive = {}
    _.each(self.bullets, function(bullet)
        local p = bullet.fixture:getUserData()
        p.life = p.life - dt
        if p.life < 0 then
            bullet.body:destroy()
        else
            bullet.fixture:setUserData(p)
            _.push(alive, bullet)
        end
    end)

    self.bullets = alive
end

function WeaponComponent:shoot()
    if self.ammo > 0 then
        self:fire()
        self.ammo = self.ammo - 1
        if self.ammo < 1 then
            Timer.add(RELOAD_TIME, function ()
                self.ammo = ROUND_SIZE
            end)
        end
    end
end

function WeaponComponent:fire()
    local bullet = {}
    bullet.body = LP.newBody(self.world, self.player.x, self.player.y, "dynamic")
    bullet.body:setFixedRotation(true)
    bullet.body:setBullet(true)
    bullet.shape = LP.newCircleShape(BULLET_RADIUS)
    bullet.fixture = LP.newFixture(bullet.body, bullet.shape, 1)
    bullet.fixture:setRestitution(0.5)

    local frag = math.floor(BULLET_FRAG * math.abs(love.math.randomNormal(1, 0.75)))
    bullet.fixture:setUserData({
        type = "bullet", collision = nil,
        owner = self.player.id, frag = frag,
        life = BULLET_LIFETIME
    })

    bullet.fixture:setCategory(self.player.id)
    bullet.fixture:setMask(self.player.id)

    local vec = Vector(0, -RANGE):rotated(-self.player.direction)
    bullet.body:applyLinearImpulse(vec.x, vec.y)

    _.push(self.bullets, bullet)
    self.player:emit("action:fire", vec)
end

function WeaponComponent:draw()
    LG.setColor(0, 0, 0, 255)
    local vec = Vector(self.player.x, self.player.y)
              + Vector(0, -RANGE):rotated(-self.player.direction)
    _.each(self.bullets, function(bullet)
        LG.circle("fill", bullet.body:getX(), bullet.body:getY(), BULLET_RADIUS)
    end)

    LG.setColor(255, 255, 255, 255)
end

return WeaponComponent
