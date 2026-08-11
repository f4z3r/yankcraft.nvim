--# selene: allow(undefined_variable, incorrect_standard_library_use)

local yankcraft = require("yankcraft")
yankcraft.setup()

describe("Formatters:", function()
  local ctx

  before_each(function()
    ctx = {
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
  end)

  describe("asciidoc", function()
    local asciidoc = require("yankcraft.formatters.asciidoc")

    it("should output the correct selection", function()
      local expected = [[[source,lua]
----
function test()
  print("hello")
end
----]]
      assert.are.equal(expected, asciidoc(ctx))
    end)
  end)

  describe("confluence_wiki", function()
    local confluence_wiki = require("yankcraft.formatters.confluence_wiki")

    it("should output the correct selection", function()
      local expected = [[{code:language=lua|linenumbers=true}
function test()
  print("hello")
end
{code}]]
      assert.are.equal(expected, confluence_wiki(ctx))
    end)
  end)

  describe("filepath", function()
    local filepath = require("yankcraft.formatters.filepath")

    it("should output the correct selection", function()
      local expected = [[`some/path.lua`]]
      assert.are.equal(expected, filepath(ctx))
    end)
  end)

  describe("filepath_with_line_range", function()
    local filepath_with_line_range = require("yankcraft.formatters.filepath_with_line_range")

    it("should output the correct selection", function()
      local expected = [[`some/path.lua` (L42-L45)]]
      assert.are.equal(expected, filepath_with_line_range(ctx))
    end)
  end)

  describe("jira", function()
    local jira = require("yankcraft.formatters.jira")

    it("should output the correct selection", function()
      local expected = [[{code:lua}
function test()
  print("hello")
end
{code}]]
      assert.are.equal(expected, jira(ctx))
    end)
  end)

  describe("latex_listings", function()
    local latex_listings = require("yankcraft.formatters.latex_listings")

    it("should output the correct selection", function()
      local expected = [[\begin{lstlisting}[language=lua]
function test()
  print("hello")
end
\end{lstlisting}]]
      assert.are.equal(expected, latex_listings(ctx))
    end)
  end)

  describe("latex_minted", function()
    local latex_minted = require("yankcraft.formatters.latex_minted")

    it("should output the correct selection", function()
      local expected = [[\begin{minted}{lua}
function test()
  print("hello")
end
\end{minted}]]
      assert.are.equal(expected, latex_minted(ctx))
    end)
  end)

  describe("mardown", function()
    local markdown = require("yankcraft.formatters.markdown")

    it("should output the correct selection", function()
      local expected = [[```lua
function test()
  print("hello")
end
```]]
      assert.are.equal(expected, markdown(ctx))
    end)
  end)

  describe("norg", function()
    local norg = require("yankcraft.formatters.norg")

    it("should output the correct selection", function()
      local expected = [[@code lua
function test()
  print("hello")
end
@end]]
      assert.are.equal(expected, norg(ctx))
    end)
  end)

  describe("org_mode", function()
    local org_mode = require("yankcraft.formatters.org_mode")

    it("should output the correct selection", function()
      local expected = [[#+begin_src lua
function test()
  print("hello")
end
#+end_src]]
      assert.are.equal(expected, org_mode(ctx))
    end)
  end)

  describe("plain", function()
    local plain = require("yankcraft.formatters.plain")

    it("should output the correct selection", function()
      local expected = [[function test()
  print("hello")
end]]
      assert.are.equal(expected, plain(ctx))
    end)
  end)

  describe("restructuredtext", function()
    local restructuredtext = require("yankcraft.formatters.restructuredtext")

    it("should output the correct selection", function()
      local expected = [[.. code-block:: lua

   function test()
     print("hello")
   end]]
      assert.are.equal(expected, restructuredtext(ctx))
    end)
  end)
end)
