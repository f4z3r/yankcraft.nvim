local utils = require("yankcraft.fences.utils")

---Render a context as a Norg code block string.
---@param ctx YankCraft.Context
---@return string
return function(ctx)
  local lines = ctx.lines
  lines = utils.dedent(lines)
  local out = { "@code " .. (ctx.lang ~= "" and ctx.lang or "") }
  vim.list_extend(out, lines)
  table.insert(out, "@end")

  return table.concat(out, "\n")
end
