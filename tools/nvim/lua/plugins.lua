-- lsp
require('lsp')

-- treesitter
require('treesitter')

-- colorize
require('colorizer').setup()

-- commenter
require('Comment').setup()

-- completion
require('completion')

-- lines
require('lualine').setup({
   options = {
      icons_enabled = false,
      component_separators = '|',
      section_separators = ''
   },
   sections = {
      lualine_a = {'mode'},
      lualine_b = {'FugitiveHead'},
      lualine_c = {{'filename', path = 1}},
      lualine_x = {'diagnostics'},
      lualine_y = {'filetype'},
      lualine_z = {'location'}
   },
   tabline = {
      lualine_a = {{
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
      }}
   }
})
