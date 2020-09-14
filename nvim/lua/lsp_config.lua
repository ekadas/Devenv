require'nvim_lsp'.elmls.setup{}

require'nvim_lsp'.bashls.setup{}

require'nvim_lsp'.yamlls.setup{
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

require'nvim_lsp'.jsonls.setup{
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

require'nvim_lsp'.tsserver.setup{}

require'nvim_lsp'.rust_analyzer.setup{
   settings = {
      ['rust-analyzer'] = {
         checkOnSave = {
            enable = true,
            command = 'clippy'
         }
      }
   }
}
