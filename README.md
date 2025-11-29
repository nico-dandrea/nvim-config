# Neovim Configuration Notes

This Neovim setup is defined in `lua/mine/` with packer.nvim. Below is a quick refresher on defaults, custom keymaps, plugins, and user commands that are actually present today.

## Core Behaviour
- Relative numbers, 4-space indentation, persistent undo (`~/.vim/undodir`), hidden swap/backup files.
- Searches highlight incrementally; completed matches are not kept highlighted (`hlsearch = false`).
- `colorcolumn` at 80 helps enforce line length hints; signs and diagnostics always visible (`signcolumn = yes`).

## Frequently Used Keymaps
| Mode | Mapping | Description |
|------|---------|-------------|
| Normal | `<leader>pv` | Open the built-in netrw explorer in the current directory. |
| Normal | `<leader>f` | Format buffer via attached LSP. |
| Normal | `<leader>s` | Pre-fill a global substitute for the word under cursor; adjust flags before hitting Enter. |
| Normal | `<leader>x` | Make current file executable (`chmod +x %`). |
| Normal | `<leader>ee` | Insert a Go-style `if err != nil {}` guard and return the error. |
| Normal | `<leader><leader>` | Source the current file (used for quick reloading Lua configs). |
| Normal | `<leader>zig` | Restart LSP servers (via `:LspRestart`). |
| Visual | `J` / `K` | Move the selected block down/up, preserving selection. |
| Visual | `<leader>p` | Paste without overwriting the default register. |
| Normal/Visual | `<leader>y`, `<leader>Y`, `<leader>d` | Yank/delete to the system clipboard or black-hole register. |
| Normal | `<C-d>`, `<C-u>` | Half-page scroll with the cursor recentred. |
| Normal | `n`, `N` | Jump to next/previous search match and recenter. |
| Normal | `J` | Join lines without moving the cursor off the join point. |

### Diagnostic and LSP Helpers
Using `lsp-zero` defaults with `lspsaga.nvim`:
- `gd`, `gD`, `gr`, `K`, `<leader>vca`, `<leader>vd`, `<leader>vrn` etc. follow standard `lsp-zero` bindings—hover (`K`), go to definition (`gd`), rename (`<leader>vrn`), code actions (`<leader>vca`), diagnostics float (`<leader>vd`), and signature help in insert (`<C-h>`).
- Quickfix navigation: `<C-k>` (`:cnext`), `<C-j>` (`:cprev`) with recentering.
- Location list navigation: `<leader>k`, `<leader>j`.

### Debugging (nvim-dap)
These mappings are attached buffer-locally whenever a buffer loads:
- `<F5>` continue/start, `<F10>` step over, `<F11>` step into, `<F12>` step out.
- `<leader>b` toggle breakpoint, `<leader>B` set conditional breakpoint, `<leader>dr` open the DAP REPL.

### Collaboration
When the optional `vim-with-me` plugin is installed:
- `<leader>vwm` starts a shared session, `<leader>svwm` stops it.

## Tabs & Windows Basics
| Action | Mapping/Command | Notes |
|--------|-----------------|-------|
| Open a new tab | `:tabnew {file}` or `:tabnew` | Omit `{file}` for an empty buffer. |
| Close tab | `:tabclose` (`:tabc`) | Add `{count}` to close a specific tab: `:tabc 3`. |
| Move to next/previous tab | `gt`, `gT` | Prefix with a count (`3gt`) to jump directly. |
| Jump to specific tab | `{count}gt`, `:tabfirst`, `:tablast` | Built-ins handle numbered jumps. |
| Split current window into new tab | `:tab split`, `<C-w>T` | `:tab split` duplicates the buffer; `<C-w>T` moves the current split. |
| Close all other tabs | `:tabonly` | Keeps only the focused tab open. |
| Jump to first/last tab | `:tabfirst`, `:tablast` | `1gt` is equivalent to `:tabfirst`. |
| Reorder current tab | `:tabmove {idx}` | `:tabmove 0` pushes it to the front. |
| Split current buffer | `:vsp`, `:sp` | Use `<C-w>w` to rotate focus among splits. |
| Close split | `<C-w>q` | Matches `:close` for the window under the cursor. |

### Navigating Splits
- `<C-w>h/j/k/l` jumps between splits in the given direction.
- `<C-w>=` equalizes split sizes; `<C-w>_` and `<C-w>|` maximize height/width.
- `:wincmd H/J/K/L` moves the current split to another edge.

## Custom Commands
- `:Sail` and `:Artisan` proxy Sail/Artisan invocations using the local `vendor/bin/sail` if present.
- `:Config` opens the Neovim config directory, `:ReloadConfig` sources `init.lua` and prints a confirmation.
- `:TrimWhitespace` strips trailing spaces in the current buffer, `:WhereAmI` echos the current working directory and file.

## Plugin Quick Hits
- **Telescope** (`<leader>ff`, `<leader>fg`, etc. via defaults) and **Harpoon** are available once configured via their standard keymaps.
- **undotree**: toggle with `:UndotreeToggle` to use the persisted undo history.
- **gitsigns** overlays inline Git indicators; check `:Gitsigns` for commands. `vim-fugitive` (`:G`, `:Git`) is installed for full Git workflows.
- **Nordic** colorscheme is installed; apply with `:colorscheme nordic`.

Keep this file in sync with `lua/mine/remap.lua`, `lua/mine/commands.lua`, and plugin configs when changes are made.

## Core Motions Refresher
| Motion | Description | Tips |
|--------|-------------|------|
| `h` `j` `k` `l` | Move left/down/up/right | Prepend counts: `5j` skips five lines. |
| `w` / `b` / `e` | Jump between words | `W`, `B`, `E` treat punctuation as separators. |
| `0` / `^` / `$` | Start of line / first non-blank / end of line | `g_` jumps to last non-blank. |
| `gg` / `G` | First / last line of buffer | `:{count}` or `{count}G` jumps to a line number. |
| `Ctrl-f` / `Ctrl-b` | Page down / up | `Ctrl-d` / `Ctrl-u` already mapped to recenter. |
| `%` | Jump to matching bracket or keyword pair | Works for `()`, `{}`, `[]`, HTML tags, etc. |

### Occurrence Jumps
- `/pattern` or `?pattern` start a search; hit `Enter` then `n`/`N` to advance or reverse.
- Use counts with `n` to reach the nth hit immediately (`5n` jumps to the fifth occurrence).
- `:keeppatterns normal! n` retains the last pattern if you need to script movements.
- Combine with marks: set `ma` before a search to return quickly via `'a`.
