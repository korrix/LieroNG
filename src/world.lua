World = Class {}

local GFORCE = 9.81
local GROUND_CATEGORY = 16

function World:init(level)
    self.level = level
    self.mouse = {x = 0, y = 0}

    self:__init_physics()
    self:__init_light()
end

function beginContact(a, b, coll)
    local a_obj, b_obj = a:getUserData(), b:getUserData()
    if a_obj.type == "ground" and b_obj.type == "player" then
        b_obj.setCanJump(true)
        b_obj.setJumpDirection(coll:getNormal())
    end

    if b_obj.type == "rope" then
        local x1, y1, x2, y2 = coll:getPositions()
        b_obj.collision = { body = a:getBody()
                          , position = Vector(x1, y1)
                          }
        b:setUserData(b_obj)
    end
end

function endContact(a, b, coll)
    local a_obj, b_obj = a:getUserData(), b:getUserData()
    if b_obj.type == "player" and a_obj.type == "ground" then
        b_obj.setCanJump(false)
    end
end

function preSolve(a, b, coll)
end

function postSolve(a, b, coll)
end

function World:__init_physics()
    LP.setMeter(24)
    self.physics = LP.newWorld(0, GFORCE * LP.getMeter(), true)
    self.physics:setCallbacks(beginContact, endContact, preSolve, postSolve)

    local bgBodies = self.level:initWorldCollision(self.physics)
    _.each(bgBodies, function(body)
        body.fixture:setUserData({type = "ground"})
        body.fixture:setCategory(GROUND_CATEGORY)
    end)
end

function World:__init_light()
    self.light = LL.newWorld()
    self.light.setAmbientColor(15, 15, 31)
    self.light.setRefractionStrength(16.0)
    self.light.setReflectionVisibility(0.75)

    -- TODO refactor getting by layer name to getting by property
    -- TODO loading static lights from TMX
    local levelShadow = self.level.layers["LightCollider"]
    _.each(levelShadow.objects, function(p)
        local polyline = _.flatten(_.map(p.polygon, function(a)
            return {a.x, a.y}
        end))
        local triangles = love.math.triangulate(polyline)
        _.each(triangles, function(vertices)
            LL.newPolygon(self.light, unpack(vertices))
        end)
    end)
end

local function get_light_translation(c)
    local tx,ty = Width / (2 * c.scale), Height / (2 * c.scale)
    tx = tx - c.x
    ty = ty - c.y
    return -tx,-ty
end

function World:update(dt)
    self.physics:update(dt)
    self.mouse.x, self.mouse.y = self.camera:mousepos()
end

function World:set_camera(camera)
    self.camera = camera
end

function World:draw(objects)
    self.light.setTranslation(get_light_translation(self.camera))

    self.camera:attach()

    self.light.update()
    love.postshader.setBuffer("render")

    LG.setBlendMode("alpha")
    self.level:draw()

    _.each(objects, function(obj)
        obj:draw()
    end)

    self.light.drawShadow()
    self.light.drawShine()
    self.light.drawPixelShadow()
    self.light.drawGlow()
    self.light.drawReflection()
    self.light.drawRefraction()

    self.camera:detach()

    love.postshader.addEffect("bloom", 2.0, 2.0)
    love.postshader.addEffect("scanlines")
    love.postshader.draw()
end
