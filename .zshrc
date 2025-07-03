# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH
export TERM='xterm-kitty'
export EDITOR='nvim'
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

alias lsl="eza --all --git --color=always --icons=always --long"
ls() {
	local col_num=$(tput cols)
	local width=$[ 8 * $col_num / 10 ]
	eza --all --width=$width --color=always --icons=always $@
}
lst() {
    eza --all --color=always --icons=always --tree --level $@
}

alias vi="nvim"
alias c="clear"
alias rg="rg --hyperlink-format=kitty"
alias vish="nvim ~/.zshrc"
alias vipc="nvim $PROMPT_CONFIG"
alias vitm="nvim ~/.config/tmux/tmux.conf"
alias vikt="nvim ~/.config/kitty/kitty.conf"
alias vihp="nvim ~/.config/hypr"
alias exsh="exec zsh"

alias p="pacman"
alias pS="paru -S"
alias pR="sudo paru -R"
alias pQt="paru -Qt"
alias pQi="paru -Qi"
alias pQs="paru -Qs"
alias pSs="paru -Ss"

alias tm="tmux"

d() {
    dolphin $@ &!
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
    local file_type=$(echo $file_location | sed "s/.*\.\(.*\)/\1/" | sed "s/p/+/g") # `c` or `c++`
	local file_name=${1:t}
	local file_directory=${1:h}
	local exe_file_name=${file_name:r}

    # if the file compiles without any errors this will run
    local run() {
            # if executables directory does not exist
            if [[ $(ls $file_directory/ | grep -i -o "executables") == "" ]] then;
                mkdir $file_directory/executables &&
                echo "New directory created $file_directory/executables"
            fi

            mv ./a.out ./executables/$exe_file_name
            echo "" # printing new lines
            ./executables/$exe_file_name $@
            echo ""
    }
    echo "g++ $file_location -x $file_type && run $@"
    g++ $file_location -x $file_type && run $@
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

# zsh-vi-mode config

function zvm_config() {
    ZVM_NORMAL_MODE_CURSOR=$ZVM_CURSOR_BLOCK
    ZVM_INSERT_MODE_CURSOR=$ZVM_CURSOR_BLINKING_BLOCK

    ZVM_VI_HIGHLIGHT_BACKGROUND=blue
    ZVM_VI_HIGHLIGHT_FOREGROUND=white

    # Enter the vi insert mode (overwritten)
    function zvm_enter_insert_mode() {
      local keys=${1:-$(zvm_keys)}

      if [[ $keys == 'l' ]]; then
        ZVM_INSERT_MODE='i'
      elif [[ $keys == 'a' ]]; then
        ZVM_INSERT_MODE='a'
        if ! zvm_is_empty_line; then
          CURSOR=$((CURSOR+1))
        fi
      fi

      zvm_reset_repeat_commands $ZVM_MODE_NORMAL $ZVM_INSERT_MODE
      zvm_select_vi_mode $ZVM_MODE_INSERT
    }
    
    # custom keybinds
    zvm_after_init_commands+=(
    "bindkey '^N' history-search-forward"
    "bindkey '^P' history-search-backward"
    "bindkey '^Y' autosuggest-accept"
    )

    zvm_bindkey vicmd 'm' vi-backward-char
    zvm_bindkey vicmd 'n' vi-down-line-or-history
    zvm_bindkey vicmd 'e' vi-up-line-or-history
    # 'i' is not working 😭

    zvm_bindkey vicmd 'l' zvm_enter_insert_mode
    zvm_bindkey vicmd 'L' zvm_insert_bol
}

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
zinit ice depth=1
zinit snippet OMZP::git

zinit snippet https://github.com/MichaelAquilina/zsh-you-should-use/blob/master/you-should-use.plugin.zsh

zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit light Aloxaf/fzf-tab
zinit light jeffreytse/zsh-vi-mode

autoload -U compinit && compinit

# vi-mode config options for Colemak-DH
# see above

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
cat ~/.config/fastfetch/archlinux.txt && fastfetch --logo none

[ -f "/home/hrigved/.ghcup/env" ] && . "/home/hrigved/.ghcup/env" # ghcup-env
