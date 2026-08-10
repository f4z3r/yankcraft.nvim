local config = require("yankcraft.config")
local context = require("yankcraft.context")
local utils = require("yankcraft.utils")

local M = {}

---Configure the plugin.
---@param opts? YankCraft.Config
function M.setup(opts)
  config.setup(opts)
end

---Copy the content with some formatter.
---@param opts? YankCraft.Config Potential configuation overrides.
---@return string
function M.copy(opts)
  opts = vim.tbl_deep_extend("force", vim.deepcopy(config.options), opts or {})
  local ctx = context.from_selection()
  if opts.dedent then
    ctx.lines = utils.dedent(ctx.lines)
  end
  local text = opts.formatter(ctx)
  vim.fn.setreg(opts.register, text)
  if opts.notify then
    local range = utils.get_line_range(ctx)
    vim.notify(string.format("Yanked %s%s", ctx.path, range), vim.log.levels.INFO)
  end
  return text
end

return M
