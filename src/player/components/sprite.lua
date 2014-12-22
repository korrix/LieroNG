require("src.player.component")

SpriteComponent = Class {__includes = Component}

function SpriteComponent:init(player)
    player:register_component(self)
    self.player = player
end

function SpriteComponent:draw()
    LG.setColor(255, 0, 0, 255)
    LG.circle("fill", self.player.x, self.player.y, PLAYER_RADIUS)
    LG.setColor(255, 255, 255, 255)
end

return SpriteComponent
