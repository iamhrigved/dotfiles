# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH
export TERM='xterm-kitty'
export KEYTIMEOUT=50
export EDITOR='nvim'
export XDG_SCREENSHOTS_DIR=$HOME/Pictures/Screenshots
export HOMEBREW_AUTO_UPDATE_SECS=172800

if [[ ! $(echo $TMUX) == "" ]]; then # if inside tmux
	export TERM='tmux-256color'
fi

# brew :
export BREW_HOME="/home/linuxbrew/.linuxbrew/bin"
eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)

# bat & delta :
export BAT_THEME=base16
export PAGER=delta
export MANPAGER=delta
export BATDIFF_USE_DELTA=false

# oh-my-posh :
export PROMPT_CONFIG=~/.config/oh-my-posh/omp.conf.json

eval "$(oh-my-posh init zsh --config $PROMPT_CONFIG)"

# CUSTOM ALIASES :

alias lsl="echo "" && eza --all --git --color=always --icons=always --long"
ls() {
	local col_num=$(tput cols)
	local width=$[ 8 * $col_num / 10 ]
	echo "" && eza --all --width=$width --color=always --icons=always $@
}

alias vi="nvim"
alias ex="explorer.exe"
alias c="clear"
alias rg="rg --hyperlink-format=kitty"
alias vish="nvim ~/.zshrc"
alias vipc="nvim $PROMPT_CONFIG"
alias vitm="nvim ~/.config/tmux/tmux.conf"
alias vikt="nvim ~/.config/kitty/kitty.conf"
alias vihp="nvim ~/.config/hypr"
alias exsh="exec zsh"

alias pS="sudo pacman -S"
alias pR="sudo pacman -R"
alias pQ="pacman -Q"

alias ys="yay -Ss"
alias yS="yay -S"
alias yR="yay -R"
alias yQ="yay -Q"

alias tm="tmux"

d() {
    sh -c "dolphin $@ &!"
}

tmks() {
	search_result="$(tmux ls | grep ".*$1.*: " -ioG | sed 's/: //')"
	echo "Found Session: $search_result" && sleep 1
	echo "Deleting $search_result..." && sleep 1
	tmux kill-session -t "$search_result"
}

tmas() {
	search_result="$(tmux ls | grep ".*$1.*: " -ioG | sed 's/: //')"
	echo "Found Session: $search_result" && sleep 1
	echo "Loading $search_result..." && sleep 1
	tmux attach-session -t "$search_result"
}

show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"
alias -g -- --help='--help 2>&1 | bat --language=help --style=plain'
alias bd="batdiff --context=4"
alias bds="batdiff --staged --context=4"
alias fzf="fzf --preview \"$show_file_or_dir_preview\""
alias lg="lazygit"

runc() {
	local file_location=$1
	local file_name=${1:t}
	local file_directory=${1:h}
	local exe_file_name=${file_name:r}
	local is_local=""
	local exe_file_location=""

	if [[ $file_directory == "." ]]; then 
		is_local=true
	else
		is_local=false
	fi

    # if the file compiles without any errors this will run
    local run() {
            # if executables directory does not exist
            if [[ $(ls $file_directory/ | grep -i -o "executables") == "" ]] then;
                mkdir $file_directory/executables &&
                echo "New directory created $file_directory/executables"
            fi

            mv ./a.out ./executables/$exe_file_name
            echo "" # printing new lines
            ./executables/$exe_file_name
            echo ""
    }
    g++ $file_location && run
}

# history config options
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' menu no

# zoxide :
eval "$(zoxide init zsh --cmd cd)"


export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
	local command=$1
	shift

	case "$command" in
		cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
		export|unset) fzf --preview "eval 'echo ${}'"         "$@" ;;
		ssh)          fzf --preview 'dig {}'                   "$@" ;;
		*)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
	esac
}
### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

# Plugins 
zinit snippet OMZP::git
zinit snippet OMZP::vi-mode

zinit snippet https://github.com/MichaelAquilina/zsh-you-should-use/blob/master/you-should-use.plugin.zsh

zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit light Aloxaf/fzf-tab

autoload -U compinit && compinit

# vi-mode config options
bindkey '^n' history-search-forward
bindkey '^p' history-search-backward
bindkey '^y' autosuggest-accept

bindkey -M viins 'kj' vi-cmd-mode

export VI_MODE_SET_CURSOR=true
export VI_MODE_CURSOR_INSERT=1

# fzf config options
source <(fzf --zsh)
source ~/fzf-git.sh

export FZF_DEFAULT_COMMAND='rg --files --hidden -g !.git/'
export FZF_DEFAULT_OPTS='
  --color=fg:-1,fg+:-1,bg:-1,bg+:#1b3159
  --color=hl:#48b0bd,hl+:#48b0bd,info:#afaf87,marker:#9ece6a
  --color=prompt:#9ece6a,spinner:#af5fff,pointer:#af5fff,header:#87afaf
  --color=border:#48b0bd,label:#e55561,query:#d9d9d9
  --border="rounded" --border-label=" Fuzzy Finder " --border-label-pos="0" --preview-window="border-rounded"
  --prompt=" " --marker="󱞩" --pointer="" --separator="─"
  --scrollbar="▎" --info="right"'

# bun completions
[ -s "/home/hrigved/.bun/_bun" ] && source "/home/hrigved/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# invoking fastfetch
fastfetch --logo-padding-right 5 --logo-padding-left 2 #-l ~/Pictures/Wallpapers/pngwing.com.png --logo-width 41 --logo-height 19 --logo-padding-right 10
