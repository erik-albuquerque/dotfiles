
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Themes
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# https://github.com/romkatv/powerlevel10k#oh-my-zsh
ZSH_THEME="powerlevel10k/powerlevel10k" # robbyrussell

# Which plugins would you like to load?
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# aliases 

# git
alias g="git" # git 
alias ga="g add" # adds selected files to repo
alias gaa="g add ." # adds all files to repo
alias gc="g clone" # clone repo
alias gs="g status" # gives status repport
alias gcm="g commit -m" # commits files to stage area
alias gacm="gaa && gcm" # adds all files to repo and commits files to stage area
alias gp="g push" # push files to repo
alias gpo="g push origin" # pushes files to repo
alias gpl="g pull" # get updates from repo
alias gch="g checkout" # moves between existing branches
alias gchb="g checkout -b" # creates new branch
alias gb="g branch" # shows list of all branches
alias gbd="g branch -d" # deletes branches from local repo
alias gf="g fetch"
alias fuck="g reset --hard"
# git logs
alias dog="git log --oneline --all --decorate --graph" # pretty git log

# bash
alias ..="cd .." # back to before folder
alias c="clear" # clear terminal 
alias e="exit" # close terminal 
alias h="history" # command history
alias s="sudo" # sudo
alias super="s su" # super user
alias update="s apt update" # check if updates
alias upgrade="s apt upgrade -y" # install updates
alias up="update && upgrade" # check for updates and install them
alias install="s apt install" # install app
alias remove="s apt remove" # uninstall app
alias ll="ls -t -1 -a -l" # lists all files and directories in the current directory, including hidden ones
alias la="ls -A" # lists all files and directories in the current directory, including hidden ones, but excludes special references `.` and `...` 
alias l="ls -CF" # lists the files and directories in the current directory in columns, and adds type indicators to the filenames to indicate the type of each item in the directory. 
alias rmf="rm -fr" # force delete
alias bye="shutdown -r now" # turn off
alias .zshrc="code ~/.zshrc" # open .zshrc on vscode
alias .kitty="code ~/.config/kitty/kitty.conf" # open kitty.conf on vscode

# aliases end

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
### End of Zinit's installer chunk

# zinit plugins
zinit light zdharma-continuum/fast-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
# zinit plugins end

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# nvm end

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
