# Neovim Macros & Built-in Hotkeys

This guide focuses on native Neovim/Vim features that enhance repetition-heavy editing. Everything here works with the current config and does not rely on extra plugins.

## Core Macro Workflow
- `qa` — start recording into register `a` (`q` stops recording).
- `@a` — play the macro stored in register `a`; `@@` repeats the last executed macro.
- `:reg a` — inspect the contents of register `a`.
- `` ` `` vs `'` — when a macro moves to a mark, `` ` `` restores exact column, `'` jumps to the start of the line.

### Example: Wrap each selected word with quotes
1. Place the cursor on the first target word.
2. `qa` — start recording into register `a`.
3. `ciw"<Esc>p` — change the word, insert `"`, escape, then paste the original word inside.
4. `w` — move to the next word.
5. `q` — stop recording.
6. Execute: `@a` for the next word, `@@` to repeat quickly, or `10@a` to run it ten times.

### Example: Append `;` to every line of a block
1. Move to the first line in the block.
2. `qbA;<Esc>j` — record register `b`, append `;` in insert mode, exit, move down.
3. `q` — stop.
4. `@b` once, then use visual selection with `:'<,'>normal @b` to target many lines.

## Helpful Hotkeys While Working with Macros
- `.` — repeats the last change; combine with macros for quick single edits.
- `gqq` / `gqap` — reformat current line or paragraph, useful inside macro recordings.
- `Ctrl-r` `{register}` in insert mode — paste register contents without leaving insert.
- `:normal` — run normal-mode keystrokes via commands: `:%normal @a` applies macro `a` to the whole buffer.

## Managing Macro Registers
- Uppercase register names append (e.g. `qA` adds onto existing macro `a`).
- Named registers (`a`–`z`) survive until overwritten; the `0` register holds the last yank, so avoid it for macros.
- Use the system clipboard if needed: `"+p` pastes macro text, allowing you to edit it in a buffer, then yank back with `"+yy` before assigning (e.g. `"ap`).

## Useful Built-in Motion/Hotkey Pairs
- `*` / `#` — search forward/backward for the word under cursor (pairs nicely with macro loops).
- `f{char}` / `t{char}` — find a character on the current line; use `;` / `,` to repeat within a macro without retyping.
- Marks: `ma` to set, `'a` / `` `a`` to jump; macros often use marks to return to starting points.

## Troubleshooting
- If a macro gets stuck because of errors, press `Ctrl-c` to abort.
- Check `:messages` for errors emitted during macro playback.
- Remember that mappings (including custom ones) are expanded when a macro replays; use `:verbose map {lhs}` if behaviour surprises you.
