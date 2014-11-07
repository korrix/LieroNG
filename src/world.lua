World = Class {}

local GFORCE = 9.81

function World:init(level)
    self.level = level
    self.mouse = {x = 0, y = 0}

    self:__init_physics()
    self:__init_light()
end

function World:__init_physics()
    LP.setMeter(24)
    self.physics = LP.newWorld(0, GFORCE * LP.getMeter(), true)
    self.level:initWorldCollision(self.physics)
end

function World:__init_light()
    self.light = LL.newWorld()
    self.light.setAmbientColor(15, 15, 31)

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
    self.camera:attach()
    self.light.setTranslation(get_light_translation(self.camera))
    self.light.update()

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

    love.postshader.draw()

    self.camera:detach()
end
