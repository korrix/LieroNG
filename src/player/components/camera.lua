require("src.player.component")

CameraComponent = Class {__includes = Component}

function CameraComponent:init()
    self.movementSoftness = 5
    self.camera = Camera(0, 0)
end

function CameraComponent:get_camera()
    return self.camera
end

function CameraComponent:update(player, dt)
    local camX, camY = self.camera:pos()
    local newX = camX - (camX - player.x) * dt * self.movementSoftness
    local newY = camY - (camY - player.y) * dt * self.movementSoftness
    self.camera:lookAt(newX, newY)
end

return CameraComponent
