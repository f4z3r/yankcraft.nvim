---Return a fence string long enough to safely wrap the given lines.
---Markdown requires the fence to be longer than any backtick run inside the
---content, with a minimum of three backticks.
---@param lines string[]
---@return string
local function build_fence(lines)
  local longest = 0
  for _, line in ipairs(lines) do
    for run in line:gmatch("`+") do
      if #run > longest then
        longest = #run
      end
    end
  end
  return string.rep("`", math.max(3, longest + 1))
end

---Render a context as a Markdown code block string.
---@param ctx YankCraft.Context
---@return string
return function(ctx)
  if (ctx.selection_type == "char" or ctx.selection_type == "block") and (ctx.start_line == ctx.end_line) then
    return "`" .. ctx.lines[1] .. "`"
  end
  local lines = ctx.lines
  local fence = build_fence(lines)
  local out = { fence .. (ctx.filetype ~= "" and ctx.filetype or "") }
  vim.list_extend(out, lines)
  table.insert(out, fence)

  return table.concat(out, "\n")
end
