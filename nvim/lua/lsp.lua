local lspconfig = require'lspconfig'
local completion = require'completion'
local sign_define = vim.fn.sign_define

local on_attach = function(client)
   if client.resolved_capabilities.document_formatting then
      vim.api.nvim_command [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 1000)]]
   end

   vim.api.nvim_buf_set_keymap(0, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', {noremap = true})
   vim.api.nvim_buf_set_keymap(0, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', {noremap = true})
   vim.api.nvim_buf_set_keymap(0, 'n', '<space>', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', {noremap = true})
   vim.api.nvim_buf_set_keymap(0, 'n', '<leader>r', '<cmd>lua vim.lsp.buf.rename()<CR>', {noremap = true})
   vim.api.nvim_buf_set_keymap(0, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', {noremap = true})

   vim.api.nvim_buf_set_option(0, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

   completion.on_attach(client)
end

sign_define('LspDiagnosticsSignWarning', {text='⚡'})
sign_define('LspDiagnosticsSignHint', {text='💡'})
sign_define('LspDiagnosticsSignInformation', {text='❕'})
sign_define('LspDiagnosticsSignError', {text='🩸'})

lspconfig.elmls.setup{
   on_attach = on_attach
}

lspconfig.bashls.setup{
   on_attach = on_attach
}

lspconfig.yamlls.setup{
   on_attach = on_attach,
   settings = {
      yaml = {
         schemas = {
            ['https://raw.githubusercontent.com/awslabs/goformation/master/schema/cloudformation.schema.json'] = 'cloudformation/*',
            ['http://json.schemastore.org/github-workflow'] = '.github/workflows/*'
         },
         schemaStore = {
            enable = true
         },
         customTags = {
            "!And scalar", "!And mapping", "!And sequence",
            "!If scalar", "!If mapping", "!If sequence",
            "!Not scalar", "!Not mapping", "!Not sequence",
            "!Equals scalar", "!Equals mapping", "!Equals sequence",
            "!Or scalar", "!Or mapping", "!Or sequence",
            "!FindInMap scalar", "!FindInMap mappping", "!FindInMap sequence",
            "!Base64 scalar", "!Base64 mapping", "!Base64 sequence",
            "!Cidr scalar", "!Cidr mapping", "!Cidr sequence",
            "!Ref scalar", "!Ref mapping", "!Ref sequence",
            "!Sub scalar", "!Sub mapping", "!Sub sequence",
            "!GetAtt scalar", "!GetAtt mapping", "!GetAtt sequence",
            "!GetAZs scalar", "!GetAZs mapping", "!GetAZs sequence",
            "!ImportValue scalar", "!ImportValue mapping", "!ImportValue sequence",
            "!Select scalar", "!Select mapping", "!Select sequence",
            "!Split scalar", "!Split mapping", "!Split sequence",
            "!Join scalar", "!Join mapping", "!Join sequence"
         }
      }
   }
}

lspconfig.jsonls.setup{
   on_attach = function(client)
      client.resolved_capabilities.document_formatting = false
      on_attach(client)
   end,
   settings = {
      json = {
         schemas = {
            {
               description = 'AWS IAM configuration',
               fileMatch = { 'iam/*.json' },
               url = 'https://gist.githubusercontent.com/jstewmon/ee5d4b7ec0d8d60cbc303cb515272f8a/raw/fc6977788b85ea52e9acad0347287516157b5865/aws-iam-poilcy-schema.json'
            }
         }
      }
   }
}

lspconfig.tsserver.setup{
   on_attach = function(client)
      client.resolved_capabilities.document_formatting = false
      on_attach(client)
   end
}

lspconfig.rust_analyzer.setup{
   on_attach = on_attach,
   settings = {
      ['rust-analyzer'] = {
         checkOnSave = {
            enable = true,
            command = 'clippy'
         }
      }
   }
}

lspconfig.efm.setup{
   on_attach = on_attach,
   init_options = {
      documentFormatting = true
   },
   settings = {
      rootMarkers = {".git/"},
      languages = {
         java = {
            {formatCommand = "prettier --parser java", formatStdin = true}
         },
         javascript = {
            {formatCommand = "standard --fix --stdin", formatStdin = true}
         },
         json = {
            {formatCommand = "prettier --parser json", formatStdin = true}
         },
         yaml = {
            {formatCommand = "prettier --parser yaml", formatStdin = true}
         }
      }
   }
}

lspconfig.cssls.setup{
   on_attach = on_attach
}
