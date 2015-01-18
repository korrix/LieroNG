-- load libs
require("lib.strict")
require("lib.strict_override")
require("lib.helpers")
require("lib.light.postshader")
require("lib.light.light")

_         = require("lib.underscore-lua.lib.underscore")
inspect   = require("lib.inspect.inspect")
sti       = require("lib.sti")

Gamestate = require("lib.hump.gamestate")
Class     = require("lib.hump.class")
Camera    = require("lib.hump.camera")
Signal    = require("lib.hump.signal")
Timer     = require("lib.hump.timer")
Vector    = require("lib.hump.vector")

Grid       = require("lib.jumper.jumper.grid")
Pathfinder = require("lib.jumper.jumper.pathfinder")

-- Shortcuts
L  = love
LG = love.graphics
LP = love.physics
LL = love.light

-- Global resource tables (loaded in load)
Font     = nil
Shader   = nil
Sound    = nil
Sprite   = nil
Stage    = nil
Level    = nil

-- Global constants
Width         = nil
Height        = nil
PLAYER_RADIUS = 12

function love.load()
  Width, Height = love.window.getDimensions()

  require("src.load_resources")

  Gamestate.registerEvents()
  Gamestate.switch(Stage.game)
end

function love.update(dt)
  Timer.update(dt)
  Gamestate.update(dt)
end

function love.threaderror(thread, errorstr)
  error(errorstr)
end
