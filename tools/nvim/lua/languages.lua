require("mason").setup()
local keymap = vim.keymap.set

vim.api.nvim_create_autocmd('LspAttach', {
   callback = function(ev)
      local client = vim.lsp.get_client_by_id(ev.data.client_id)
      local bufnr = ev.buf
      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

      if client:supports_method("textDocument/formatting") then
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
})

vim.lsp.config('*', {
   capabilities = require('cmp_nvim_lsp').default_capabilities()
})

vim.lsp.config('rust_analyzer', {
   -- Server-specific settings. See `:help lsp-quickstart`
   settings = {
      ['rust-analyzer'] = {
         check = {
            command = 'clippy'
         }
      },
   },
})

vim.lsp.config('ts_ls', {
   cmd = { "typescript-language-server", "--stdio" },
   root_markers = { "package.json" },
   workspace_required = true,
   capabilities = {
      documentFormattingProvider = false,
      documentRangeFormattingProvider = false,
   }
})

vim.lsp.config('denols', {
   cmd = { "deno", "lsp" },
   root_markers = { "deno.json" },
   workspace_required = true,
   capabilities = {
      documentFormattingProvider = true,
      documentRangeFormattingProvider = true,
   }
})

vim.lsp.config('yamlls', {
   cmd = { 'yaml-language-server', '--stdio' },
   filetypes = { 'yaml' },
   root_markers = { '.git' },
   settings = {
      -- https://github.com/redhat-developer/vscode-redhat-telemetry#how-to-disable-telemetry-reporting
      redhat = { telemetry = { enabled = false } },
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
   },
   capabilities = {
      documentFormattingProvider = false,
      documentRangeFormattingProvider = false,
   }
})

vim.lsp.enable({
   'cssls',
   'dartls',
   'elmls',
   'html',
   'lua_ls',
   'prismals',
   'rust_analyzer',
   'bashls',
   'terraformls',
   'ts_ls',
   'denols',
   'eslint_d',
})

-- configure treesitter
require 'nvim-treesitter.configs'.setup({
   ensure_installed = {
      'comment',
      'css',
      'dart',
      'dockerfile',
      'elm',
      'html',
      'javascript',
      'json',
      'lua',
      'markdown',
      'prisma',
      'python',
      'rust',
      'bash',
      'sql',
      'toml',
      'terraform',
      'typescript',
      'yaml',
   },
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
   automatic_installation = { exclude = { 'jdtls' } }
})
