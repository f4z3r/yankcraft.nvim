---Render a context as a Jira code block string.
---@param ctx YankCraft.Context
---@return string
return function(ctx)
  local lines = ctx.lines
  local header = ctx.filetype == "" and "{code}" or "{code:" .. ctx.filetype .. "}"
  local out = { header }
  vim.list_extend(out, lines)
  table.insert(out, "{code}")

  return table.concat(out, "\n")
end
