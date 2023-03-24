vim.o.completeopt = 'menuone,noinsert,noselect'

require("copilot").setup({
   suggestion = { enabled = false },
   panel = { enabled = false },
})
require("copilot_cmp").setup()

local has_words_before = function()
   local line, col = unpack(vim.api.nvim_win_get_cursor(0))
   return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local luasnip = require("luasnip")
local cmp = require 'cmp'

cmp.setup({
   mapping = cmp.mapping.preset.insert({
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<CR>'] = cmp.mapping.confirm {
         behavior = cmp.ConfirmBehavior.Replace,
         select = true,
      },
      ['<Tab>'] = cmp.mapping(function(fallback)
         if cmp.visible() then
            cmp.select_next_item()
         elseif has_words_before() then
            cmp.complete()
         else
            fallback()
         end
      end, { 'i', 's' }),
      ['<S-Tab>'] = cmp.mapping(function(fallback)
         if cmp.visible() then
            cmp.select_prev_item()
         else
            fallback()
         end
      end, { 'i', 's' }),
   }),
   snippet = {
      expand = function(args)
         luasnip.lsp_expand(args.body)
      end
   },
   sources = {
      { name = "copilot", keyword_length = 0 },
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
      { name = 'buffer' }
   },
})

cmp.setup.cmdline('/', {
   mapping = cmp.mapping.preset.cmdline(),
   sources = {
      { name = 'buffer' }
   }
})

cmp.setup.cmdline(':', {
   mapping = cmp.mapping.preset.cmdline(),
   sources = cmp.config.sources({
      { name = 'path' }
   }, {
      { name = 'cmdline' }
   })
})
