autoload colors && colors
# cheers, @ehrenmurdick
# http://github.com/ehrenmurdick/config/blob/master/zsh/prompt.zsh

if (( $+commands[git] ))
then
  git="$commands[git]"
else
  git="/usr/bin/git"
fi

git_branch() {
  echo $($git symbolic-ref HEAD 2>/dev/null | awk -F/ {'print $NF'})
}

git_detach() {
  commit=$($git status 2>/dev/null | head -n1 | grep detached | cut -d' ' -f5)
  if [[ $commit == "" ]]
  then
    echo ""
  else
    echo "commit $commit"
  fi
}

git_dirty() {
  st=$($git status 2>/dev/null | head -n 1)
  if [[ $st == "" ]]
  then
    echo ""
  else
    # let's find info in any case
    prompt_info="$(git_prompt_info)"
    if [[ $prompt_info == "" ]]; then
      prompt_info="$(git_detach)"
    fi

    if [[ "$st" =~ ^nothing ]]
    then
      echo "on %{$fg_bold[green]%}$prompt_info%{$reset_color%}"
    else
      echo "on %{$fg_bold[red]%}$prompt_info%{$reset_color%}"
    fi
  fi
}

git_prompt_info () {
 ref=$($git symbolic-ref HEAD 2>/dev/null) || return
# echo "(%{\e[0;33m%}${ref#refs/heads/}%{\e[0m%})"
 echo "${ref#refs/heads/}"
}

unpushed () {
  $git cherry -v @{upstream} 2>/dev/null
}

need_push () {
  if [[ $(unpushed) == "" ]]
  then
    echo " "
  else
    echo " with %{$fg_bold[magenta]%}unpushed%{$reset_color%} "
  fi
}

ruby_version() {
  if (( $+commands[rbenv] ))
  then
    echo "$(rbenv version | awk '{print $1}')"
  fi

  if (( $+commands[rvm-prompt] ))
  then
    echo "$(rvm-prompt | awk '{print $1}')"
  fi
}

rb_prompt() {
  if ! [[ -z "$(ruby_version)" ]]
  then
    echo "%{$fg_bold[yellow]%}$(ruby_version)%{$reset_color%}"
  else
    echo ""
  fi
}

xcode_version() {
  if (( $+commands[xcenv] ))
  then
    echo "$(xcenv version | awk '{print $1}')"
  fi
}

xcode_prompt() {
  if ! [[ -z "$(xcode_version)" ]]
  then
    echo "%{$fg_bold[red]%}$(xcode_version)%{$reset_color%}"
  else
    echo ""
  fi
}

swift_version() {
  if (( $+commands[swiftenv] ))
  then
    echo "$(swiftenv version | awk '{print $1}')"
  fi
}

swift_prompt() {
  if ! [[ -z "$(swift_version)" ]]
  then
    echo "%{$fg_bold[blue]%}$(swift_version)%{$reset_color%}"
  else
    echo ""
  fi
}

docker_version() {
  if (( $+commands[docker-machine] ))
  then
    echo "$(docker-machine ls | grep '*' | awk '{print $1}')"
  fi
}

docker_prompt() {
  if ! [[ -z "$(docker_version)" ]]
  then
    echo "%{$fg_bold[green]%}[$(docker_version)]%{$reset_color%}"
  else
    echo ""
  fi
}


directory_name() {
  echo "%{$fg_bold[cyan]%}%1/%\/%{$reset_color%}"
}

export PROMPT=$'\n$(rb_prompt) - $(xcode_prompt) - $(swift_prompt) in $(directory_name) $(git_dirty)$(need_push)\n› '
set_prompt () {
  export RPROMPT="%{$fg_bold[cyan]%}$(date +"%T")%{$reset_color%}"
}

precmd() {
  title "zsh" "%m" "%55<...<%~"
  set_prompt
}
