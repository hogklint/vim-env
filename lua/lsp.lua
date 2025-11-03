vim.lsp.config('pyright', {})
vim.lsp.config('gopls', {})
vim.lsp.config('golangci_lint_ls', {})
vim.lsp.config('clangd', {})
vim.lsp.config('lua_ls', {})
-- TODO: replace with ts_ls
vim.lsp.config('ts_ls', {})
--vim.lsp.config('helm_ls', {
--  settings = {
--    ["helm-ls"] = {
--      yamlls = {
--        path = "yaml-language-server",
--      }
--    }
--  }
--})

vim.lsp.enable('pyright')
vim.lsp.enable('gopls')
vim.lsp.enable('golangci_lint_ls')
vim.lsp.enable('clangd')
vim.lsp.enable('lua_ls')
-- TODO: replace with ts_ls
vim.lsp.enable('ts_ls')

--local capabilities = require("cmp_nvim_lsp").default_capabilities()
--lsps = { "pyright", "gopls", "lua_ls", "jsonls", "helm_ls" }
--for i, lsp in ipairs(lsps) do
--  require("lspconfig")[lsp].setup {
--    capabilities = capabilities
--  }
--end


vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
vim.keymap.set("n", "gn", vim.diagnostic.goto_next)
vim.keymap.set("n", "gp", vim.diagnostic.goto_prev)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setqflist)

-- clangd switch source/header
vim.keymap.set("n", "<F5>", ":ClangdSwitchSourceHeader<CR>")

--
-- Mapping for filetype to pattern used to activate automatic formatting on save
--
--fts = { lua = "*.lua", go = "*.go", json = "*.json" }

--vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
--  vim.lsp.handlers.hover, {
--    border = "rounded"
--  }
--)

--vim.api.nvim_create_autocmd("LspAttach", {
--  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
--  callback = function(ev)
--    -- Enable completion triggered by <c-x><c-o>
--    -- vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
--
--    -- Buffer local mappings.
--    -- See `:help vim.lsp.*` for documentation on any of the below functions
--    local opts = { buffer = ev.buf }
--    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = ev.buf, desc = "G"})
--    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = ev.buf, desc = "asdf"})
--    vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = ev.buf, desc = "asdf" })
--    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = ev.buf, desc = "asdf" })
--    vim.keymap.set("n", "gc", vim.lsp.codelens.display, { buffer = ev.buf, desc = "asdf" })
--    -- vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, { buffer = ev.buf, desc = "asdf" })
--    -- vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, { buffer = ev.buf, desc = "asdf" })
--    -- vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, { buffer = ev.buf, desc = "asdf" })
--    -- vim.keymap.set("n", "<space>wl", function()
--    --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
--    -- end, { buffer = ev.buf, desc = "asdf" })
--    -- vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, { buffer = ev.buf, desc = "asdf" })
--    vim.keymap.set("n", "<leader>a", vim.lsp.buf.rename, { buffer = ev.buf, desc = "asdf" })
--    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { buffer = ev.buf, desc = "asdf" })
--    vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = ev.buf, desc = "asdf" })
--    vim.keymap.set("n", "<leader>g", function()
--      vim.lsp.buf.format { async = true }
--    end, { buffer = ev.buf, desc = "asdf" })
--
--    local client = vim.lsp.get_client_by_id(ev.data.client_id)
--    --patterns = {}
--    --for i, ft in ipairs(client.config.filetypes or {}) do
--    --  if fts[ft] ~= nil then
--    --    table.insert(patterns, fts[ft])
--    --  end
--    --end
--    --if client.server_capabilities.documentFormattingProvider and next(patterns) ~= nil then
--    --  vim.api.nvim_create_autocmd("BufWritePre", {
--    --    pattern = patterns,
--    --    callback = function()
--    --      vim.lsp.buf.format { async = false }
--    --    end
--    --  })
--    --end
--  end,
--})
