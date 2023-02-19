require("mason").setup()
local keymap = vim.keymap.set

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local function on_attach(client, bufnr)
   if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
         group = augroup,
         buffer = bufnr,
         callback = function()
            vim.lsp.buf.format({ bufnr = bufnr, async = false, timeout_ms = 3000 })
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

local function prettier(parameters)
   parameters = parameters or ''
   return {
      formatCommand = 'prettier --stdin-filepath ${INPUT} ' .. parameters,
      formatStdin = true
   }
end

-- treesitter is installed for each key and lsp and efm are set up according to configuration
local languages = {
   comment = {},
   css = {
      lsp = {
         name = 'cssls',
         config = {
            capabilities = capabilities,
            on_attach = on_attach,
         }
      }
   },
   dockerfile = {
      efm = {
         {
            lintCommand = 'hadolint',
            lintFormats = {
               '%f:%l %m'
            }
         }
      }
   },
   elm = {
      lsp = {
         name = 'elmls',
         config = {
            capabilities = capabilities,
            on_attach = function(client, bufnr)
               if client.config.flags then
                  client.config.flags.allow_incremental_sync = true
               end

               on_attach(client, bufnr)
            end,
            settings = {
               elmLS = {
                  onlyUpdateDiagnosticsOnSave = true
               }
            }
         }
      }
   },
   html = {
      lsp = {
         name = 'html',
         config = {
            capabilities = capabilities,
            on_attach = on_attach,
         }
      },
      efm = {
         prettier()
      }
   },
   java = {
      lsp = {
         name = 'jdtls',
         config = {
            capabilities = capabilities,
            on_attach = function(client, bufnr)
               client.server_capabilities.documentFormattingProvider = false
               client.server_capabilities.documentRangeFormattingProvider = false
               on_attach(client, bufnr)
            end,
            cmd = { 'jdtls' }
         }
      },
      efm = {
         prettier()
      }
   },
   javascript = {
      -- uses tsserver lsp, configured under typescript
      efm = {
         {
            formatCommand = 'standard --fix --stdin',
            formatStdin = true
         }
      }
   },
   json = {
      lsp = {
         name = 'jsonls',
         config = {
            capabilities = capabilities,
            on_attach = function(client, bufnr)
               client.server_capabilities.documentFormattingProvider = false
               client.server_capabilities.documentRangeFormattingProvider = false
               on_attach(client, bufnr)
            end,
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
      },
      efm = {
         prettier()
      }
   },
   lua = {
      lsp = {
         name = 'lua_ls',
         config = {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
               Lua = {
                  runtime = {
                     version = 'LuaJIT'
                  },
                  diagnostics = {
                     globals = { 'vim' },
                  },
                  workspace = {
                     library = vim.api.nvim_get_runtime_file('', true),
                  },
                  telemetry = {
                     enable = false,
                  },
               },
            },
         }
      }
   },
   markdown = {
      efm = {
         {
            lintCommand = 'markdownlint -s -c ${HOME}/.markdownlintrc',
            lintStdin = true,
            lintFormats = {
               '%f:%l %m'
            }
         }
      }
   },
   python = {},
   rust = {
      lsp = {
         name = 'rust_analyzer',
         config = {
            capabilities = capabilities,
            on_attach = on_attach,
         }
      }
   },
   sh = {
      treesitter_name = 'bash',
      lsp = {
         name = 'bashls',
         config = {
            capabilities = capabilities,
            on_attach = on_attach,
         }
      },
      efm = {
         {
            formatCommand = 'shfmt -filename ${INPUT}',
            formatStdin = true,
            lintCommand = 'shellcheck -f gcc -x',
            lintSource = 'shellcheck'
         }
      }
   },
   toml = {},
   typescript = {
      lsp = {
         name = 'tsserver',
         config = {
            capabilities = capabilities,
            on_attach = function(client, bufnr)
               client.server_capabilities.documentFormattingProvider = false
               client.server_capabilities.documentRangeFormattingProvider = false
               on_attach(client, bufnr)
            end
         }
      }
   },
   yaml = {
      lsp = {
         name = 'yamlls',
         config = {
            capabilities = capabilities,
            on_attach = function(client, bufnr)
               client.server_capabilities.documentFormattingProvider = false
               client.server_capabilities.documentRangeFormattingProvider = false
               on_attach(client, bufnr)
            end,
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
                     '!And scalar', '!And mapping', '!And sequence',
                     '!Condition scalar', '!Condition mapping', '!Condition sequence',
                     '!Base64 scalar', '!Base64 mapping', '!Base64 sequence',
                     '!If scalar', '!If mapping', '!If sequence',
                     '!Not scalar', '!Not mapping', '!Not sequence',
                     '!Equals scalar', '!Equals mapping', '!Equals sequence',
                     '!Or scalar', '!Or mapping', '!Or sequence',
                     '!FindInMap scalar', '!FindInMap mappping', '!FindInMap sequence',
                     '!Base64 scalar', '!Base64 mapping', '!Base64 sequence',
                     '!Cidr scalar', '!Cidr mapping', '!Cidr sequence',
                     '!Ref scalar', '!Ref mapping', '!Ref sequence',
                     '!Sub scalar', '!Sub mapping', '!Sub sequence',
                     '!GetAtt scalar', '!GetAtt mapping', '!GetAtt sequence',
                     '!GetAZs scalar', '!GetAZs mapping', '!GetAZs sequence',
                     '!ImportValue scalar', '!ImportValue mapping', '!ImportValue sequence',
                     '!Select scalar', '!Select mapping', '!Select sequence',
                     '!Split scalar', '!Split mapping', '!Split sequence',
                     '!Join scalar', '!Join mapping', '!Join sequence'
                  }
               }
            }
         }
      },
      efm = {
         prettier('--single-quote'),
         {
            lintCommand = 'yamllint -f parsable -',
            lintStdin = true,
            lintFormats = {
               '%f:%l %m'
            }
         }
      }
   },
}

-- configure treesitter
local ensure_installed = {}
for language, config in pairs(languages) do
   if config['treesitter_name'] ~= nil then
      table.insert(ensure_installed, config['treesitter_name'])
   else
      table.insert(ensure_installed, language)
   end
end
require 'nvim-treesitter.configs'.setup({
   ensure_installed = ensure_installed,
   ignore_install = { 'haskell' },
   highlight = {
      enable = true,
   },
   indent = {
      enable = false
   }
})

-- configure mason - lsp package manager
require('mason-lspconfig').setup({
   ensure_installed = { 'lua_ls' },
   automatic_installation = { exclude = { 'jdtls' } }
})

-- configure language specific lsps
local lspconfig = require('lspconfig')
for _, config in pairs(languages) do
   if config['lsp'] ~= nil then
      local lsp_config = config['lsp']
      lspconfig[lsp_config['name']].setup(lsp_config['config'])
   end
end

-- configure efm a generic purpose lsp
local efm_filetypes = {}
local efm_config = {}
for language, config in pairs(languages) do
   if config['efm'] ~= nil then
      table.insert(efm_filetypes, language)
      efm_config[language] = config['efm']
   end
end
lspconfig.efm.setup({
   capabilities = capabilities,
   on_attach = on_attach,
   filetypes = efm_filetypes,
   init_options = {
      documentFormatting = true
   },
   settings = {
      rootMarkers = { ".git/" },
      languages = efm_config
   }
})
