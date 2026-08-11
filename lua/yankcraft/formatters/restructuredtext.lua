---Render a context as an reStructuredText code block string.
---@param ctx YankCraft.Context
---@return string
return function(ctx)
  local lines = vim.tbl_map(function(line)
    return "   " .. line
  end, ctx.lines)
  local header = ".. code-block::"
  if ctx.filetype then
    header = header .. " " .. ctx.filetype
  end
  local out = { header, "" }
  vim.list_extend(out, lines)

  return table.concat(out, "\n")
end
