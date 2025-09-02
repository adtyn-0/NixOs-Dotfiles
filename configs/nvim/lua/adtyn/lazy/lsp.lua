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
       local servers = { "clangd", "pyright", "gopls", "lua_ls", "nil_ls" , "rust_analyzer", "asm_lsp" }
  
         for _, server in ipairs(servers) do
                 local server_opts = {}
  
                       if server == "clangd" then
                               server_opts.cmd = { "/run/current-system/sw/bin/clangd" }
                                     elseif server == "lua_ls" then
                                             server_opts.cmd = { "/run/current-system/sw/bin/lua-language-server" }
                                                   elseif server == "asm_lsp" then
                                                           server_opts.cmd = { "/run/current-system/sw/bin/asm-lsp" }
                                                                   server_opts.filetypes = { "asm", "s" }
                                                                         end
  
                                                                               lspconfig[server].setup(server_opts)
                                                                                   end
                                                                                     end,
                                                                                     }
  

