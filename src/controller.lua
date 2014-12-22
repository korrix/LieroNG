Controller = Class {}

function Controller:init(player_id)
    local function s(name)
        return function () Signal.emit(name, player_id) end
    end

    self.mod_active = false

    self.keymap = {
        update_main = { w = s('key:up')
                      , s = s('key:down')
                      , a = s('key:left')
                      , d = s('key:right')
                      , g = s('key:jump')
                      },

        update_mod = { w = s('key:up')
                     , s = s('key:down')
                     , a = s('key:left')
                     , d = s('key:right')
                     , f = s('key:climb')
                     },

        press_main = { h = function() self.mod_active = true end
                     , a = s('key:left_press')
                     , d = s('key:right_press')
                     , q = s('key:flashlight_toggle')
                     , f = s('key:trigger_press')
                     , escape = function() love.event.quit() end
                     },

        press_mod = { g = s('key:rope') },

        relase_main = { f = s('key:trigger_relase') },
        relase_mod = {h = function() self.mod_active = false end},
    }

    local nopindex = {__index = function(table, i)
        return function () end
    end}

    setmetatable(self.keymap.press_main, nopindex)
    setmetatable(self.keymap.press_mod, nopindex)
    setmetatable(self.keymap.relase_main, nopindex)
    setmetatable(self.keymap.relase_mod, nopindex)
end

function Controller:update(dt)
    local map = self.mod_active and self.keymap.update_mod or self.keymap.update_main
    for key, action in pairs(map) do
        if love.keyboard.isDown(key) then action() end
    end
end

function Controller:keypressed(key)
    if self.mod_active then
        self.keymap.press_mod[key]()
    else
        self.keymap.press_main[key]()
    end
end

function Controller:keyreleased(key)
    if self.mod_active then
        self.keymap.relase_mod[key]()
    else
        self.keymap.relase_main[key]()
    end
end
