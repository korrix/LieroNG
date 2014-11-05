-- Shortcuts
L  = love
LG = love.graphics
LP = love.physics

-- load libs
require("lib.strict")
require("lib.strict_override")
require("lib.helpers")

_         = require("lib.underscore-lua.lib.underscore")
sti       = require("lib.sti")

Gamestate = require("lib.hump.gamestate")
Class     = require("lib.hump.class")
Camera    = require("lib.hump.camera")
Signal    = require("lib.hump.signal")
Timer     = require("lib.hump.timer")

-- Global resource tables (loaded in load)
Font     = nil
Shader   = nil
Sound    = nil
Sprite   = nil
Stage    = nil
Level    = nil

Width    = nil
Height   = nil

function love.load()
  Width, Height = love.window.getDimensions()
  love.keyboard.setKeyRepeat(true)

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
