# yankcraft.nvim

> Transform Neovim selections into shareable clipboard content.

## Features


## Requirements

- Neovim >= 0.8
- A working clipboard provider (see `:help clipboard`) for the default `+` register.

## Installation

## Usage

### Suggested keymaps

```lua
local yankcraft = require("yankcraft")
vim.keymap.set({ "n", "x" }, "<leader>yf", function()
  require("yankcraft").filepath(true)
end, {
  desc = "Yank filepath"
})
vim.keymap.set({ "n", "x" }, "<leader>yc", require("yankcraft").content, { desc = "Yank content" })
```

## Configuration

Defaults:

```lua
require("context-yank").setup({
  register = "+",       -- register to yank into (system clipboard)
  path_style = "auto",  -- "auto" (git root -> cwd) | "relative" (cwd) | "absolute"
  notify = true,        -- notify on successful yank
})
```

## License

MIT
