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
Plug 'nvim-lua/diagnostic-nvim'

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
Plug 'andys8/vim-elm-syntax', { 'for': 'elm', 'do': 'npm install -g elm elm-test elm-format @elm-tooling/elm-language-server' }

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

" sets use of system clipboard
set clipboard+=unnamedplus

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

" statusline
set showtabline=2
let g:lightline = {
      \ 'colorscheme': 'srcery',
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
      \   'lineinfo': "(%c) %{line('.') . '/' . line('$')}",
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead',
      \   'filename': 'LightlineFilename'
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
function LS_maps()
   setlocal omnifunc=v:lua.vim.lsp.omnifunc
   nnoremap <silent> K       <cmd>lua vim.lsp.buf.hover()<CR>
   nnoremap <silent> gd      <cmd>lua vim.lsp.buf.definition()<CR>
   nnoremap <silent> <space> <cmd>NextDiagnosticCycle<CR>
endfunction
lua require("lsp_config")
" Execute the bindings for supported languages
autocmd FileType elm,sh,bash,yaml,json,javascript,rust call LS_maps()
autocmd BufWritePre *.elm,*.rs lua vim.lsp.buf.formatting_sync(nil, 1000)
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
imap <silent> <s-tab> <Plug>(completion_trigger)
set completeopt=menuone,noinsert,noselect
sign define LspDiagnosticsHintSign text=💡
sign define LspDiagnosticsErrorSign text=🩸
sign define LspDiagnosticsWarningSign text=⚡

" Nerdtree
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" prettier
autocmd BufWritePre *.java PrettierAsync
autocmd BufWritePre *.json PrettierAsync
