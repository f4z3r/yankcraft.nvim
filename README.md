<div align="center">

<a href="https://github.com/f4z3r/yankcraft.nvim/archive/main.zip"><img src="./assets/logo.png" alt="yankcraft" width="35%"></a>

# yankcraft.nvim

![GitHub contributors](https://img.shields.io/github/contributors-anon/f4z3r/yankcraft.nvim)
![GitHub last commit](https://img.shields.io/github/last-commit/f4z3r/yankcraft.nvim)

### Transform Neovim selections into shareable clipboard content.

[Features](#features) |
[Installation](#installation) |
[Usage](#usage) |
[Configuration](#configuration) |

<hr />
</div>

> [!NOTE]
> This is essentially a fork from [context-yank.nvim](https://github.com/ymtdzzz/context-yank.nvim)
> with some additional features that I need.

## Features

This is essentially a quality of life wrapper around yank operations. It can have many use cases.
Some of the ones that I like the most:

- Quickly copy a filepath and line number reference so I can paste them into an agent prompt to
  reference some code.
- Copy a code block and wrap it in Markdown fences to send via a messaging app to someone.
- Copy a code block and wrap it in [Norg](https://github.com/nvim-neorg/norg-specs) fences to paste
  in my [Neorg](https://github.com/nvim-neorg/neorg) setup.

## Installation

Install via your favourite package manager:

[vim-plug](https://github.com/junegunn/vim-plug)

```vim
Plug 'f4z3r/yankcraft.nvim'
```

[packer](https://github.com/wbthomason/packer.nvim)

```lua
use 'f4z3r/yankcraft.nvim'
```

[lazy](https://github.com/folke/lazy.nvim)

```lua
{
  'f4z3r/yankcraft.nvim',
  name = 'yankcraft',
  lazy = false,
  priority = 1000,
  opts = {},
},
```

## Usage

The plugin does not create any keymaps automatically. It essentially exposes two functions:

```lua
filepath(with_range?: boolean, opts?: YankCraft.Config)
content(opts?: YankCraft.Config)
```

The `filepath` function will copy the filepath to the clipboard. If `with_range` is provided, a line
range is appended:

```
`lua/yankcraft/init.lua` (L39)
```

The additional options can be used to override global options.

The `content` function will copy the selected lines (in visual mode) or the current line (in normal
mode) and fence the text according to your configuration (by default a Markdown fence):

````
```lua
function M.content(opts)
  opts = vim.tbl_deep_extend("force", vim.deepcopy(config.options), opts or {})
  local ctx = context.from_selection()
  local text = opts.fence(ctx)
  vim.fn.setreg(opts.register, text)
  if config.options.notify then
    local range = get_range(ctx)
    vim.notify(string.format("Yanked %s%s", ctx.path, range), vim.log.levels.INFO)
  end
  return text
end
```
````

### Suggested Keymaps

```lua
local yankcraft = require("yankcraft")

vim.keymap.set("n", "<leader>yf", require("yankcraft").filepath, {
  desc = "Yank filepath"
})

vim.keymap.set({ "n", "x" }, "<leader>yl", function()
  require("yankcraft").filepath(true)
  vim.cmd("normal! \27") -- return to normal mode, if you desire
end, {
  desc = "Yank filepath and line number(s)"
})

vim.keymap.set({ "n", "x" }, "<leader>yc", require("yankcraft").content, {
  desc = "Yank content in Markdown fences"
})

vim.keymap.set({ "n", "x" }, "<leader>yn", function()
  local norg = require("yankcraft.fences.norg")
  require("yankcraft").content({fence = norg})
end, {
  desc = "Yank content in Norg fences"
})
```

## Configuration

Defaults:

```lua
require("yankcraft").setup({
  register = "+",       -- register to yank into (system clipboard)
  path_style = "auto",  -- "auto" (git root -> cwd) | "relative" (cwd) | "absolute"
  notify = true,        -- notify on successful yank
  fence = nil,          -- your custom default fence function, markdown by default
})
```

### Building a Custom Fence

You can build a custom fence if it is not provided by the project (or feel free to open a PR). This
can be done by providing a function with the following format:

```lua
fun(ctx: YankCraft.Context): string
```

Where `YankCraft.Context` provides the following fields:

```lua
---@class YankCraft.Context
---@field path string Display path of the buffer.
---@field lang string Filetype used as the code-fence language ("" when unknown).
---@field start_line integer? 1-based start line.
---@field end_line integer? 1-based end line.
---@field lines string[] Collected buffer lines.
```

See [`lua/yankcraft/fences/norg.lua`](./lua/yankcraft/fences/norg.lua) for an example implementation
of a fence that dedents the lines of text and adds a `@code <lang>` start and an `@end` end fence.

Such a function can then be given either as a default fence in the configuration, or when calling
the `content` function directly (see [Suggested Keymaps](#suggested-keymaps) for an example).

## License

MIT
