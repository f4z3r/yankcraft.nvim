local LANG_MAP = {
  javascript = "JavaScript",
  typescript = "JavaScript",
  cs = "C#",
  html = "HTML and XML",
  xml = "HTML and XML",
  sh = "Bash",
}
---Render a context as a Confluence wiki code block with line numbers.
---@param ctx YankCraft.Context
---@return string
return function(ctx)
  local lines = ctx.lines
  local lang = LANG_MAP[ctx.filetype] or ctx.filetype
  local header = ctx.filetype == "" and "{code:linenumbers=true}" or "{code:language=" .. lang .. "|linenumbers=true}"
  local out = { header }
  vim.list_extend(out, lines)
  table.insert(out, "{code}")

  return table.concat(out, "\n")
end
