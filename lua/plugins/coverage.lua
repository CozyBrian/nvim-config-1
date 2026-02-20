return {
  "andythigpen/nvim-coverage",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("coverage").setup({
      commands = true,
      auto_reload = false,
      signs = {
        covered = { hl = "CoverageCovered", text = "▎" },
        uncovered = { hl = "CoverageUncovered", text = "▎" },
      },
      highlights = {
        covered = { link = "DiffAdd" },
        uncovered = { link = "DiffDelete" },
      },
      -- summary = {
      --  min_coverage = 80.0,
      -- },
      lang = {
        java = {
          coverage_file = function()
            return vim.fn.getcwd() .. "/build/reports/jacoco/test/jacocoTestReport.xml"
          end,
        },
      },
    })
    -- Optional keymaps
    vim.keymap.set("n", "<leader>ml", "<cmd>CoverageLoad<cr>", { desc = "Coverage Load" })
    vim.keymap.set("n", "<leader>mt", "<cmd>CoverageToggle<cr>", { desc = "Coverage Toggle" })
    vim.keymap.set("n", "<leader>mS", "<cmd>CoverageSummary<cr>", { desc = "Coverage summary" })
  end,
}
