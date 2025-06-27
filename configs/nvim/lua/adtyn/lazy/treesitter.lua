return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local configs = require("nvim-treesitter.configs")

    configs.setup({
      ensure_installed = {
        -- Core
        "lua", "vim", "vimdoc",

        -- Languages from system config
        "python",
        "c", "cpp", "make", "cmake",
        "java",
        "javascript", "typescript", "html", "css", "json",
        "elixir",
        "rust",
        "go",
	"dart",
        "bash", "fish",

        -- Optional extras
        "markdown", "markdown_inline",
        "yaml", "toml",
        "dockerfile",
	"nix",
        "gitignore"
      },

      sync_install = false,
      highlight = { enable = true },
      indent = { enable = true },
    })
  end
}

