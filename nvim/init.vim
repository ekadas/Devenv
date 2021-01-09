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

" linting like behaviour
Plug 'neomake/neomake'

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

call plug#end()

let g:python_host_prog = expand('$HOME') . '/.pyenv/versions/nvim2/bin/python'
let g:python3_host_prog = expand('$HOME') . '/.pyenv/versions/nvim3/bin/python'

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
vnoremap <leader>y "+y
nnoremap <leader>y "+y
vnoremap <leader>p "+p
nnoremap <leader>p "+p

" buffer shortcuts
:noremap <C-l> :bnext<CR>
:noremap <C-h> :bprevious<CR>
:noremap <C-w> :bd<CR>

" visually selected text search
:vnoremap // y/<C-R>"<CR>

" fzf configs
:noremap <C-p> :FZF<CR>
let g:fzf_layout = { 'down': '~20%' }

" colors
colorscheme srcery

" neomake
let g:neomake_open_list=2
autocmd! BufWritePost *.java Neomake

" more responsive timeout
set ttimeoutlen=50

" lightline
set showtabline=2
set noshowmode
set laststatus=2
if !has('gui_running')
  set t_Co=256
endif
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

" rust
let g:rustfmt_autosave = 1

" completion
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
imap <silent> <s-tab> <Plug>(completion_trigger)
set completeopt=menuone,noinsert,noselect

" lsp
lua require('lsp')

" Nerdtree
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
