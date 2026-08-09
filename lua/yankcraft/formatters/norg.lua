---Render a context as a Norg code block string.
---@param ctx YankCraft.Context
---@return string
return function(ctx)
  if (ctx.selection_type == "char" or ctx.selection_type == "block") and (ctx.start_line == ctx.end_line) then
    return "`" .. ctx.lines[1] .. "`"
  end
  local lines = ctx.lines
  local header = ctx.filetype == "" and "@code" or "@code " .. ctx.filetype
  local out = { header }
  vim.list_extend(out, lines)
  table.insert(out, "@end")

  return table.concat(out, "\n")
end
