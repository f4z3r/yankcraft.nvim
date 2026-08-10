---Render only the filepath.
---@param ctx YankCraft.Context
---@return string
return function(ctx)
  return "`" .. ctx.path .. "`"
end
