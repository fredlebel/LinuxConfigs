# fred theme

# if superuser make the username red
if [ $UID -eq 0 ]; then NCOLOR="red"; else NCOLOR="white"; fi

#autoload -U colors && colors

local blue_op="%{$fg[green]%}(%{$reset_color%}"
local blue_cp="%{$fg[green]%}%)%{$reset_color%}"
local path_p='${blue_op}%{$fg[white]%}%{%U%}${PWD/#$HOME/~}%{%u%}%{$reset_color%}${blue_cp}'
local user_host="${blue_op}%n@%m${blue_cp}"
#local ret_status="${blue_op}%?${blue_cp}"
local ret_status="${blue_op}%(?,%{$fg_bold[green]%}%?%{$reset_color%},%{$fg_bold[red]%}%?%{$reset_color%})${blue_cp}"
local time="${blue_op}%D %*${blue_cp}"
local hist_no="${blue_op}%h${blue_cp}"
local smiley="%(?,%{$fg[green]%}:%)%{$reset_color%},%{$fg[red]%}:(%{$reset_color%})"
local prompt_box="${blue_op}%{$fg[white]%}%#%{$reset_color%}${blue_cp}"

function my_git_prompt_info() {
    ref=$(git symbolic-ref HEAD 2> /dev/null) || return
    GIT_STATUS=$(git_prompt_status)
    [[ -n $GIT_STATUS ]] && GIT_STATUS=" $GIT_STATUS"
    echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$GIT_STATUS$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

function cabal_sandbox_info() {
    cabal_files=(*.cabal(N))
    if [ $#cabal_files -gt 0 ]; then
        if [ -f cabal.sandbox.config ]; then
            echo "(%{$fg[green]%}sandboxed%{$reset_color%})"
        else
            echo "(%{$fg[red]%}not sandboxed%{$reset_color%})"
        fi
    fi
}

PROMPT="
┌─${path_p}-${ret_status}-${time}
└─${prompt_box} "

# prompt
#PROMPT="╭─[%{$fg[$NCOLOR]%}%B%n%b%{$reset_color%}:%{$fg_bold[cyan]%}%30<...<%~%<<%{$reset_color%}]
#╰─%(!.#.$) "
RPROMPT='$(my_git_prompt_info) $(cabal_sandbox_info)'

# git theming
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[gray]%}(%{$fg_no_bold[yellow]%}%B"
ZSH_THEME_GIT_PROMPT_SUFFIX="%b%{$fg_bold[gray]%})%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_CLEAN=""
#ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg_bold[red]%}*"

ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[white]%}?%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_ADDED="%{$fg_bold[green]%}+%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg_bold[cyan]%}*%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg_bold[cyan]%}~%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg_bold[red]%}!%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg_bold[magenta]%}?%{$reset_color%}"


# LS colors, made with http://geoff.greer.fm/lscolors/
export LSCOLORS="Gxfxcxdxbxegedabagacad"
export LS_COLORS='no=00:fi=00:di=01;34:ln=93:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=41;33;01:ex=00;92:*.7z=00;31:*.tar=00;31:*.tbz=00;31:*.tgz=00;31:*.rpm=00;31:*.deb=00;31:*.arj=00;31:*.taz=00;31:*.lzh=00;31:*.lzma=00;31:*.zip=00;31:*.zoo=00;31:*.z=00;31:*.Z=00;31:*.gz=00;31:*.bz2=00;31:*.tb2=00;31:*.tz2=00;31:*.tbz2=00;31:'
