--vim.lsp.config('pyright', {})
--vim.lsp.config('gopls', {})
--vim.lsp.config('golangci_lint_ls', {})
--vim.lsp.config('clangd', {})
--vim.lsp.config('lua_ls', {})
---- TODO: replace with ts_ls
--vim.lsp.config('ts_ls', {})
----vim.lsp.config('helm_ls', {
----  settings = {
----    ["helm-ls"] = {
----      yamlls = {
----        path = "yaml-language-server",
----      }
----    }
----  }
----})
--
--vim.lsp.enable('pyright')
--vim.lsp.enable('gopls')
--vim.lsp.enable('golangci_lint_ls')
--vim.lsp.enable('clangd')
--vim.lsp.enable('lua_ls')
---- TODO: replace with ts_ls
--vim.lsp.enable('ts_ls')

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

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    -- vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

    -- vim.keymap.set("n", "<space>wl", function()
    --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    -- end, { buffer = ev.buf, desc = "asdf" })
    --vim.keymap.set("n", "<leader>g", function()
    --  vim.lsp.buf.format { async = true }
    --end, { buffer = ev.buf, desc = "asdf" })

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Goto Definition", buffer = ev.buf })
    vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "References", nowait = true, buffer = ev.buf })
    vim.keymap.set("n", "gI", vim.lsp.buf.implementation, { desc = "Goto Implementation", buffer = ev.buf })
    vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, { desc = "Goto T[y]pe Definition", buffer = ev.buf })
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Goto Declaration", buffer = ev.buf })
    vim.keymap.set("n", "K", function() return vim.lsp.buf.hover({ border = "rounded" }) end, { desc = "Hover", buffer = ev.buf })
    vim.keymap.set("n", "gK", function() return vim.lsp.buf.signature_help() end, { desc = "Signature Help", buffer = ev.buf })
    vim.keymap.set("i", "<c-k>", function() return vim.lsp.buf.signature_help() end, { desc = "Signature Help", buffer = ev.buf })
    vim.keymap.set({"n", "x"}, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action", buffer = ev.buf })
    vim.keymap.set({"n", "x"}, "<leader>cc", vim.lsp.codelens.run, { desc = "Run Codelens", buffer = ev.buf })
    vim.keymap.set("n", "<leader>cC", vim.lsp.codelens.refresh, { desc = "Refresh & Display Codelens", buffer = ev.buf })
    vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename", buffer = ev.buf })
    vim.keymap.set("n", "<leader>cA", vim.lsp.buf.code_action, { desc = "Source Action", buffer = ev.buf })
    --vim.keymap.set("n", "<leader>cl", function() Snacks.picker.lsp_config() end, { desc = "Lsp Info" })
    --vim.keymap.set("n", "<leader>cR", function() Snacks.rename.rename_file() end, { desc = "Rename File", has = { "workspace/didRenameFiles", "workspace/willRenameFiles" }})
    --vim.keymap.set("n", "]]", function() Snacks.words.jump(vim.v.count1) end, has = "documentHighlight", { desc = "Next Reference", enabled = function() return Snacks.words.is_enabled() end })
    --vim.keymap.set("n", "[[", function() Snacks.words.jump(-vim.v.count1) end, has = "documentHighlight", { desc = "Prev Reference", enabled = function() return Snacks.words.is_enabled() end })
    --vim.keymap.set("n", "<a-n>", function() Snacks.words.jump(vim.v.count1, true) end, has = "documentHighlight", { desc = "Next Reference", enabled = function() return Snacks.words.is_enabled() end })
    --vim.keymap.set("n", "<a-p>", function() Snacks.words.jump(-vim.v.count1, true) end, has = "documentHighlight", { desc = "Prev Reference", enabled = function() return Snacks.words.is_enabled() end })

    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    --patterns = {}
    --for i, ft in ipairs(client.config.filetypes or {}) do
    --  if fts[ft] ~= nil then
    --    table.insert(patterns, fts[ft])
    --  end
    --end
    --if client.server_capabilities.documentFormattingProvider and next(patterns) ~= nil then
    --  vim.api.nvim_create_autocmd("BufWritePre", {
    --    pattern = patterns,
    --    callback = function()
    --      vim.lsp.buf.format { async = false }
    --    end
    --  })
    --end
  end,
})
