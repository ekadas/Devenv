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
Plug 'carlitux/deoplete-ternjs', { 'for': 'javascript', 'do': 'npm install -g tern' }
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'maxmellon/vim-jsx-pretty', { 'for': 'javascript' }

" typescript
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
Plug 'ianks/vim-tsx', { 'for': 'typescriptreact' }

" html
Plug 'vim-scripts/HTML-AutoCloseTag', { 'for': 'html' }

" stylus
Plug 'wavded/vim-stylus', { 'for': 'stylus' }

" rust
Plug 'sebastianmarkow/deoplete-rust', { 'for': 'rust', 'do': 'cargo +nightly install racer; rustup component add rust-src' }

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

" allows copy in visual mode
:vnoremap <C-c> "+y

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

" typescript
au BufNewFile,BufRead *.tsx setlocal ft=typescript
let g:neomake_typescript_enabled_makers = ['tslint']
autocmd Filetype typescript setlocal ts=2 sw=2 sts=2

" json
autocmd Filetype json setlocal ts=2 sw=2 sts=2
let g:neomake_typescript_enabled_makers = ['jsonlint']

" yaml
autocmd Filetype yaml setlocal ts=2 sw=2 sts=2

" jinja
au BufNewFile,BufRead *.jinja setlocal ft=yaml
autocmd Filetype jinja setlocal ts=2 sw=2 sts=2

" stylus
autocmd Filetype stylus setlocal ts=2 sw=2 sts=2

" stylus
autocmd Filetype scss setlocal ts=2 sw=2 sts=2

" ruby
autocmd Filetype ruby setlocal ts=2 sw=2 sts=2

" groovy
autocmd Filetype groovy setlocal ts=3 sw=3 sts=3
au BufNewFile,BufReadPost Jenkinsfile set filetype=groovy

" tf
autocmd Filetype tf setlocal ts=2 sw=2 sts=2

" rust
let g:neomake_rust_enabled_makers = ['cargo']
let g:neomake_rust_cargo_command = ['check']
let g:rustfmt_autosave = 1
let g:deoplete#sources#rust#racer_binary = expand('$HOME') . '/.cargo/bin/racer'
let g:deoplete#sources#rust#rust_source_path = system('echo -n "$(rustc --print sysroot)"') . '/lib/rustlib/src/rust/src'

" Nerdtree
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

filetype plugin indent on
