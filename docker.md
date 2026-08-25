# Docker 中国大陆镜像源配置

这里配置的是 Docker Hub 的中国大陆镜像源（registry mirror），不是 `HTTP_PROXY`，也不走本机 `127.0.0.1:7890`。

## 配置文件

编辑 `/etc/docker/daemon.json`，在保留原有配置的基础上加入：

```json
{
  "registry-mirrors": [
    "https://docker.1ms.run",
    "https://docker.1panel.live"
  ]
}
```

当前系统的完整配置示例：

```json
{
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "10m",
    "max-file": "5"
  },
  "dns": [
    "172.17.0.1"
  ],
  "bip": "172.17.0.1/16",
  "registry-mirrors": [
    "https://docker.1ms.run",
    "https://docker.1panel.live"
  ]
}
```

> 不要直接用示例覆盖已有的 `daemon.json`，应将 `registry-mirrors` 合并进去，避免丢失原有 Docker 设置。

## 应用配置

修改前先备份：

```bash
sudo cp -a /etc/docker/daemon.json \
  "/etc/docker/daemon.json.backup.$(date +%Y%m%d-%H%M%S)"
```

检查 JSON 格式，然后重启 Docker：

```bash
python -m json.tool /etc/docker/daemon.json >/dev/null
sudo systemctl restart docker
```

重启 Docker 会中断当前正在运行的容器，操作前可先检查：

```bash
docker ps
```

## 验证

```bash
docker info | grep -A5 'Registry Mirrors'
```

预期输出包含：

```text
Registry Mirrors:
 https://docker.1ms.run/
 https://docker.1panel.live/
```

也可以实际拉取镜像测试：

```bash
docker pull hello-world
```

## 排错

如果镜像站失效、证书异常或拉取失败：

1. 检查镜像站当前是否可访问；公共镜像站可能更换域名或停止服务。
2. 临时从 `registry-mirrors` 中删除失效地址。
3. 使用备份恢复配置：

```bash
sudo cp /etc/docker/daemon.json.backup.<时间戳> /etc/docker/daemon.json
sudo systemctl restart docker
```

Docker 服务级 HTTP 代理通常位于 `/etc/systemd/system/docker.service.d/proxy.conf`。本配置不需要该文件；如之前配置过 `127.0.0.1:7890`，应删除后重新加载并重启：

```bash
sudo rm -f /etc/systemd/system/docker.service.d/proxy.conf
sudo systemctl daemon-reload
sudo systemctl restart docker
```
