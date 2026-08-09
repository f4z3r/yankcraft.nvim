local config = require("yankcraft.config")
local context = require("yankcraft.context")
local utils = require("yankcraft.utils")

local M = {}

---Configure the plugin.
---@param opts? YankCraft.Config
function M.setup(opts)
  config.setup(opts)
end

local function get_range(ctx)
  local range = "(L"
  if ctx.start_line ~= ctx.end_line then
    range = range .. ctx.start_line .. "-L" .. ctx.end_line
  else
    range = range .. ctx.start_line
  end
  range = range .. ")"
  return range
end

---Copy the content with some formatter.
---@param opts? YankCraft.Config Potential configuation overrides.
---@return string
function M.content(opts)
  opts = vim.tbl_deep_extend("force", vim.deepcopy(config.options), opts or {})
  local ctx = context.from_selection()
  if opts.dedent then
    ctx.lines = utils.dedent(ctx.lines)
  end
  local text = opts.formatter(ctx)
  vim.fn.setreg(opts.register, text)
  if opts.notify then
    local range = get_range(ctx)
    vim.notify(string.format("Yanked %s%s", ctx.path, range), vim.log.levels.INFO)
  end
  return text
end

---Copy the filepath in Markdown verbatum quotes.
---@param with_range? boolean Whether to include the line numbers in the output.
---@param opts? YankCraft.Config Potential configuration overrides
---@return string
function M.filepath(with_range, opts)
  opts = vim.tbl_deep_extend("force", vim.deepcopy(config.options), opts or {})
  local ctx = context.from_selection()
  local text = "`" .. ctx.path .. "`"
  if with_range then
    text = text .. " " .. get_range(ctx)
  end
  vim.fn.setreg(opts.register, text)
  if opts.notify then
    vim.notify("Yanked filepath", vim.log.levels.INFO)
  end
  return text
end

return M
