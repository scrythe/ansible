return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = { "lua_ls", "tsserver", "html" },
    },
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local lspconfig = require("lspconfig")

      lspconfig.lua_ls.setup({ capabilities = capabilities })
      lspconfig.tsserver.setup({ capabilities = capabilities })
      lspconfig.html.setup({ capabilities = capabilities })

      vim.diagnostic.config({
        severity_sort = true,
      })

      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Goto Declaration" })
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Goto Definition" })
      vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover" })
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Goto Implementation" })
      vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, { desc = "Goto Typedefinion" })
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename" })
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
      vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Goto  References" })
      vim.keymap.set("n", "<leader>df", vim.diagnostic.open_float, { desc = "Open Diagnostic Window" })
      vim.keymap.set("n", "<leader>lr", "<cmd>LspRestart<CR>", { desc = "Restart Lsp Server" })
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Goto next Diagnostic" })
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Goto previous Diagnostic" })
      vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Diagnostic set Locallist" })
    end,
  },
}
