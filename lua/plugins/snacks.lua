return {
  "folke/snacks.nvim",
  opts = function(_, opts)
    opts.picker = opts.picker or {}
    opts.picker.sources = opts.picker.sources or {}
    opts.picker.sources.explorer = opts.picker.sources.explorer or {}
    opts.picker.sources.explorer = {
      hidden = true,
      ignored = false,
    }
    opts.picker.sources.explorer.layout = opts.picker.sources.explorer.layout or {}
    opts.picker.sources.explorer.layout.layout = opts.picker.sources.explorer.layout.layout or {}
    opts.picker.sources.explorer.layout.layout.position = "right"
    return opts
  end,
}
