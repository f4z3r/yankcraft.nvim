local config = require("yankcraft.config")
local path = require("yankcraft.path")

local M = {}

---@class YankCraft.Context
---@field path string Display path of the buffer.
---@field lang string Filetype used as the code-fence language ("" when unknown).
---@field start_line integer? 1-based start line.
---@field end_line integer? 1-based end line.
---@field lines string[] Collected buffer lines.

---Resolve the display path for a buffer.
---@param bufnr integer
---@return string
local function resolve_path(bufnr)
  local name = vim.api.nvim_buf_get_name(bufnr)
  return path.resolve(name, config.options.path_style)
end

---Build a context from the current or last visual selection.
---
---While Visual mode is still active the `'<`/`'>` marks are stale (they only
---update when the selection is left), so the live `v`/`.` positions are used
---instead; outside Visual mode we fall back to the marks. When neither is set
---(no selection has ever been made) we fall back to the cursor line so we never
---emit a bogus line 0.
---@return YankCraft.Context
function M.from_selection()
  local bufnr = vim.api.nvim_get_current_buf()

  local mode = vim.fn.mode()
  local start_line, end_line
  if mode == "v" or mode == "V" or mode == "\22" then
    start_line = vim.fn.getpos("v")[2]
    end_line = vim.fn.getpos(".")[2]
  else
    local cursor = vim.api.nvim_win_get_cursor(0)[1]
    start_line, end_line = cursor, cursor
  end

  if start_line > end_line then
    start_line, end_line = end_line, start_line
  end

  return {
    path = resolve_path(bufnr),
    lang = vim.bo[bufnr].filetype or "",
    start_line = start_line,
    end_line = end_line,
    lines = vim.api.nvim_buf_get_lines(bufnr, start_line - 1, end_line, false),
  }
end

return M
