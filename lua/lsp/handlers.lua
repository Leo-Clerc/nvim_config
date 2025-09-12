return {
  function(server_name)
    local capabilities = require('cmp_nvim_lsp').default_capabilities()
    local on_attach = require "lsp.on_attach"
    local opts = {
      capabilities = capabilities,
      on_attach = on_attach,
    }
    require("lspconfig")[server_name].setup(opts)

  end,
 ["lua_ls"] = function ()
    local on_attach = require "lsp.on_attach"
     require("lspconfig").lua_ls.setup {
         on_attach = on_attach,
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
 ["texlab"] = function ()
   local on_attach = function(client, bufnr)
            vim.opt.wrap = true
            vim.opt.linebreak = true

            vim.keymap.set("n", "j", "gj", { buffer = bufnr })
            vim.keymap.set("n", "k", "gk", { buffer = bufnr })
        end

        require("lspconfig").texlab.setup({
            on_attach = on_attach,
            capabilities = require("cmp_nvim_lsp").default_capabilities(),
            filetypes = { "tex" }, -- Spécifie les types de fichiers
            settings = {
                texlab = {
                    formatter = "latexindent"
                }
            }
        })
 end
}
