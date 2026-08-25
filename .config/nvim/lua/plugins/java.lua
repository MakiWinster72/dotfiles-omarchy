return {
  {
    "mfussenegger/nvim-jdtls",
    opts = function(_, opts)
      opts.settings = vim.tbl_deep_extend("force", opts.settings or {}, {
        java = {
          completion = {
            -- `List` 等同名类型的自动导入不要候选 `java.awt.*`，避免误选 AWT。
            -- JDTLS 同时会在补全、快速修复和整理 import 时应用此过滤规则。
            filteredTypes = {
              "java.awt.*",
              "com.sun.*",
              "sun.*",
              "jdk.*",
              "org.graalvm.*",
              "io.micrometer.shaded.*",
            },
          },
        },
      })
    end,
  },
}
