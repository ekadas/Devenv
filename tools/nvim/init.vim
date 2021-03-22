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

" lsp
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'

" quick commenting
Plug 'scrooloose/nerdcommenter'

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

call plug#end()

" disable providers
let g:loaded_python_provider = 0
let g:loaded_python3_provider = 0
let g:loaded_ruby_provider = 0
let g:loaded_perl_provider = 0
let g:loaded_node_provider = 0

" line numbers
set number
set relativenumber

" indentation
set tabstop=3
set shiftwidth=3
set expandtab

" F2 now toggles past mode
set pastetoggle=<F2>

" allows switching buffers without save
set hidden

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

" python
let python_highlight_all=1

" completion
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
imap <silent> <s-tab> <Plug>(completion_trigger)
set completeopt=menuone,noinsert,noselect
let g:completion_chain_complete_list = [
    \{'complete_items': ['lsp']},
    \{'mode': '<c-p>'}
\]
let g:completion_auto_change_source = 1

" lsp
lua require('lsp')

" colorize
lua require'colorizer'.setup()

" Nerdtree
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
