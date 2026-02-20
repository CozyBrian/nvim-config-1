return {
  "vim-test/vim-test",
  init = function()
    vim.g["test#strategy"] = "vimux"
    vim.g["test#java#runner"] = "gradletest"
    vim.g["test#gradle#executable"] = "./gradlew"
    vim.g["test#java#gradletest#executable"] = "./gradlew test"
  end,
}
