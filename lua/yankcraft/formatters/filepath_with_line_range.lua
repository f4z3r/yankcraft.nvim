local utils = require("yankcraft.utils")

---Render only the filepath with a line range appended.
---@param ctx YankCraft.Context
---@return string
return function(ctx)
  return "`" .. ctx.path .. "` " .. utils.get_line_range(ctx)
end
