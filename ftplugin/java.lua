local ok, jdtls = pcall(require, "jdtls")
if not ok then
  return
end

local root_dir = jdtls.setup.find_root({
  ".git",
  "mvnw",
  "gradlew",
  "pom.xml",
  "build.gradle",
  "build.gradle.kts",
  "settings.gradle",
  "settings.gradle.kts",
})
if not root_dir then
  return
end

local mason = vim.fn.stdpath("data") .. "/mason"
local equinox_launcher = vim.fn.glob(mason .. "/share/jdtls/plugins/org.eclipse.equinox.launcher_*.jar")
local config_path = mason .. "/share/jdtls/config"
local lombok_path = mason .. "/share/jdtls/lombok.jar"

local workspace_dir = vim.fn.stdpath("cache") .. "/jdtls/"
local project_name = vim.fn.fnamemodify(root_dir, ":t")
local workspace_folder = workspace_dir .. project_name

local bundles = {}
vim.list_extend(bundles, vim.fn.globpath(mason .. "/share/java-test", "*.jar", true, true))
vim.list_extend(
  bundles,
  vim.fn.globpath(mason .. "/share/java-debug-adapter", "com.microsoft.java.debug.plugin-*.jar", true, true)
)

local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

local config = {
  cmd = {
    "java",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-javaagent:" .. lombok_path,
    "-Xmx1g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens",
    "java.base/java.util=ALL-UNNAMED",
    "--add-opens",
    "java.base/java.lang=ALL-UNNAMED",
    "-jar",
    equinox_launcher,
    "-configuration",
    config_path,
    "-data",
    workspace_folder,
  },

  root_dir = root_dir,

  settings = {
    java = {
      server = { launchMode = "Hybrid" },
      extendedClientCapabilities = extendedClientCapabilities,

      eclipse = { downloadSources = true },
      maven = { downloadSources = true },
      gradle = { enabled = true },

      format = {
        enabled = true,
        settings = {
          url = vim.fn.stdpath("config") .. "/formatter/eclipse.xml",
          profile = "GoogleStyle",
        },
      },

      references = { includeDecompiledSources = true },

      implementationsCodeLens = { enabled = true },
      referenceCodeLens = { enabled = true },

      inlayHints = {
        parameterNames = { enabled = "all" },
      },

      signatureHelp = {
        enabled = true,
        description = { enabled = true },
      },

      contentProvider = { preferred = "fernflower" },

      completion = {
        favoriteStaticMembers = {
          "org.hamcrest.MatcherAssert.assertThat",
          "org.hamcrest.Matchers.*",
          "org.hamcrest.CoreMatchers.*",
          "org.junit.jupiter.api.Assertions.*",
          "java.util.Objects.requireNonNull",
          "java.util.Objects.requireNonNullElse",
          "org.mockito.Mockito.*",
        },
        filteredTypes = {
          "com.sun.*",
          "io.micrometer.shaded.*",
          "java.awt.*",
          "jdk.*",
          "sun.*",
        },
      },

      codeGeneration = {
        toString = {
          template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
        },
        hashCodeEquals = { useJava7Objects = true },
        useBlocks = true,
      },

      sources = {
        organizeImports = {
          starThreshold = 9999,
          staticStarThreshold = 9999,
        },
      },
    },
    redhat = { telemetry = { enabled = false } },
  },

  init_options = {
    bundles = bundles,
    extendedClientCapabilities = extendedClientCapabilities,
  },

  on_attach = function(client, bufnr)
    pcall(vim.lsp.codelens.refresh)
    jdtls.setup_dap({ hotcodereplace = "auto" })
    local ok_dap, dap = pcall(require, "jdtls.dap")
    if ok_dap then
      dap.setup_dap_main_class_configs()
    end
  end,
}

local augroup = vim.api.nvim_create_augroup("JavaFormat", {})

vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup,
  pattern = "*.java",
  callback = function()
    vim.lsp.buf.format()
  end,
})

jdtls.start_or_attach(config)
