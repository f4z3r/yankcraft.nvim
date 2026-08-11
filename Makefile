deps/plenary.nvim/README.md:
	mkdir -p deps
	git clone --depth=1 https://github.com/nvim-lua/plenary.nvim deps/plenary.nvim

.PHONY: test
test: deps/plenary.nvim/README.md
	nvim --headless \
		-u tests/minimal_init.lua \
		-c "PlenaryBustedDirectory tests { minimal_init = 'tests/minimal_init.lua' }"
