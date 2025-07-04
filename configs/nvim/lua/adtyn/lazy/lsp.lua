<<<<<<< HEAD
return {
    "mason-org/mason-lspconfig.nvim",
    opts = {},
    dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "neovim/nvim-lspconfig",
    },
}
=======

return {
  "mason-org/mason-lspconfig.nvim",
  dependencies = {
    { "mason-org/mason.nvim", opts = {} },
    "neovim/nvim-lspconfig",
  },
  opts = {
    ensure_installed = { "pyright", "gopls","nil_ls", "rust_analyzer" }, 
  },
  config = function(_, opts)
    local lspconfig = require("lspconfig")
    local mason_lspconfig = require("mason-lspconfig")

    mason_lspconfig.setup(opts)

    -- Manual server setup
    local servers = { "clangd", "pyright", "gopls", "lua_ls", "nil_ls" , "rust_analyzer" }

    for _, server in ipairs(servers) do
      local server_opts = {}
    
      if server == "clangd" then
          server_opts.cmd = { "/run/current-system/sw/bin/clangd" }
      elseif server == "lua_ls" then
          server_opts.cmd = { "/run/current-system/sw/bin/lua-language-server" }
      end

      lspconfig[server].setup(server_opts)
    end
  end,
}


>>>>>>> 463760b (added kde settings , able to switch around the configs)
