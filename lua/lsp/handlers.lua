return {
  function(server_name)
    local capabilities = require('cmp_nvim_lsp').default_capabilities()
    local on_attach = require "lsp.on_attach"
    local opts = {
      settings = {
        capabilities = capabilities,
        on_attach = on_attach,
      },
    }
    require("lspconfig")[server_name].setup {opts}

  end,
 ["lua_ls"] = function ()
     require("lspconfig").lua_ls.setup {
         on_attach = require "lsp.on_attach",
         capabilities = require("cmp_nvim_lsp").default_capabilities(),
         settings = {
             Lua = {
                 diagnostics = {
                     globals = { "vim" }
                 }
             }
         }
     }
 end,
}
