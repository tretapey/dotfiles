-- ============================================================================
-- Plugin Management — lazy.nvim + nvim-treesitter
-- ============================================================================

-- Bootstrap lazy.nvim (auto-installs on first run)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Parsers to install
local parsers = {
  "svelte", "vue",
  "html", "css", "javascript", "typescript",
  "lua", "python", "bash",
  "json", "yaml", "markdown",
  "go", "rust",
}

-- Plugins
require("lazy").setup({
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      -- In Neovim 0.11+, tree-sitter highlighting is built-in.
      -- nvim-treesitter only manages parser installation.
      -- Install parsers that aren't already installed.
      local installed = require("nvim-treesitter.config").get_installed()
      local to_install = vim.tbl_filter(function(p)
        return not vim.list_contains(installed, p)
      end, parsers)

      if #to_install > 0 then
        require("nvim-treesitter.install").install(to_install)
      end
    end,
  },
}, {
  ui = { border = "rounded" },
  checker = { enabled = false },
})
