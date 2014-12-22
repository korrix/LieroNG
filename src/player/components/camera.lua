require("src.player.component")

CameraComponent = Class {__includes = Component}

function CameraComponent:init(player)
    player:register_component(self)
    self.player = player

    self.movementSoftness = 5
    self.camera = Camera(player.x, player.y)
end

function CameraComponent:get_camera()
    return self.camera
end

function CameraComponent:update(dt)
    local camX, camY = self.camera:pos()
    local newX = camX - (camX - self.player.x) * dt * self.movementSoftness
    local newY = camY - (camY - self.player.y) * dt * self.movementSoftness
    self.camera:lookAt(newX, newY)
end

return CameraComponent
