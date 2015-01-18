require("lib.lazy_loader")

Font = Loader("font/", function(item_path)
  local font_sizes = {}
  setmetatable(font_sizes, {__index = function(table, font_size)
    table[font_size] = LG.newFont(item_path, font_size)
    return table[font_size]
  end})
  return font_sizes
end)

Stage = Loader("src/stages/", function(item_path)
  local req_path = item_path:gsub("%..+$", ""):gsub("/", ".")
  return require(req_path)
end)

Shader = Loader("src/shaders/", function(item_path)
  return LG.newShader(item_path)
end)

Sound = Loader("sfx/", function(item_path)
  return love.audio.newSource(item_path, "static")
end)

local quad_factory = {}

Sprite = Loader("gfx/", function(item_path, name)
  local image = LG.newImage(item_path)
  local quads = {}
  local function newQuadClosure(index, x, y, w, h)
    quads[index] = LG.newQuad(x, y, w, h, image:getDimensions())
  end
  if quad_factory[name] then
    quad_factory[name](newQuadClosure)
  end
  return {image = image, quads = quads}
end)

Level = Loader("levels/", function(item_path, name)
  return sti.new(item_path:gsub("%..+$", ""))
end)
