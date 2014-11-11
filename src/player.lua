require("lib.lazy_loader")
require("src.player.player")

Component = Loader("src/player/components/", function(item_path)
  local req_path = item_path:gsub("%..+$", ""):gsub("/", ".")
  return require(req_path)
end)
