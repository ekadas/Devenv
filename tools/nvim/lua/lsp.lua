local lspconfig = require'lspconfig'
local completion = require'completion'

local sign_define = vim.fn.sign_define
sign_define('LspDiagnosticsSignWarning', {text='⚡'})
sign_define('LspDiagnosticsSignHint', {text='💡'})
sign_define('LspDiagnosticsSignInformation', {text='❕'})
sign_define('LspDiagnosticsSignError', {text='🩸'})

local on_attach = function(client)
   if client.resolved_capabilities.document_formatting then
      vim.api.nvim_command [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 1500)]]
   end

   vim.api.nvim_buf_set_keymap(0, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', {noremap = true})
   vim.api.nvim_buf_set_keymap(0, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', {noremap = true})
   vim.api.nvim_buf_set_keymap(0, 'n', '<space>', '<cmd>lua vim.diagnostic.goto_next()<CR>', {noremap = true})
   vim.api.nvim_buf_set_keymap(0, 'n', '<leader>r', '<cmd>lua vim.lsp.buf.rename()<CR>', {noremap = true})
   vim.api.nvim_buf_set_keymap(0, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', {noremap = true})
   vim.api.nvim_buf_set_keymap(0, 'n', 'ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', {noremap = true})

   vim.api.nvim_buf_set_option(0, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

   completion.on_attach(client)
end

lspconfig.elmls.setup{
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

lspconfig.bashls.setup{
   on_attach = on_attach
}

lspconfig.yamlls.setup{
   on_attach = on_attach,
   settings = {
      yaml = {
         schemas = {
            ['https://cfn-schema.y13i.com/schema?region=eu-west-2&version=latest'] = 'cloudformation/*',
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

lspconfig.jsonls.setup{
   on_attach = function(client)
      client.resolved_capabilities.document_formatting = false
      on_attach(client)
   end,
   settings = {
      json = {
         format = {
            enable = false
         },
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

lspconfig.tsserver.setup{
   on_attach = function(client)
      client.resolved_capabilities.document_formatting = false
      on_attach(client)
   end
}

lspconfig.rust_analyzer.setup{
   on_attach = on_attach,
}

local prettier = function(parameters)
   parameters = parameters or ""
   return {
      formatCommand = "prettier --stdin-filepath ${INPUT} " .. parameters,
      formatStdin = true
   }
end
local efm_languages = {
   javascript = {
      {
         formatCommand = "standard --fix --stdin",
         formatStdin = true
      }
   },
   java = {
      prettier()
   },
   json = {
      prettier()
   },
   yaml = {
      prettier("--single-quote"),
      {
         lintCommand = "yamllint -f parsable -",
         lintStdin = true,
         lintFormats = {
            "%f:%l %m"
         }
      }
   },
   html = {
      prettier()
   },
   sh = {
      {
         formatCommand = "shfmt -filename ${INPUT}",
         formatStdin = true,
         lintCommand = "shellcheck -f gcc -x",
         lintSource = "shellcheck"
      }
   },
   dockerfile = {
      {
         lintCommand = "hadolint",
         lintFormats = {
            "%f:%l %m"
         }
      }
   },
   markdown = {
      {
         lintCommand = "markdownlint -s -c ${HOME}/.markdownlintrc",
         lintStdin = true,
         lintFormats = {
            "%f:%l %m"
         }
      }
   }
}
lspconfig.efm.setup{
   on_attach = on_attach,
   filetypes = vim.tbl_keys(efm_languages),
   init_options = {
      documentFormatting = true
   },
   settings = {
      rootMarkers = {".git/"},
      languages = efm_languages
   }
}

lspconfig.cssls.setup{
   on_attach = on_attach
}

lspconfig.html.setup{
   on_attach = on_attach
}

lspconfig.sumneko_lua.setup {
   on_attach = on_attach,
   cmd = {"lua-langserver"},
   settings = {
      Lua = {
         runtime = {
            version = 'LuaJIT',
            path = vim.split(package.path, ';'),
         },
         diagnostics = {
            globals = {'vim'},
         },
         workspace = {
            library = {
               [vim.fn.expand('$VIMRUNTIME/lua')] = true,
               [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
            },
         },
      },
   },
}

lspconfig.jdtls.setup {
   on_attach = function(client)
      client.resolved_capabilities.document_formatting = false
      on_attach(client)
   end,
   cmd = {"jdtls"}
}
