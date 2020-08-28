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

" Autocompletion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'neovim/nvim-lsp'

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

" elm
Plug 'andys8/vim-elm-syntax', { 'for': 'elm', 'do': 'npm install -g elm elm-test elm-format @elm-tooling/elm-language-server' }

" rust
Plug 'sebastianmarkow/deoplete-rust', { 'for': 'rust', 'do': 'cargo +nightly install racer; rustup component add rust-src; rustup component add clippy' }
Plug 'rust-lang/rust.vim', { 'for': 'rust' }

" graphql
Plug 'jparise/vim-graphql', { 'for': 'graphql' }

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

" statusline
set showtabline=2
let g:lightline = {
      \ 'colorscheme': 'srcery_drk',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'filetype' ] ]
      \ },
      \ 'tabline': {
      \   'left': [ [ 'buffers' ] ],
      \   'right': [],
      \ },
      \ 'component': {
      \   'lineinfo': "%{line('.') . '/' . line('$')}",
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ 'component_expand': {
      \   'buffers': 'lightline#bufferline#buffers'
      \ },
      \ 'component_type': {
      \   'buffers': 'tabsel'
      \ }
      \ }
if !has('gui_running')
  set t_Co=256
endif
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
autocmd Filetype typescript setlocal noexpandtab

" json
autocmd Filetype json setlocal ts=2 sw=2 sts=2
let g:neomake_json_enabled_makers = ['jsonlint']

" yaml
autocmd Filetype yaml setlocal ts=2 sw=2 sts=2

" jinja
au BufNewFile,BufRead *.jinja setlocal ft=yaml
autocmd Filetype jinja setlocal ts=2 sw=2 sts=2

" elm
autocmd Filetype elm setlocal ts=4 sw=4 sts=4

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
let g:neomake_rust_cargo_command = ['clippy']
let g:rustfmt_autosave = 1
let g:deoplete#sources#rust#racer_binary = expand('$HOME') . '/.cargo/bin/racer'
let g:deoplete#sources#rust#rust_source_path = system('echo -n "$(rustc --print sysroot)"') . '/lib/rustlib/src/rust/src'

" lsp
function LS_maps()
   setlocal omnifunc=v:lua.vim.lsp.omnifunc
   nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
   nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
   nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
endfunction
lua <<EOF
require'nvim_lsp'.elmls.setup{}
EOF
" Execute the bindings for supported languages
autocmd FileType elm call LS_maps()
autocmd BufWritePre *.elm lua vim.lsp.buf.formatting_sync(nil, 1000)

" Nerdtree
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" prettier
autocmd BufWritePre *.java PrettierAsync
autocmd BufWritePre *.json PrettierAsync
autocmd BufWritePre *.yaml PrettierAsync

filetype plugin indent on
