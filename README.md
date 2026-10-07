# nvim config

Minimal Neovim setup built around lazy.nvim: tokyonight, Claude Code integration,
and fast file navigation for large multi-repo workspaces.

## Install on a new machine

```bash
# prerequisites
brew install neovim ripgrep fd
brew install --cask font-jetbrains-mono-nerd-font   # then set it as your terminal font

# the config
git clone <this-repo-url> ~/.config/nvim
nvim        # lazy.nvim bootstraps itself and installs all plugins on first start
```

`lazy-lock.json` is committed on purpose — it pins every plugin to the exact
commit this config was last tested with, so a fresh install reproduces this setup.
Update plugins with `:Lazy update` (writes the lockfile), then commit the change.

## Plugins

| Plugin | Role |
|--------|------|
| `folke/lazy.nvim` | plugin manager (self-bootstraps) |
| `folke/tokyonight.nvim` | colorscheme (storm) |
| `coder/claudecode.nvim` | Claude Code panel (`<leader>a*`) |
| `folke/snacks.nvim` | picker (files/grep/buffers/recent) + explorer |
| `stevearc/oil.nvim` | edit directories as buffers (`-`) |
| `ThePrimeagen/harpoon` (harpoon2) | pin hot files, jump with `<leader>1..4` |
| `echasnovski/mini.icons` | filetype icons (needs a Nerd Font in the terminal) |
| `folke/which-key.nvim` | pause after `<space>` to see what comes next |

## Keymaps (leader = space)

Full list in [`CHEATSHEET.md`](CHEATSHEET.md); open it inside Neovim with `<space>?`.

| Keys | Action |
|------|--------|
| `<space><space>` | smart find files (frecency) |
| `<space>ff` / `<space>fg` | find files / live grep — whole workspace (cwd) |
| `<space>fF` / `<space>fG` | find files / live grep — git repo of current file |
| `<space>fw` | grep word under cursor |
| `<space>fb` / `<space>fr` / `<space>fs` | buffers / recent / resume last picker |
| `<space>e` | explorer sidebar |
| `-` | oil: parent directory as editable buffer |
| `<space>ha` / `<space>hh` | harpoon: pin file / menu |
| `<space>1`–`<space>4` | harpoon: jump to pin 1–4 |
| `<space>ac` / `<space>af` / `<space>ar` | Claude: toggle / focus / resume |
| `<space>as` (visual) | send selection to Claude |
| `<space>aa` / `<space>ad` | accept / deny Claude diff |
| `Ctrl-w h/j/k/l` (terminal mode) | window navigation out of the Claude/terminal panel |
