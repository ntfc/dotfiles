# I'm not using any plugins, so disable it for now
#if [[ -f ~/.zsh/antigen/antigen.zsh ]]; then
#  source ~/.zsh/antigen/antigen.zsh
#
#fi

for config in ~/.zsh/*.zsh; do
  source "$config"
done
