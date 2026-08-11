vim.opt.runtimepath:prepend(vim.fn.getcwd())

local plenary_dir = vim.fn.getcwd() .. "/deps/plenary.nvim"
vim.opt.runtimepath:append(plenary_dir)
