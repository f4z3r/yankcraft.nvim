---Render a context as a plain text string.
---@param ctx YankCraft.Context
---@return string
return function(ctx)
  return table.concat(ctx.lines, "\n")
end
