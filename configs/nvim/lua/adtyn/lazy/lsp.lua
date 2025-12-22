return {
  "mason-org/mason-lspconfig.nvim",
  dependencies = {
    { "mason-org/mason.nvim", opts = {} },
    "neovim/nvim-lspconfig",
  },

  opts = {
    ensure_installed = { "pyright", "gopls", "nil_ls", "rust_analyzer", "lua_ls", "clangd" },
  },

  config = function(_, opts)
    local mason_lspconfig = require("mason-lspconfig")
    mason_lspconfig.setup(opts)

    local servers = {
      clangd = {
        cmd = { "/run/current-system/sw/bin/clangd" },
      },
      lua_ls = {
        cmd = { "/run/current-system/sw/bin/lua-language-server" },
      },
      asm_lsp = {
        cmd = { "/run/current-system/sw/bin/asm-lsp" },
        filetypes = { "asm", "s" },
      },
    }

    for _, server in ipairs(opts.ensure_installed) do
      local server_opts = servers[server] or {}

      vim.lsp.config(server, server_opts)

      vim.lsp.enable(server)
    end
  end,
}
