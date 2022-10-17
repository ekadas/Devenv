local lspconfig = require('lspconfig')
local keymap = vim.keymap.set
local fn = vim.fn
local autocmd = vim.api.nvim_create_autocmd

local signs = { Error = '🩸', Warn = '⚡', Hint = '💡', Info = '❕' }
for type, icon in pairs(signs) do
   local hl = "DiagnosticSign" .. type
   fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local lsp_formatting = function(bufnr)
   vim.lsp.buf.format({
      filter = function(client)
         -- Prefer efm
         return client.name ~= 'tsserver' and client.name ~= 'jsonls' and client.name ~= 'yamlls' and client.name ~= 'jdtls'
      end,
      bufnr = bufnr,
      timeout_ms = 3000
   })
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local on_attach = function(client, bufnr)
   if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      autocmd("BufWritePre", {
         group = augroup,
         buffer = bufnr,
         callback = function()
            vim.lsp.buf.format({
               filter = function()
                  lsp_formatting(bufnr)
               end,
               bufnr = bufnr,
            })
         end
      })
   end

   local opts = { noremap = true, silent = true, buffer = bufnr }
   keymap('n', 'K', vim.lsp.buf.hover, opts)
   keymap('n', 'gd', vim.lsp.buf.definition, opts)
   keymap('n', '<space>', vim.diagnostic.goto_next, opts)
   keymap('n', '<leader>r', vim.lsp.buf.rename, opts)
   keymap('n', 'gr', vim.lsp.buf.references, opts)
   keymap('n', 'ca', vim.lsp.buf.code_action, opts)
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- set up servers with default config
local servers = { 'bashls', 'rust_analyzer', 'cssls', 'html' }
for _, lsp in ipairs(servers) do
   lspconfig[lsp].setup {
      on_attach = on_attach,
      capabilities = capabilities,
   }
end

lspconfig.elmls.setup {
   capabilities = capabilities,
   on_attach = function(client)
      if client.config.flags then
         client.config.flags.allow_incremental_sync = true
      end

      on_attach(client)
   end,
   settings = {
      elmLS = {
         onlyUpdateDiagnosticsOnSave = true
      }
   }
}

lspconfig.yamlls.setup {
   capabilities = capabilities,
   on_attach = on_attach,
   settings = {
      yaml = {
         schemas = {
            ['https://cfn-schema.y13i.com/schema?region=eu-west-2&version=50.0.0'] = 'cloudformation/*',
            ['http://json.schemastore.org/github-workflow'] = '.github/workflows/*'
         },
         format = {
            enable = false
         },
         completion = true,
         hover = true,
         customTags = {
            "!And scalar", "!And mapping", "!And sequence",
            "!Condition scalar", "!Condition mapping", "!Condition sequence",
            "!Base64 scalar", "!Base64 mapping", "!Base64 sequence",
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

lspconfig.jsonls.setup {
   capabilities = capabilities,
   on_attach = on_attach,
   settings = {
      json = {
         schemaDownload = {
            enable = true
         },
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

lspconfig.tsserver.setup {
   capabilities = capabilities,
   on_attach = on_attach,
}

local efm_config = require('efm')
lspconfig.efm.setup {
   capabilities = capabilities,
   on_attach = on_attach,
   filetypes = vim.tbl_keys(efm_config),
   init_options = {
      documentFormatting = true
   },
   settings = {
      rootMarkers = {".git/"},
      languages = efm_config
   }
}

lspconfig.sumneko_lua.setup {
   capabilities = capabilities,
   on_attach = on_attach,
   cmd = {"lua-langserver"},
   settings = {
      Lua = {
         runtime = {
            version = 'LuaJIT'
         },
         diagnostics = {
            globals = {'vim'},
         },
         workspace = {
            library = vim.api.nvim_get_runtime_file("", true),
         },
      },
   },
}

lspconfig.jdtls.setup {
   capabilities = capabilities,
   on_attach = on_attach,
   cmd = {"jdtls"}
}
