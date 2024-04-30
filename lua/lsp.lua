require("lspconfig").pyright.setup {}
require("lspconfig").gopls.setup {}
require("lspconfig").golangci_lint_ls.setup {}
require("lspconfig").clangd.setup {}
require("lspconfig").lua_ls.setup {}
require("lspconfig").jsonls.setup {
  settings = {
    json = {
      schemas = require("schemastore").json.schemas({
        -- extra = {
        --   {
        --     description = "My custom JSON schema",
        --     fileMatch = "foo.json",
        --     name = "foo.json",
        --     url = "file:///some/path/file.json",
        --   },
        --   {
        --     description = "My other custom JSON schema",
        --     fileMatch = { "bar.json", ".baar.json" },
        --     name = "bar.json",
        --     url = "https://example.com/schema/bar.json",
        --   },
        -- },
      }),
      validate = { enable = true },
    },
  },
}
require("lspconfig").helm_ls.setup {
  settings = {
    ["helm-ls"] = {
      yamlls = {
        path = "yaml-language-server",
      }
    }
  }
}
-- Hmm... I mostly use YAML in Helm and this is not really helpful
-- https://github.com/redhat-developer/yaml-language-server/issues/766
-- https://github.com/mrjosh/helm-ls/issues/44
-- require("lspconfig").yamlls.setup{}


require("lsp_signature").setup({})
local capabilities = require("cmp_nvim_lsp").default_capabilities()
lsps = { "pyright", "gopls", "lua_ls", "jsonls", "helm_ls" }
for i, lsp in ipairs(lsps) do
  require("lspconfig")[lsp].setup {
    capabilities = capabilities
  }
end


vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
vim.keymap.set("n", "gn", vim.diagnostic.goto_next)
vim.keymap.set("n", "gp", vim.diagnostic.goto_prev)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setqflist)

-- clangd switch source/header
vim.keymap.set("n", "<F5>", ":ClangdSwitchSourceHeader<CR>")

--
-- Mapping for filetype to pattern used to activate automatic formatting on save
--
fts = { lua = "*.lua", go = "*.go", json = "*.json" }

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    -- vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    -- vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
    -- vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
    -- vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
    -- vim.keymap.set("n", "<space>wl", function()
    --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    -- end, opts)
    -- vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "<leader>a", vim.lsp.buf.rename, opts)
    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<leader>g", function()
      vim.lsp.buf.format { async = true }
    end, opts)

    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    patterns = {}
    for i, ft in ipairs(client.config.filetypes) do
      if fts[ft] ~= nil then
        table.insert(patterns, fts[ft])
      end
    end
    if client.server_capabilities.documentFormattingProvider and next(patterns) ~= nil then
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = patterns,
        callback = function()
          vim.lsp.buf.format { async = false }
        end
      })
    end
  end,
})
