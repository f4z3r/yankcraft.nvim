# Formatters

This document briefly shows examples of the output of various formatters.

<!--toc:start-->
- [Formatters](#formatters)
  - [AsciiDoc](#asciidoc)
  - [Confluence Wiki](#confluence-wiki)
  - [Filepath](#filepath)
  - [Filepath with Line Range](#filepath-with-line-range)
  - [Jira](#jira)
  - [LaTeX Listings](#latex-listings)
  - [LaTeX Minted](#latex-minted)
  - [Markdown](#markdown)
  - [Norg](#norg)
  - [Org Mode](#org-mode)
  - [Plain](#plain)
  - [reStructuredText](#restructuredtext)
<!--toc:end-->

---

This assumes that you have a file (`lua/yankcraft/init.lua`) with the three lines (lines 19 to 21)
selected in line mode:

```lua
function M.copy(opts)
  opts = vim.tbl_deep_extend("force", vim.deepcopy(config.options), opts or {})
  local ctx = context.from_selection()
  if opts.dedent then                      -- <-- line selected
    ctx.lines = utils.dedent(ctx.lines)    -- <-- line selected
  end                                      -- <-- line selected
  local text = opts.formatter(ctx)
  vim.fn.setreg(opts.register, text)
  if opts.notify then
    local range = utils.get_line_range(ctx)
    vim.notify(string.format("Yanked %s%s", ctx.path, range), vim.log.levels.INFO)
  end
  return text
end
```

## AsciiDoc

```adoc
[source,lua]
----
if opts.dedent then
  ctx.lines = utils.dedent(ctx.lines)
end
----
```

## Confluence Wiki

```
{code:language=lua|linenumbers=true}
if opts.dedent then
  ctx.lines = utils.dedent(ctx.lines)
end
{code}
```

## Filepath

```markdown
`lua/yankcraft/init.lua`
```

## Filepath with Line Range

```markdown
`lua/yankcraft/init.lua` (L19-L21)
```

## Jira

```
{code:lua}
if opts.dedent then
  ctx.lines = utils.dedent(ctx.lines)
end
{code}
```

## LaTeX Listings

```latex
\begin{lstlisting}[language=lua]
if opts.dedent then
  ctx.lines = utils.dedent(ctx.lines)
end
\end{lstlisting}
```

## LaTeX Minted

```latex
\begin{minted}{lua}
if opts.dedent then
  ctx.lines = utils.dedent(ctx.lines)
end
\end{minted}
```

## Markdown

````markdown
```lua
if opts.dedent then
  ctx.lines = utils.dedent(ctx.lines)
end
```
````

## Norg

```norg
@code lua
if opts.dedent then
  ctx.lines = utils.dedent(ctx.lines)
end
@end
```

## Org Mode

```org
#+begin_src lua
if opts.dedent then
  ctx.lines = utils.dedent(ctx.lines)
end
#+end_src
```

## Plain

```
if opts.dedent then
  ctx.lines = utils.dedent(ctx.lines)
end
```

## reStructuredText

```rst
.. code-block:: lua

   if opts.dedent then
     ctx.lines = utils.dedent(ctx.lines)
   end
```
