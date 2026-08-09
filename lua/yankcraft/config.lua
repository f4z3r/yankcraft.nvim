local markdown = require("yankcraft.formatters.markdown")

local M = {}

---@class YankCraft.Config
---@field register string Register to yank into (default: system clipboard "+").
---@field path_style "auto"|"relative"|"absolute" How to render the file path.
---@field notify boolean Whether to notify on successful yank.
---@field dedent boolean Whether to remove the common indent from the code contents.
---@field formatter fun(ctx:YankCraft.Context):string A function that allows to customize the formatter to use.

---@type YankCraft.Config
M.defaults = {
  register = "+",
  path_style = "auto",
  notify = true,
  dedent = true,
  formatter = markdown,
}

---@type YankCraft.Config
M.options = vim.deepcopy(M.defaults)

---Merge user options into the defaults.
---@param opts? table
---@return YankCraft.Config
function M.setup(opts)
  M.options = vim.tbl_deep_extend("force", vim.deepcopy(M.defaults), opts or {})
  return M.options
end

return M
