# export QT_QPA_PLATFORMTHEME="qt6ct"
export QT_QPA_PLATFORM=wayland
# export XDG_CURRENT_DESKTOP=KDE
export KDE_SESSION_VERSION=6

# export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export INPUT_METHOD=fcitx
export SDL_IM_MODULE=fcitx
export GLFW_IM_MODULE=ibus
export NO_PROXY=maki,localhost,master,192.168.1.0/24,172.20.10.0/28,registry.npmmirror.com

# Proxy rust
export RUSTUP_UPDATE_ROOT=https://mirrors.aliyun.com/rustup/rustup
export RUSTUP_DIST_SERVER=https://mirrors.aliyun.com/rustup
# goproxy
export GOPROXY="${GOPROXY:-https://goproxy.cn,direct}"
export GOSUMDB="${GOSUMDB:-off}"
export PATH="$HOME/go/bin:$PATH"
# JAVA
# export JAVA_HOME=/usr/lib/jvm/java-21-openjdk
# export PATH=$JAVA_HOME/bin:$PATH
# NOTE: Node.js / NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"

export EDITOR="nvim"
export FREERDP_COMMAND="xfreerdp3"
export BROWSER="/usr/bin/google-chrome-stable"
# XDG_MENU_PREFIX=arch- kbuildsycoca6
export HTTP_PROXY="http://127.0.0.1:7890"
export HTTPS_PROXY="http://127.0.0.1:7890"
export ALL_PROXY="http://127.0.0.1:7890"

export PATH="$HOME/.npm-global/bin:$PATH"
# 先清理 man 的 ANSI 控制码，再交给 bat 渲染，避免出现 1m/4m 等原始转义文本。
export MANOPT='-L zh_CN'
export MANPAGER="env LANG=zh_CN.UTF-8 nvim +Man!"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
