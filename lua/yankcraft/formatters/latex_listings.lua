---Render a context as an LaTex listings code block string.
---@param ctx YankCraft.Context
---@return string
return function(ctx)
  local lines = ctx.lines
  local header = "\\begin{lstlisting}"
  if ctx.filetype then
    header = header .. "[language=" .. ctx.filetype .. "]"
  end
  local out = { header }
  vim.list_extend(out, lines)
  table.insert(out, "\\end{lstlisting}")

  return table.concat(out, "\n")
end
