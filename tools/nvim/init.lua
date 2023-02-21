local keymap = vim.keymap.set

local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.local/share/nvim/plugged')

-- All the lua functions I don't want to write twice
Plug('nvim-lua/plenary.nvim')

-- auto closes brackets
Plug('jiangmiao/auto-pairs')

-- status bar
Plug('nvim-lualine/lualine.nvim')

-- fuzzy finder
Plug('junegunn/fzf', { dir = '~/.fzf',['do'] = vim.fn['fzf#install'] })

-- git
Plug('tpope/vim-fugitive')

-- snippets
Plug('L3MON4D3/LuaSnip')
Plug('saadparwaiz1/cmp_luasnip')

-- lsp
Plug('williamboman/mason.nvim')
Plug('williamboman/mason-lspconfig.nvim')
Plug('neovim/nvim-lspconfig')
Plug('jose-elias-alvarez/null-ls.nvim')
Plug('jay-babu/mason-null-ls.nvim')

-- completion
Plug('hrsh7th/cmp-nvim-lsp')
Plug('hrsh7th/cmp-buffer')
Plug('hrsh7th/cmp-path')
Plug('hrsh7th/cmp-cmdline')
Plug('hrsh7th/nvim-cmp')

-- treesitter
Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' })

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
vim.g.loaded_python3_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0

-- line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- shows preview for substitute
vim.opt.inccommand = 'split'

-- remap copy paste
keymap('n', '<leader>y', '"+y', { noremap = true })
keymap('n', '<leader>p', '"+p', { noremap = true })

-- buffer shortcuts
keymap('n', '<C-l>', ':bnext<CR>', { noremap = true })
keymap('n', '<C-h>', ':bprevious<CR>', { noremap = true })
keymap('n', '<C-w>', ':bd<CR>', { noremap = true })

-- fzf configs
keymap('n', '<C-p>', ':FZF<CR>', { noremap = true })
vim.g.fzf_layout = { down = '~20%' }

-- colors
vim.g.t_co = 256
vim.opt.termguicolors = true
vim.cmd [[colorscheme srcery]]

-- more responsive timeout
vim.opt.ttimeoutlen = 50

-- filetype specifics
local filetypeGroup = vim.api.nvim_create_augroup("FiletypeSpecifics", { clear = true })
-- enable spell checking
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' },
   { pattern = '*.md', command = 'setlocal spell spelllang=en_gb', group = filetypeGroup })
-- associate justfiles
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' },
   { pattern = 'justfile', command = 'setf make', group = filetypeGroup })

-- languages - configures treesitter, lsp and formatters and linters
require('languages')

-- colorize
require('colorizer').setup()

-- commenter
require('Comment').setup()

-- completion
require('completion')

-- do not show current mode since it is already shown by lualine
vim.opt.showmode = false

-- statusline
require('lualine').setup({
   options = {
      icons_enabled = false,
      component_separators = '|',
      section_separators = ''
   },
   sections = {
      lualine_a = { 'mode' },
      lualine_b = { 'FugitiveHead' },
      lualine_c = { { 'filename', path = 1 } },
      lualine_x = { 'diagnostics' },
      lualine_y = { 'filetype' },
      lualine_z = { 'location' }
   },
   tabline = {
      lualine_a = { {
         'buffers',
         show_filename_only = false,
         buffers_color = {
            active = { bg = 51, fg = 236 },
            inactive = { bg = 236, fg = 51 }
         },
         symbols = {
            modified = ' ●',
            alternate_file = ''
         }
      } }
   }
})

-- diagnostic signs
local signs = { Error = '🩸', Warn = '⚡', Hint = '💡', Info = '❕' }
for type, icon in pairs(signs) do
   local hl = "DiagnosticSign" .. type
   vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Nerdtree
keymap('n', '<C-n>', ':NERDTreeToggle<CR>', { noremap = true })
vim.api.nvim_create_autocmd('BufEnter',
   { pattern = '*', command = "if (winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree()) | q | endif" })

-- svelte
vim.g.vim_svelte_plugin_use_typescript = 1
