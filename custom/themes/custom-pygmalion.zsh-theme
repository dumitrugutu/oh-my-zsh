# Yay! High voltage and arrows!

prompt_setup_pygmalion(){
 #ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color%}%{$fg[red]%}"
 #ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
 #ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}⚡%{$reset_color%}"
 #ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}*%{$reset_color%}"
 #ZSH_THEME_GIT_PROMPT_CLEAN=""

 # Format for git_prompt_status()
 ZSH_THEME_GIT_PROMPT_UNMERGED=" %{$fg[red]%}unmerged%{$reset_color%}"
 ZSH_THEME_GIT_PROMPT_DELETED=" %{$fg[green]%}deleted%{$reset_color%}"
	ZSH_THEME_GIT_PROMPT_RENAMED=" %{$fg[yellow]%}renamed%{$reset_color%}"
	ZSH_THEME_GIT_PROMPT_ADDED=" %{$fg[green]%}added%{$reset_color%}"
	ZSH_THEME_GIT_PROMPT_MODIFIED=" %{$fg[blue]%}modified%{$reset_color%}"
	ZSH_THEME_GIT_PROMPT_UNTRACKED=" %{$fg[red]%}untracked%{$reset_color%}"

 base_prompt='%{$fg_bold[green]%}%n@%m %{$fg[blue]%}%D{[%X]} %{$reset_color%}%{$fg[white]%}[%~]%{$reset_color%} '
 post_prompt='%{$fg[blue]%}->%{$fg_bold[blue]%} %#%{$reset_color%} '

 base_prompt_nocolor=$(echo "$base_prompt" | perl -pe "s/%\{[^}]+\}//g")
 post_prompt_nocolor=$(echo "$post_prompt" | perl -pe "s/%\{[^}]+\}//g")

 precmd_functions+=(prompt_pygmalion_precmd)
}

prompt_pygmalion_precmd(){
 local gitinfo=$(git_prompt_info)
 local gitinfo_nocolor=$(echo "$gitinfo" | perl -pe "s/%\{[^}]+\}//g")
 local exp_nocolor="$(print -P \"$base_prompt_nocolor$gitinfo_nocolor$post_prompt_nocolor\")"
 local prompt_length=${#exp_nocolor}

 local nl=""

 if [[ $prompt_length -gt 80 ]]; then
   nl=$'\n%{\r%}';
 fi

 local git_branch_length=${#gitinfo}
 if [[ $git_branch_length -gt 0 ]]; then
   local gitinfo="%{$fg[red]%}[$gitinfo$(git_prompt_status)%{$fg[red]%}] "
 fi
 PROMPT="$base_prompt$gitinfo$nl$post_prompt"
}

prompt_setup_pygmalion
