require("src.player.component")

SpriteComponent = Class {__includes = Component}

function SpriteComponent:draw(player)
    LG.setColor(255, 0, 0, 255)
    LG.circle("fill", player.x, player.y, PLAYER_RADIUS)
    LG.setColor(255, 255, 255, 255)
end

return SpriteComponent
