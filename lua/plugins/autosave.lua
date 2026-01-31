return {
  {
    "pocco81/auto-save.nvim",
    opts = {
      trigger_events = { "InsertLeave" },
      debounce_delay = 200,
      condition = function(buf)
        local buftype = vim.bo[buf].buftype
        if buftype ~= "" then
          return false
        end

        local filetype = vim.bo[buf].filetype
        local ignore = {
          "alpha",
          "dashboard",
          "lazy",
          "neo-tree",
          "NvimTree",
          "oil",
          "TelescopePrompt",
        }
        for _, ft in ipairs(ignore) do
          if ft == filetype then
            return false
          end
        end

        return true
      end,
    },
  },
}
