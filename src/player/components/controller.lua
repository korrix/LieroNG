ControllerComponent = Class {__includes = Component}

function ControllerComponent:init(player, w, s, a, d, f, g, h, q)
    player:register_component(self)

    local function sig(name)
        return function () Signal.emit(name, player.id) end
    end

    self.mod_active = false

    self.keymap = {
        update_main = { [w] = sig('key:up')
                      , [s] = sig('key:down')
                      , [a] = sig('key:left')
                      , [d] = sig('key:right')
                      , [g] = sig('key:jump')
                      },

        update_mod = { [w] = sig('key:up')
                     , [s] = sig('key:down')
                     , [a] = sig('key:left')
                     , [d] = sig('key:right')
                     , [f] = sig('key:climb')
                     },

        press_main = { [h] = function() self.mod_active = true end
                     , [a] = sig('key:left_press')
                     , [d] = sig('key:right_press')
                     , [q] = sig('key:flashlight_toggle')
                     , [f] = sig('key:trigger_press')

                     -- TODO: Debug only
                     , escape = function() love.event.quit() end
                     },

        press_mod = { [g] = sig('key:rope') },

        relase_main = { [f] = sig('key:trigger_relase') },
        relase_mod = {[h] = function() self.mod_active = false end},
    }

    local nopindex = {__index = function(table, i)
        return function () end
    end}

    setmetatable(self.keymap.press_main, nopindex)
    setmetatable(self.keymap.press_mod, nopindex)
    setmetatable(self.keymap.relase_main, nopindex)
    setmetatable(self.keymap.relase_mod, nopindex)
end

function ControllerComponent:update(dt)
    local map = self.mod_active and self.keymap.update_mod or self.keymap.update_main
    for key, action in pairs(map) do
        if love.keyboard.isDown(key) then action() end
    end
end

function ControllerComponent:keypressed(key)
    if self.mod_active then
        self.keymap.press_mod[key]()
    else
        self.keymap.press_main[key]()
    end
end

function ControllerComponent:keyreleased(key)
    if self.mod_active then
        self.keymap.relase_mod[key]()
    else
        self.keymap.relase_main[key]()
    end
end

return ControllerComponent
