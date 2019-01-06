call plug#begin('~/.local/share/nvim/plugged')

" auto closes brackets
Plug 'jiangmiao/auto-pairs'

" airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" git
Plug 'tpope/vim-fugitive'

" Autocompletion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" quick commenting
Plug 'scrooloose/nerdcommenter'

" surround
Plug 'tpope/vim-surround'

" Colorscheme
Plug 'roosta/srcery'

" linting like behaviour
Plug 'neomake/neomake'

" Nerdtree
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

" Python
Plug 'zchee/deoplete-jedi', { 'for': 'python' }
Plug 'Vimjas/vim-python-pep8-indent', { 'for': 'python' }

" javascript
Plug 'carlitux/deoplete-ternjs', { 'for': 'javascript', 'do': 'sudo npm install -g tern' }
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'maxmellon/vim-jsx-pretty', { 'for': 'javascript' }

" html
Plug 'vim-scripts/HTML-AutoCloseTag', { 'for': 'html' }

" stylus
Plug 'wavded/vim-stylus', { 'for': 'stylus' }

call plug#end()

" get os version
function! GetRunningOS()
  if has("win32")
    return "win"
  endif
  if has("unix")
    if system('uname')=~'Darwin'
      return "mac"
    else
      return "linux"
    endif
  endif
endfunction
let os=GetRunningOS()

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

" buffer shortcuts
:noremap <C-l> :bnext<CR>
:noremap <C-h> :bprevious<CR>
:noremap <C-w> :bd<CR>

" visually selected text search
:vnoremap // y/<C-R>"<CR>

" deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_completion_start_length = 1 
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

" fzf configs
:noremap <C-p> :FZF<CR>
let g:fzf_layout = { 'down': '~20%' }
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" neomake
let g:neomake_open_list=2
autocmd! BufWritePost * Neomake

" colors
set background=dark
colorscheme srcery

" more responsive timeout
set ttimeoutlen=50

" airline & statusline
let g:airline#extensions#tabline#enabled=1
let g:airline_theme='wombat'
set laststatus=2

" python
let g:neomake_python_enabled_makers = ['flake8']
if os=="mac"
   let g:python_host_prog = '/Users/Endre/.pyenv/versions/neovim2/bin/python'
   let g:python3_host_prog = '/Users/Endre/.pyenv/versions/neovim3/bin/python'
else
   let g:python_host_prog = '/home/endre/.virtualenv/neovim2/bin/python'
   let g:python3_host_prog = '/home/endre/.virtualenv/neovim/bin/python'
endif
autocmd Filetype py 
   \ setlocal tabstop=4
   \ setlocal softtabstop=4
   \ setlocal shiftwidth=4
   \ setlocal textwidth=71
   \ setlocal autoindent
   \ setlocal fileformat=unix
   \ setlocal encoding=utf-8
let python_highlight_all=1

" javascript
let g:neomake_javascript_enabled_makers = ['standard']
autocmd Filetype javascript setlocal ts=2 sw=2 sts=2
let g:tern#filetypes = [ 'jsx' ]

" json
autocmd Filetype json setlocal ts=2 sw=2 sts=2

" yaml
autocmd Filetype yaml setlocal ts=2 sw=2 sts=2

" stylus
autocmd Filetype stylus setlocal ts=2 sw=2 sts=2

" groovy
autocmd Filetype groovy setlocal ts=3 sw=3 sts=3
au BufNewFile,BufReadPost Jenkinsfile set filetype=groovy

" tf
autocmd Filetype tf setlocal ts=2 sw=2 sts=2

" Nerdtree
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

filetype plugin indent on
