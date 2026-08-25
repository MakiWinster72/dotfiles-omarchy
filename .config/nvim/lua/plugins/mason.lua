return {
  "mason-org/mason.nvim",
  opts = {
    -- NOTE: 这里加了代理, 如果 mason 出了问题可以尝试删除本配置
    github = {
      download_url_template = "https://gh-proxy.com/https://github.com/%s/releases/download/%s/%s",
    },
  },
}
