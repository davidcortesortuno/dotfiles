
### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-rust \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-bin-gem-node

### End of Zinit's installer chunk

# HISTORY SUBSTRING SEARCHING
zinit light zsh-users/zsh-history-substring-search
bindkey '^[[A' history-substring-search-up
bindkey '^[OA' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^[OB' history-substring-search-down

# A glance at the new for-syntax – load all the
# plugins with a single command. For more information see:
# https://zdharma.github.io/zinit/wiki/For-Syntax/
zinit for \
    light-mode  zsh-users/zsh-autosuggestions \
    light-mode  zdharma/fast-syntax-highlighting \
                zdharma/history-search-multi-word \
    light-mode pick"async.zsh" src"pure.zsh" \
                sindresorhus/pure \

zinit ice wait"0b" lucid blockf
zinit light zsh-users/zsh-completions
zstyle ':completion:*' menu select=2
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
# zstyle ':completion:*:descriptions' format '-- %d --'
# zstyle ':completion:*:processes' command 'ps -au$USER'
# zstyle ':completion:complete:*:options' sort false
# zstyle ':fzf-tab:complete:_zlua:*' query-string input
# zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm,cmd -w -w"
# zstyle ':fzf-tab:complete:kill:argument-rest' extra-opts --preview=$extract'ps --pid=$in[(w)1] -o cmd --no-headers -w -w' --preview-window=down:3:wrap
# zstyle ":completion:*:git-checkout:*" sort false

# Better ls: exa
# Installs rust and then the `exa' crate and creates
# the `ls' shim exposing the `exa' binary
zinit ice cargo'!exa -> ls'
zinit load zdharma/null

# Binary release in archive, from GitHub-releases page.
# After automatic unpacking it provides program "fzf".
zinit ice from"gh-r" as"program"
zinit load junegunn/fzf-bin

# SETOPT ......................................................................
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_all_dups   # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt inc_append_history     # add commands to HISTFILE in order of execution
setopt share_history          # share command history data
setopt always_to_end          # cursor moved to the end in full completion
setopt hash_list_all          # hash everything before completion
# setopt completealiases        # complete alisases

# -----------------------------------------------------------------------------
# -----------------------------------------------------------------------------

# TILIX
if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
        source /etc/profile.d/vte.sh
fi

# added by Miniconda3 installer
# . /home/$USER/miniconda3/etc/profile.d/conda.sh
# >>> conda initialize >>>                                                        
# !! Contents within this block are managed by 'conda init' !!                    
__conda_setup="$('/home/david/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then                                                             
    eval "$__conda_setup"                                                         
else                                                                              
    if [ -f "/home/david/miniconda3/etc/profile.d/conda.sh" ]; then               
# . "/home/david/miniconda3/etc/profile.d/conda.sh"                           # commented out by conda initialize
    else                                                                          
# export PATH="/home/david/miniconda3/bin:$PATH"  # commented out by conda initialize                            
    fi                                                                            
fi                                                                                
unset __conda_setup                                                               
# <<< conda initialize <<<

# Fidimag
export PYTHONPATH="$PYTHONPATH:/home/david/git/fidimag/"

# Paraview
alias paraview-dev="/home/david/software/ParaView-5.9.1-MPI-Linux-Python3.8-64bit/bin/paraview"

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# Add SPIRIT to Python
export PYTHONPATH="/home/david/git/spirit/core/python":$PYTHONPATH

# Wolfram
alias mathematica="/home/david/software/Wolfram/bin/Mathematica"

# MKL for Python
export LD_LIBRARY_PATH=/home/david/intel/oneapi/mkl/latest/lib/intel64:/home/david/intel/oneapi/compiler/latest/linux/compiler/lib/intel64_lin

# MERRILL
alias merrill="/home/david/git/merrill-1.4/build/merrill"
