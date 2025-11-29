# Regex Tips in Neovim

Neovim uses Vim’s regular-expression engine. These pointers focus on day-to-day edits and mesh well with the current configuration (`incsearch` enabled, `hlsearch` off by default).

## Fast Searching
- `/pattern` — forward search; `?pattern` for backward. Because `incsearch` is on, matches preview live as you type.
- Press `n` / `N` to jump through matches; the remaps recenter the cursor every time.
- Toggle match highlights temporarily with `:set hlsearch` and `:set nohlsearch`.
- Use `*` / `#` to search for the exact word under cursor; combine with `cgn` to change successive matches.

## Magic Modes
- Default mode escapes many characters (`\(`, `\+`, …). Add `\v` at the start for “very magic” (most characters are magic) or `\V` for “very nomagic”.
- Example: `:%s/\vfoo(\d+)/foo_<\1>/g` wraps digits captured by `(\d+)` without extra escapes.

## Substitution Patterns
- `:[range]s/{pattern}/{replacement}/{flags}`. Common flags: `g` (global on line), `c` (confirm), `i` (case-insensitive), `e` (suppress errors).
- Use `\zs`/`\ze` to set start/end of the match: `:%s/https\zs:\/\/\ze[^ ]*/ /` strips the scheme.
- Use `\=` to evaluate Vimscript in the replacement: `:%s/\d\+/\=submatch(0) + 1/g` increments numbers.
- Repeat the last substitution with `:%&` or `:&&`. `g&` repeats on the current line only.

## Visual Selection Tricks
- Select text, then `:s///` acts on the selection automatically (`'<,'>` range). `%` targets the whole file.
- `:'<,'>s/\%Vpattern/replacement/g` limits the match to the visual area even if the regex reaches outside.

## Global Command (`:g`)
- `:g/{pattern}/normal @a` — run a macro on every matching line.
- `:v/{pattern}/d` — delete lines that do *not* match (`:v` == inverse global).
- Combine with captures: `:g/\vTODO\((.+)\)/echo submatch(1)` prints captured names.

## Searching & Replacing Literals
- `\V` switches to “very nomagic,” treating almost everything literally: `/\V.*foo/bar` finds the exact string `.*foo/bar`.
- For literal replacements, you can also `ctrl-r` and `=` to paste register content (`:%s/foo/<C-r>0/g`).

## Testing Patterns
- Use `:lua vim.fn.matchstr(line, pattern)` in the command line to test quickly.
- `:%s///gn` (note trailing `n`) counts matches without changing text—useful to verify a pattern.

## Helpful Built-ins
- `:help pattern`, `:help :s`, and `:help \v` are go-to references.
- `:set gdefault` makes `:s` apply globally on each line by default; toggle it per session if you prefer.
- When crafting longer patterns, create a scratch buffer (`:new`) and leverage multi-line substitutions with `\_s` (matches whitespace including newlines).

Because `hlsearch` is disabled after every search in this config, use `:set hlsearch` when you need persistent highlights while iterating on a regex, then `:nohl` to clear once you’re done.
