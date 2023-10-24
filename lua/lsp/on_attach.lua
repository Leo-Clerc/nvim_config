return function(client, bufnr)
  local keymap = function(keys, func, desc)
    if desc then
      desc = "LSP: ".. desc
    end
    vim.api.nvim_buf_set_keymap(bufnr, "n", keys, func, { noremap = true, silent = true, desc = desc})
  end

  keymap("<Leader>lr", "<CMD>lua vim.lsp.buf.rename()<CR>", "Rename")
  keymap("<Leader>lc", "<CMD>lua vim.lsp.buf.code_action()<CR>", "Code action")
  keymap("<Leader>gd", "<CMD>lua vim.lsp.buf.definition()<CR>", "Go to definition")
  keymap("<Leader>tlr", "<CMD>lua require('telescope.builtin').lsp_references()<CR>", "Telescope for references")
  keymap("<Leader>gi", "<CMD>lua vim.lsp.buf.implementation()<CR>", "Goto implementation")
  keymap("<Leader>ld", "<CMD>lua vim.lsp.buf.type_definition()<CR>", "Type definition")
  keymap("<Leader>tld", "<CMD>lua require('telescope.builtin').lsp_document_symbols()<CR>", "Document symbols")
  keymap("<Leader>tlw", "<CMD>lua require('telescope.builtin').lsp_workspace_symbols()<CR>", "Workspace symbols")
  keymap("K", "<CMD>lua vim.lsp.buf.hover()<CR>", "Hover Documentation")
  keymap("<C-m>", "<CMD>lua vim.lsp.buf.signature_help()<CR>", "Signature documentation")
  keymap("<Leader>ln", "<CMD>lua vim.diagnostic.goto_next()<CR>", "Goto next diagnostic")
  keymap("<Leader>lp", "<CMD>lua vim.diagnostic.goto_prev()<CR>", "Goto prev diagnostic")

  	vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
		vim.lsp.buf.format()
	end, { desc = "Format current buffer with LSP" })

  if client.server_capabilities.documentHighlight then
    vim.api.nvim_exec(
      [[
        augroup lsp_document_highlight
          autocmd! * <buffer>
          autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
          autocma CursorMoved <buffer> lua vim.lsp.buf.clear_references()
        augroup END
      ]],
      false
    )
  end

end
