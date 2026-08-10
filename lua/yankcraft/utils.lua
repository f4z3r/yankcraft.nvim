local M = {}

---Remove the common leading whitespace shared by all non-blank lines.
---@param lines string[]
---@return string[]
function M.dedent(lines)
  local min_indent = nil
  for _, line in ipairs(lines) do
    if line:match("%S") then
      -- TODO: f4z3r - fix mixed indents between tabs and spaces.
      local indent = #(line:match("^%s*"))
      if min_indent == nil or indent < min_indent then
        min_indent = indent
      end
    end
  end
  if not min_indent or min_indent == 0 then
    return lines
  end
  local result = {}
  for i, line in ipairs(lines) do
    result[i] = line:sub(min_indent + 1)
  end
  return result
end

---Return the line range in the format (LXX-LYY) provided by a context.
---@param ctx YankCraft.Context
---@return string
function M.get_line_range(ctx)
  local range = "(L"
  if ctx.start_line ~= ctx.end_line then
    range = range .. ctx.start_line .. "-L" .. ctx.end_line
  else
    range = range .. ctx.start_line
  end
  range = range .. ")"
  return range
end

return M
