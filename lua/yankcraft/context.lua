local config = require("yankcraft.config")
local path = require("yankcraft.path")

local M = {}

---@alias YankCraft.SelectionType
---| "char"
---| "line"
---| "block"

---@class YankCraft.Context
---@field path string Display path of the buffer.
---@field filetype string Filetype used as the code-fence language ("" when unknown).
---@field selection_type YankCraft.SelectionType The type of selection that was performed.
---@field start_line integer 1-based start line.
---@field end_line integer 1-based end line.
---@field start_col integer? 1-based start column (if visual selection).
---@field end_col integer? 1-based end column (if visual selection).
---@field lines string[] Collected buffer lines.

---Resolve the display path for a buffer.
---@param bufnr integer
---@return string
local function resolve_path(bufnr)
  local name = vim.api.nvim_buf_get_name(bufnr)
  return path.resolve(name, config.options.path_style)
end

---Create a selection type enum based on the mode nvim is in.
---@param mode string
---@return YankCraft.SelectionType
local function selection_type(mode)
  if mode == "v" then
    return "char"
  elseif mode == "V" then
    return "line"
  elseif mode == "\22" then
    return "block"
  end

  error("Unsupported visual mode: " .. vim.inspect(mode))
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
  local ctx = {}
  if mode == "v" or mode == "V" or mode == "\22" then
    local start = vim.fn.getpos("v")
    local finish = vim.fn.getpos(".")
    ctx.lines = vim.fn.getregion(start, finish, {
      type = mode,
    })
    ctx.start_line = math.min(start[2], finish[2])
    ctx.end_line = math.max(start[2], finish[2])
    ctx.start_col = math.min(start[3], finish[3])
    ctx.end_col = math.max(start[3], finish[3])
    ctx.selection_type = selection_type(mode)
  else
    local cursor = vim.api.nvim_win_get_cursor(0)[1]
    ctx.start_line, ctx.end_line = cursor, cursor
    ctx.lines = vim.api.nvim_buf_get_lines(bufnr, cursor - 1, cursor, false)
    ctx.selection_type = "line"
  end

  ctx.path = resolve_path(bufnr)
  ctx.filetype = vim.bo[bufnr].filetype or ""

  return ctx
end

return M
