return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      {
        "roobert/tailwindcss-colorizer-cmp.nvim",
        config = true,
      },
    },
    opts = function(_, opts)
      local format_kinds = opts.formatting and opts.formatting.format
      opts.formatting = opts.formatting or {}
      opts.formatting.format = function(entry, item)
        if format_kinds then
          item = format_kinds(entry, item)
        end
        return require("tailwindcss-colorizer-cmp").formatter(entry, item)
      end
    end,
  },
  {
    "NvChad/nvim-colorizer.lua",
    opts = {
      user_default_options = {
        tailwind = true,
        css = true,
        mode = "background",
      },
      filetypes = {
        "css",
        "html",
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "svelte",
        "vue",
        "astro",
      },
    },
  },
}
