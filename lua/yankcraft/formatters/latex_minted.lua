---Render a context as an LaTex minted code block string.
---@param ctx YankCraft.Context
---@return string
return function(ctx)
  local lines = ctx.lines
  local header = "\\begin{minted}"
  if ctx.filetype then
    header = header .. "{" .. ctx.filetype .. "}"
  end
  local out = { header }
  vim.list_extend(out, lines)
  table.insert(out, "\\end{minted}")

  return table.concat(out, "\n")
end
