source /usr/share/cachyos-fish-config/cachyos-config.fish

# overwrite greeting
# potentially disabling fastfetch
#function fish_greeting
#    # smth smth
#end

#aliases
# trash-put
alias rm "echo use tp"
alias tp "trash-put"

# git
alias gst "git status"
alias gs "git status"
alias ga "git add"
alias gp "git push"
alias gd "git diff"
function gc
	git commit -m "$argv"
end

# ssh
alias ssh "kitty +kitten ssh"

