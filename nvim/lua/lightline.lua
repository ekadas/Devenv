vim.g.lightline = {
   colorscheme = 'srcery',
   active = {
      left = { { 'mode', 'paste' }, { 'gitbranch', 'readonly', 'filename', 'modified' } },
      right = { { 'lineinfo' }, { 'filetype' } }
   },
   tabline = {
     left = { { 'buffers' } },
     right = {},
   },
   component = {
      lineinfo = "(%c) %{line('.') . '/' . line('$')}",
   },
   component_function = {
      gitbranch = 'FugitiveHead',
      filename = 'LightlineFilename'
   },
   component_expand = {
      buffers = 'lightline#bufferline#buffers'
   },
   component_type = {
      buffers = 'tabsel'
   }
}
