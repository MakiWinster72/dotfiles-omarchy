# cowsay 你好
# 环境检测与基础设置
export ZSH="$HOME/.oh-my-zsh"
export EDITOR="${EDITOR:-nvim}"
export VISUAL="$EDITOR"
umask 022

# NOTE: 自定义命令

alias bilidown='cd ~/.local/share/bilidown && ./bilidown'
alias ni='niri-session'
alias ipa='ip addr show | grep -E "192|172"'
alias li="gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'"
alias dk="gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'"
alias web='browser-sync start --server --files "**/*.*"'
alias oc='opencode'
alias cc='cc-switch'
alias cl='claude --resume'
alias ncim='nvim'
alias nbim='nvim'
alias e='exit'
alias s='spf'
alias c='c3270 172.19.227.253:23'
alias a='lazygit'
alias t='tmux'
alias m='tmux a -t mobile'
alias n='sudo bandwhich'
alias y='yazi'
alias ya='yazi'
alias yaz='yazi'
alias yazi='yazi'
alias yaci='yazi'
alias h='herdr'
alias pir='pi -r'

alias -g NE='2>/dev/null'
alias -g DE='>/dev/null'

# NOTE: 自定义后缀打开

alias -s md='bat'
alias -s yaml='bat -l yaml'
alias -s go='$EDITOR'
alias -s js='$EDITOR'
alias -s ts='$EDITOR'
alias -s c='$EDITOR'
alias -s java='$EDITOR'
alias -s mov='open'
alias -s png='open'
alias -s mp4='open'
alias -s json='jless'

# NOTE: 仅在存在 oh-my-zsh 时启用
if [ -d "$ZSH" ]; then
	ZSH_THEME="juanghurtado"
	plugins=(
		git
		zsh-autosuggestions
		zsh-syntax-highlighting
		fzf
		zsh-completions
		zsh-history-substring-search
	)
	source "$ZSH/oh-my-zsh.sh"
fi

# NOTE: stronger ls

eval "$(zoxide init --cmd cd zsh)"

if command -v lsd >/dev/null 2>&1; then
	alias ls='lsd --group-dirs=first --icon=always'
	alias ll='lsd -lh --group-dirs=first --icon=always'
	alias la='lsd -lha --group-dirs=first --icon=always'
elif command -v eza >/dev/null 2>&1; then
	alias ls='eza --group-directories-first --icons=always'
	alias ll='eza -lh --group-directories-first --icons=always'
	alias la='eza -lha --group-directories-first --icons=always'
	alias lt='eza --tree --level=2 --icons=always'
else
	alias ll='ls -lh --group-directories-first 2>/dev/null || ls -lh'
	alias la='ls -lha --group-directories-first 2>/dev/null || ls -lha'
fi

# NOTE: FZF
if [ -f "${HOME}/.fzf.zsh" ]; then
	source "${HOME}/.fzf.zsh"
fi

if command -v grep >/dev/null 2>&1; then
	alias grep='grep --color=auto'
fi

# NOTE: DOCKER
dksr() {
	if ! command -v docker >/dev/null 2>&1; then
		echo "Docker 未安装"
		return 1
	fi
	if command -v systemctl >/dev/null 2>&1; then
		sudo systemctl start containerd.service docker.service
	else
		echo "systemctl 不可用，尝试直接启动 dockerd..."
		command -v dockerd >/dev/null 2>&1 && sudo dockerd &
		disown
	fi
	sleep 1
	docker info >/dev/null 2>&1 && echo "Docker 已启动" || echo "Docker 启动失败"
}

dkst() {
	if ! command -v docker >/dev/null 2>&1; then
		echo "Docker 未安装"
		return 1
	fi
	local running
	running="$(docker ps -q 2>/dev/null || true)"
	if [ -n "$running" ]; then
		echo "停止运行中的容器..."
		docker stop $running 2>/dev/null || true
	fi
	if command -v systemctl >/dev/null 2>&1; then
		sudo systemctl stop docker.service containerd.service 2>/dev/null ||
			sudo systemctl stop docker.service 2>/dev/null || true
		echo "Docker 服务已停止"
	fi
}

# NOTE: clone
# 挂载命令
alias makislife='mount_aliyun "Aliyun" "makislife" "makislife"'
alias img_makislife='mount_aliyun "Aliyun" "aly-images472" "img-makislife"'
alias resources='mount_aliyun "Aliyun" "res-guangzhou" "resources"'

mount_aliyun() {
	local CONFIG_NAME="$1"
	local BUCKET="$2"
	local MOUNT_SUBDIR="$3"
	local MOUNT_POINT="$HOME/Documents/aliy/${MOUNT_SUBDIR}"

	mkdir -p "$MOUNT_POINT"

	if mountpoint -q "$MOUNT_POINT"; then
		echo "目录已挂载: $MOUNT_POINT"
	else
		if ! command -v rclone >/dev/null 2>&1; then
			echo "rclone 未安装或不可用，无法挂载 $CONFIG_NAME:$BUCKET"
			return 1
		fi
		echo "挂载 $CONFIG_NAME:$BUCKET 到 $MOUNT_POINT ..."
		nohup rclone mount "${CONFIG_NAME}:${BUCKET}" "${MOUNT_POINT}" --vfs-cache-mode writes \
			>/tmp/rclone-mount-${BUCKET}.log 2>&1 &
		disown

		# 等待短暂时间以确认挂载是否生效
		local COUNT=0
		while ! mountpoint -q "$MOUNT_POINT" && [ "$COUNT" -lt 10 ]; do
			sleep 0.5
			((COUNT++))
		done

		if mountpoint -q "$MOUNT_POINT"; then
			echo "挂载成功：$MOUNT_POINT"
		else
			echo "挂载可能失败，请检查 /tmp/rclone-mount-${BUCKET}.log"
		fi
	fi

	if mountpoint -q "$MOUNT_POINT"; then
		echo "挂载位置：$MOUNT_POINT"
	fi
}

alias sa='ssh -p 64701 maki@frp.makis-life.cn'
:q() { exit; }

# WARN: 加载密钥
source ~/Documents/.secrets/keys

# NOTE: 在缓存行中打开输入
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^x^e' edit-command-line

# NOTE: 切换目录的时候自动ls
chpwd() {
	ls
}

# NOTE: opencode
export PATH=/home/maki/.opencode/bin:$PATH

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

# Add JBang to environment
alias j!=jbang
export PATH="$HOME/.jbang/bin:$PATH"

# Pi
export PATH="/home/maki/.local/share/mise/installs/node/26.7.0/bin:$PATH"

. "$HOME/.local/bin/env"
