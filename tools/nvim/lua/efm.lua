local prettier = function(parameters)
   parameters = parameters or ""
   return {
      formatCommand = "prettier --stdin-filepath ${INPUT} " .. parameters,
      formatStdin = true
   }
end

local efm_config = {
   javascript = {
      {
         formatCommand = "standard --fix --stdin",
         formatStdin = true
      }
   },
   typescript = {
      {
         formatCommand = "ts-standard --fix --stdin --stdin-filename ${INPUT}",
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

return efm_config
