---Render a context as a AsciiDoc code block string.
---@param ctx YankCraft.Context
---@return string
return function(ctx)
  local lines = ctx.lines
  local header = ctx.filetype == "" and "[source]" or "[source," .. ctx.filetype .. "]"
  local out = { header, "----" }
  vim.list_extend(out, lines)
  table.insert(out, "----")

  return table.concat(out, "\n")
end
