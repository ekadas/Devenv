call plug#begin('~/.local/share/nvim/plugged')

" auto closes brackets
Plug 'jiangmiao/auto-pairs'

" status bar
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'

" fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" git
Plug 'tpope/vim-fugitive'

" snippets
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'

" lsp
Plug 'neovim/nvim-lspconfig'

" completion
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

" treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" quick commenting
Plug 'numToStr/Comment.nvim'

" surround
Plug 'tpope/vim-surround'

" Colorscheme
Plug 'srcery-colors/srcery-vim'

" Nerdtree
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

" javascript
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'maxmellon/vim-jsx-pretty', { 'for': 'javascript' }

" html
Plug 'vim-scripts/HTML-AutoCloseTag', { 'for': 'html' }

" rust
Plug 'rust-lang/rust.vim', { 'for': 'rust' }

" editorconfig
Plug 'editorconfig/editorconfig-vim'

" jsonnet
Plug 'google/vim-jsonnet'

" color highligher
Plug 'norcalli/nvim-colorizer.lua'

" svelte
Plug 'leafOfTree/vim-svelte-plugin'

call plug#end()

" disable providers
let g:loaded_python_provider = 0
let g:loaded_node_provider = 0

" line numbers
set number
set relativenumber

" shows preview for substitute
set inccommand=split

" remap copy paste
noremap <leader>y "+y
noremap <leader>p "+p

" buffer shortcuts
noremap <C-l> :bnext<CR>
noremap <C-h> :bprevious<CR>
noremap <C-w> :bd<CR>

" visually selected text search
vnoremap // y/<C-R>"<CR>

" fzf configs
noremap <C-p> :FZF<CR>
let g:fzf_layout = { 'down': '~20%' }

" colors
set t_Co=256
set termguicolors
colorscheme srcery

" more responsive timeout
set ttimeoutlen=50

" enable spell checking
autocmd BufRead,BufNewFile *.md setlocal spell spelllang=en_gb

" lightline
set showtabline=2
set noshowmode
set laststatus=2
function! LightlineFilename()
  let root = fnamemodify(get(b:, 'git_dir'), ':h')
  let path = expand('%:p')
  if path[:len(root)-1] ==# root
    return path[len(root)+1:]
  endif
  return expand('%')
endfunction
lua require('lightline')

" set up lua plugins
lua require('plugins')

" Nerdtree
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" svelte
let g:vim_svelte_plugin_use_typescript = 1
