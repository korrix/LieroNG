Snake = Class {}

local GS = 18

function Snake:init()
    self.gameOver = false

    self.width = math.floor(Width/GS)
    self.height = math.floor(Height/GS)
    self.ox = (Width % GS) / 2
    self.oy = (Height % GS) / 2

    self.map = {}

    for y = 1, self.height do
        self.map[y] = {}
        for x = 1, self.width do
            self.map[y][x] = 0
        end
    end

    self.tail = {}
    self:push(self:random_point())

    self.applePos = {}
    self:randomizeApple()

    self.direction = 0

    -- Pathfinder
    self.grid = Grid(self.map)
    self.patchfinder = Pathfinder(self.grid, 'JPS',  function(v)
        return v ~= 1
    end)

    -- self.patchfinder:setHeuristic("MANHATTAN")
    self.patchfinder:setMode("ORTHOGONAL")
end

function Snake:get(point)
    return self.map[point[2]][point[1]]
end

function Snake:set(point, v)
    self.map[point[2]][point[1]] = v
end

function Snake:push(point)
    self:set(point, 1)
    _.push(self.tail, point)
end

function Snake:shift()
    self:set(_.shift(self.tail), 0)
end

function Snake:head()
    return self.tail[#self.tail]
end

function Snake:inTail(point)
    return self:get(point) == 1
end

function Snake:apple(point)
    return self:get(point) == 2
end

function Snake:randomizeApple()
    self.applePos = self:random_point()
    self:set(self.applePos, 2)
end

function Snake:random_point()
    local try = {math.floor(love.math.random() * (self.width - 1)) + 1,
                 math.floor(love.math.random() * (self.height - 1)) + 1}
    if self:inTail(try) then
        try = self:random_point()
    end

    return try
end

local function point_equal(a, b)
    return a[1] == b[1] and a[2] == b[2]
end

function Snake:draw()
    LG.setColor(8, 8, 8, 255)
    LG.rectangle("fill", 0, 0, Width, Height)

    for y = 1, self.height do
        for x = 1, self.width do
            local t = self.map[y][x]
            if t == 0 then
               LG.setColor(16, 16, 16, 255)
            elseif t == 1 then
               LG.setColor(255, 255, 255, 255)
            elseif t == 2 then
                LG.setColor(255, 0, 0, 128)
            else
                LG.setColor(255,255,0,255)
            end

            if point_equal({x,y}, self:head()) then
                LG.setColor(0,255,128,255)
            end

            LG.rectangle("fill", self.ox + (x - 1) * GS, self.oy + (y - 1) * GS, GS - 1, GS -1)
        end
    end
end

local function mod(a, b)
    if a > b then return mod(a - b, b) end
    if a < 1 then return mod(b + a, b) end
    return a
end

function Snake:findNext(node, d)
    local dir = d or self.direction

    if dir == 0 then -- Upwards
        return {node[1], mod(node[2] - 1, self.height)}
    elseif dir == 1 then -- Right
        return {mod(node[1] + 1, self.width), node[2]}
    elseif dir == 2 then -- Downwards
        return {node[1], mod(node[2] + 1, self.height)}
    elseif dir == 3 then -- Left
        return {mod(node[1] - 1, self.width), node[2]}
    end
end

function Snake:aiGetDirection()
    local head = self:head()
    local apple = self.applePos

    local path = self.patchfinder:getPath(head[1], head[2], apple[1], apple[2])

    if path then
        local nxt   = true
        local first = nil

        for node, count in path:nodes() do
           first = {node:getX(), node:getY()}
           if point_equal(self:findNext(head, 0), first) then return 0 end
           if point_equal(self:findNext(head, 1), first) then return 1 end
           if point_equal(self:findNext(head, 2), first) then return 2 end
           if point_equal(self:findNext(head, 3), first) then return 3 end
        end

        return self.direction

    else
        return self.direction
    end
end

function Snake:step()
    self.direction = self:aiGetDirection()

    if self.gameOver then
        print("Score: " .. tostring(#self.tail))
        return
    end

    local nextPoint = self:findNext(self:head())

    if self:inTail(nextPoint) then
        self.gameOver = true
    end

    if self:apple(nextPoint) then
        self:randomizeApple()
    else
        self:shift()
    end

    self:push(nextPoint)
end
