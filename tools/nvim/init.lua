local g = vim.g
local opt = vim.opt
local keymap = vim.keymap.set
local cmd = vim.cmd
local fn = vim.fn
local autocmd = vim.api.nvim_create_autocmd

local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.local/share/nvim/plugged')

-- auto closes brackets
Plug('jiangmiao/auto-pairs')

-- status bar
Plug('nvim-lualine/lualine.nvim')

-- fuzzy finder
Plug('junegunn/fzf', { dir = '~/.fzf', ['do'] = fn['fzf#install'] })

-- git
Plug('tpope/vim-fugitive')

-- snippets
Plug('L3MON4D3/LuaSnip')
Plug('saadparwaiz1/cmp_luasnip')

-- lsp
Plug('neovim/nvim-lspconfig')

-- completion
Plug('hrsh7th/cmp-nvim-lsp')
Plug('hrsh7th/cmp-buffer')
Plug('hrsh7th/cmp-path')
Plug('hrsh7th/cmp-cmdline')
Plug('hrsh7th/nvim-cmp')

-- treesitter
Plug('nvim-treesitter/nvim-treesitter', {['do'] = ':TSUpdate'})

-- quick commenting
Plug('numToStr/Comment.nvim')

-- surround
Plug('tpope/vim-surround')

-- Colorscheme
Plug('srcery-colors/srcery-vim')

-- Nerdtree
Plug('scrooloose/nerdtree', { on = 'NERDTreeToggle' })

-- javascript
Plug('pangloss/vim-javascript', { ['for'] = 'javascript' })
Plug('maxmellon/vim-jsx-pretty', { ['for'] = 'javascript' })

-- html
Plug('vim-scripts/HTML-AutoCloseTag', { ['for'] = 'html' })

-- rust
Plug('rust-lang/rust.vim', { ['for'] = 'rust' })

-- editorconfig
Plug('editorconfig/editorconfig-vim')

-- jsonnet
Plug('google/vim-jsonnet')

-- color highligher
Plug('norcalli/nvim-colorizer.lua')

-- svelte
Plug('leafOfTree/vim-svelte-plugin')

vim.call('plug#end')

-- disable providers
g.loaded_python_provider = 0
g.loaded_node_provider = 0

-- line numbers
opt.number = true
opt.relativenumber = true

-- shows preview for substitute
opt.inccommand = 'split'

-- remap copy paste
keymap('n', '<leader>y', '"+y', { noremap = true })
keymap('n', '<leader>p', '"+p', { noremap = true })

-- buffer shortcuts
keymap('n', '<C-l>', ':bnext<CR>', { noremap = true })
keymap('n', '<C-h>', ':bprevious<CR>', { noremap = true })
keymap('n', '<C-w>', ':bd<CR>', { noremap = true })

-- fzf configs
keymap('n', '<C-p>', ':FZF<CR>', { noremap = true })
g.fzf_layout = { down = '~20%' }

-- colors
g.t_co = 256
opt.termguicolors = true
cmd[[colorscheme srcery]]

-- more responsive timeout
opt.ttimeoutlen = 50

-- no separate command line
opt.cmdheight = 0

-- enable spell checking
autocmd({ 'BufRead', 'BufNewFile' }, { pattern = '*.md', command = 'setlocal spell spelllang=en_gb' })

-- set up lua plugins
require('plugins')

-- Nerdtree
keymap('n', '<C-n>', ':NERDTreeToggle<CR>', { noremap = true })
autocmd('BufEnter', { pattern = '*', command = "if (winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree()) | q | endif"})

-- svelte
g.vim_svelte_plugin_use_typescript = 1
