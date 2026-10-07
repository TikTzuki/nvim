# Cheat sheet

Leader is **Space**. Press `<space>` and pause: which-key lists what comes next.
Open this file any time with `<space>?`. Toggle rendering with `<space>m`.

## Survive

| Keys | What |
|---|---|
| `Esc Esc` | In the Claude panel: leave terminal mode, back to normal mode |
| `i` | Back into the terminal (insert) |
| `Ctrl-w h/j/k/l` | Move between windows, works from the panel too |
| `:q` / `:qa!` | Close window / quit everything without saving |
| `u` / `Ctrl-r` | Undo / redo |
| `:w` | Save |

## Claude

| Keys | What |
|---|---|
| `<space>ac` | Toggle the Claude panel (starts Claude connected to this Neovim) |
| `<space>af` | Focus the panel |
| `<space>ar` / `<space>aC` | Resume a past session (picker) / continue the last one here |
| `<space>as` (visual) | Send the selected lines to Claude with file and range |
| `<space>as` (in oil / explorer) | Add the file under the cursor to Claude's context |
| `<space>ab` | Add the whole current buffer |
| `<space>aa` / `<space>ad` | Accept / reject the diff Claude opened |
| `<space>am` | Pick the model |
| `Shift-Enter`, `Ctrl-j` | Newline in the prompt without sending |
| `Ctrl-g` | Edit the prompt in `$VISUAL` (set `export VISUAL=nvim`) |
| `Shift-Tab` | Cycle permission mode: default → accept edits → plan |
| `/clear` · `/compact` · `/diff` · `/ide` | New task · shrink context · see changes · attach an editor |
| `:ClaudeCodeAdd <path> [from] [to]` | Add any file, optional line range |
| `:ClaudeCodeStatus` | Is the editor server up and is Claude connected |
| `<space>u` | Open a URL from the current buffer (works in the panel) |

Habit: `Shift-Tab` into plan mode for anything non-trivial, read the plan, approve, then review with `<space>aa` / `<space>ad`. `/clear` between unrelated tasks.

## Find

| Keys | What |
|---|---|
| `<space><space>` | Smart find files (recent first) |
| `<space>ff` / `<space>fg` | Find files / live grep in the workspace |
| `<space>fF` / `<space>fG` | Same, limited to the git repo of the current file |
| `<space>fw` | Grep the word under the cursor |
| `<space>fb` / `<space>fr` / `<space>fs` | Buffers / recent files / resume last picker |
| `<space>fp` | Projects |
| `<space>e` | File explorer sidebar |
| `-` | Oil: parent directory as an editable buffer (rename, delete, `:w` to apply) |

## File tree

Two tools, two jobs. The **explorer** (`<space>e`) is a sidebar for looking around.
**Oil** (`-`) turns a directory into a text buffer for changing it.

### Explorer sidebar (`<space>e`, snacks)

| Keys | What |
|---|---|
| `<space>e` | Toggle the sidebar; it opens at the workspace root |
| `j` / `k`, type to filter | Move; typing narrows the tree like a fuzzy finder |
| `l` / `Enter` | Open file, or expand a folder |
| `h` | Collapse the folder (or jump to its parent) |
| `Backspace` | Go up: make the parent the root |
| `.` | Make the folder under the cursor the root |
| `Z` | Collapse everything |
| `a` | New file; end the name with `/` to make a folder |
| `r` / `d` | Rename / delete |
| `c` / `m` | Copy / move the item under the cursor |
| `y` then `p` | Yank a path, paste it (copy) into another folder |
| `o` | Open with the system app |
| `P` | Toggle the preview pane |
| `H` / `I` | Show hidden files / show git-ignored files |
| `u` | Refresh |
| `<space>/` | Grep inside the folder under the cursor |
| `Ctrl-t` | Terminal in the folder under the cursor |
| `Ctrl-c` | `cd` the tab to the folder under the cursor |
| `]g` / `[g` | Next / previous file with git changes |
| `]d` / `[d` | Next / previous file with a diagnostic |
| `<space>as` | Add the file under the cursor to Claude's context |
| `q` / `Esc` | Close |

### Oil (`-`, edit a directory as text)

| Keys | What |
|---|---|
| `-` | Open the parent directory of the current file; `-` again goes up |
| `Enter` | Open the file / enter the folder |
| `Ctrl-s` / `Ctrl-h` / `Ctrl-t` | Open in a vertical split / horizontal split / new tab |
| `Ctrl-p` | Preview |
| edit the text, then `:w` | Rename a line to rename the file, `dd` to delete, `o` + name to create, `yy` + `p` to copy; nothing happens until you save |
| `_` | Open the working directory |
| `` ` `` | `cd` to this directory |
| `g.` | Toggle hidden files (on by default here) |
| `gs` | Change sort order |
| `gx` | Open with the system app |
| `g?` | Oil's own help |
| `Ctrl-c` / `Ctrl-l` | Close / refresh |
| `<space>as` | Add the file under the cursor to Claude's context |

Rule of thumb: browsing and single actions, explorer. Renaming or moving several
files at once, oil, because you can use every normal editing trick and review the
change list before `:w` applies it.

## Pin and switch

| Keys | What |
|---|---|
| `<space>ha` / `<space>hh` | Harpoon: pin this file / open the pin menu |
| `<space>1` … `<space>4` | Jump to pin 1–4 |
| `Shift-l` / `Shift-h` | Next / previous buffer tab |
| `<space>bp` / `<space>bd` / `<space>bo` | Pick a tab / close buffer / close the others |

## Git

| Keys | What |
|---|---|
| `<space>gg` | Neogit status (stage with `s`, commit with `c c`) |
| `<space>gc` / `<space>gl` | Commit / log |
| `<space>ga` | In the commit message buffer: generate a message from the staged diff with Claude |
| `<space>gd` | Diffview of the working tree |
| `<space>gh` / `<space>gH` | History of this file / of the repo |
| `<space>gs` / `<space>gr` / `<space>gp` | Stage / reset / preview the hunk under the cursor |
| `<space>gb` | Blame the current line |

## Clipboard and misc

| Keys | What |
|---|---|
| `<space>y` / `<space>yy` / `<space>p` | Yank selection / yank line / paste, via the system clipboard |
| `:Lazy` | Plugin manager: `U` update, `S` sync, `L` log |
| `:checkhealth` | When something feels broken |
