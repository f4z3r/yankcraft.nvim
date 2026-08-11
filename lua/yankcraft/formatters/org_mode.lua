---Render a context as an Org Mode code block string.
---@param ctx YankCraft.Context
---@return string
return function(ctx)
  local lines = ctx.lines
  local header = "#+begin_src"
  if ctx.filetype then
    header = header .. " " .. ctx.filetype
  end
  local out = { header }
  vim.list_extend(out, lines)
  table.insert(out, "#+end_src")

  return table.concat(out, "\n")
end
