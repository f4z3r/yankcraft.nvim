--# selene: allow(undefined_variable, incorrect_standard_library_use)

describe("Utils:", function()
  local utils = require("yankcraft.utils")
  describe("dedent", function()
    it("should remove common indent", function()
      local lines = {
        [[    function test()]],
        [[      print("hello")]],
        [[    end]],
      }
      local expected = {
        [[function test()]],
        [[  print("hello")]],
        [[end]],
      }
      assert.are.same(expected, utils.dedent(lines))
    end)
  end)

  describe("get_line_range", function()
    it("should return a range on differing line numbers", function()
      local ctx = {
        path = "some/path.lua",
        filetype = "lua",
        start_line = 42,
        end_line = 45,
        lines = {
          [[function test()]],
          [[  print("hello")]],
          [[end]],
        },
      }
      assert.are.equal("(L42-L45)", utils.get_line_range(ctx))
    end)

    it("should return a single line on equal line numbers", function()
      local ctx = {
        path = "some/path.lua",
        filetype = "lua",
        start_line = 42,
        end_line = 42,
        lines = {
          [[function test()]],
        },
      }
      assert.are.equal("(L42)", utils.get_line_range(ctx))
    end)
  end)
end)
