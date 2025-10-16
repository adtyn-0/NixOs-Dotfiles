-- lua/adtyn/lazy/code_runner.lua
return {
"CRAG666/code_runner.nvim",
config = function()
require("code_runner").setup({
  mode = "better_term"
    })
end,
}
