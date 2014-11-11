-- Lazy(Not so true) resource loader

function Loader(directory, load_item)
  local ret = {}

  local files = love.filesystem.getDirectoryItems(directory)
  for k, file in ipairs(files) do
    local name = file:gsub("%..+$", "") -- Cut off the extension
    ret[name] = load_item(directory .. file, name)
  end

  return ret
end
