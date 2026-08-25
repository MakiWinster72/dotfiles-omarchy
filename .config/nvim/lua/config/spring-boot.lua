-- Spring Boot Tools 由 nvim-java 注入 JDTLS，并启动独立的 Spring Boot LS。
local extension = vim.fn.stdpath("data") .. "/mason/packages/vscode-spring-boot-tools/extension"
local language_server = extension .. "/language-server"
local server_jar = language_server .. "/spring-boot-language-server-2.2.0-SNAPSHOT-exec.jar"
local separator = package.config:sub(1, 1) == "\\" and ";" or ":"

local project = vim.fn.argv(0)
local root = project ~= "" and vim.fs.root(project, {
  "pom.xml",
  "build.gradle",
  "build.gradle.kts",
  "settings.gradle",
  "settings.gradle.kts",
}) or nil

return {
  -- nvim-java 用它查找并注入 STS 的 JDTLS 扩展。
  package = {
    enable = true,
    path = extension,
  },

  -- spring-boot.nvim 的默认命令针对旧版 BOOT-INF 目录；2.2.0 使用主 JAR + lib。
  lsp = {
    ls_path = language_server,
    server = {
      root_dir = root or vim.uv.cwd(),
      cmd = {
        "/usr/lib/jvm/java-25-openjdk/bin/java",
        "-XX:TieredStopAtLevel=1",
        "-Xmx1G",
        "-XX:+UseZGC",
        "-cp",
        server_jar .. separator .. language_server .. "/lib/*",
        "-Dsts.lsp.client=vscode",
        "org.springframework.ide.vscode.boot.app.BootLanguageServerBootApp",
      },
    },
  },
}
