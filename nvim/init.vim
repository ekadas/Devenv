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

" Python
Plug 'Vimjas/vim-python-pep8-indent', { 'for': 'python' }

" javascript
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'maxmellon/vim-jsx-pretty', { 'for': 'javascript' }

" typescript
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }

" html
Plug 'vim-scripts/HTML-AutoCloseTag', { 'for': 'html' }

" elm
Plug 'andys8/vim-elm-syntax', { 'for': 'elm', 'do': 'npm install -g elm elm-test elm-format' }

" rust
Plug 'rust-lang/rust.vim', { 'for': 'rust' }

" editorconfig
Plug 'editorconfig/editorconfig-vim'

" prettier
Plug 'prettier/vim-prettier', { 'do': 'npm install && npm install -g prettier prettier-plugin-java' }

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
autocmd! BufWritePost * Neomake

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
autocmd Filetype py 
   \ setlocal tabstop=4
   \ setlocal softtabstop=4
   \ setlocal shiftwidth=4
   \ setlocal textwidth=71
   \ setlocal fileformat=unix
   \ setlocal encoding=utf-8
let python_highlight_all=1

" javascript
let g:neomake_javascript_enabled_makers = ['standard']
autocmd Filetype javascript setlocal ts=2 sw=2 sts=2

" json
autocmd Filetype json setlocal ts=2 sw=2 sts=2

" yaml
autocmd Filetype yaml setlocal ts=2 sw=2 sts=2

" elm
autocmd Filetype elm setlocal ts=4 sw=4 sts=4

" rust
let g:rustfmt_autosave = 1

" lsp
lua require('lsp')
autocmd BufWritePre *.elm,*.rs lua vim.lsp.buf.formatting_sync(nil, 1000)

" completion
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
imap <silent> <s-tab> <Plug>(completion_trigger)
set completeopt=menuone,noinsert,noselect

" Nerdtree
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" prettier
autocmd BufWritePre *.java PrettierAsync
autocmd BufWritePre *.json PrettierAsync
