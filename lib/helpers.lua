function table.pack(...)
  return { n = select("#", ...), ... }
end

function string.split(str, delim, maxNb)
  -- Eliminate bad cases...
  if string.find(str, delim) == nil then
    return { str }
  end
  if maxNb == nil or maxNb < 1 then
    maxNb = 0    -- No limit
  end
  local result = {}
  local pat = "(.-)" .. delim .. "()"
  local nb = 0
  local lastPos
  for part, pos in string.gmatch(str, pat) do
    nb = nb + 1
    result[nb] = part
    lastPos = pos
    if nb == maxNb then break end
  end
  -- Handle the last field
  if nb ~= maxNb then
    result[nb + 1] = string.sub(str, lastPos)
  end
  return result
end

-- Taken from http://love2d.org/wiki/coroutine.resume
_coroutine_resume = coroutine.resume
function coroutine.resume(...)
    local state,result = _coroutine_resume(...)
    if not state then
        error( tostring(result), 2 )    -- Output error message
    end
    return state,result
end

function math.lerp(a, b, t)
  return a + (b - a) * t
end
