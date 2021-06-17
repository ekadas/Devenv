require'nvim-treesitter.configs'.setup {
   ensure_installed = { "bash", "comment", "css", "elm", "html", "java", "javascript", "json", "lua", "python", "rust", "toml", "typescript", "yaml" },
   ignore_install = { "haskell" },
   highlight = {
      enable = true,
   },
   indent = {
      enable = false
   }
}
