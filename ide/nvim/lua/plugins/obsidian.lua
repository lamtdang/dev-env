return {
  "epwalsh/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = "markdown",
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
  --   -- refer to `:h file-pattern` for more examples
  --   "BufReadPre path/to/my-vault/*.md",
  --   "BufNewFile path/to/my-vault/*.md",
  -- },
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",

    -- see below for full list of optional dependencies 👇
    "nvim-telescope/telescope.nvim",
    "hrsh7th/nvim-cmp",
    "nvim-treesitter",
  },
  opts = {
    workspaces = {

      {
        name = "mind-palace",
        path = "~/personal/nous",
      },
    },

    daily_notes = {
      folder = "daygram",
      date_format = "%Y-%m-%d",
      alias_format = "%B %-d, %Y",
      template = "daily_notes.md",
      default_tags = { "daily-notes" },
    },
    -- see below for full list of options 👇
    templates = {
      folder = "template",
    },

    completion = {
      nvim_cmp = true,
      min_chars = 2,
    },
    new_notes_location = "current_dir",
  },
}
