if status is-interactive
	# Commands to run in interactive sessions can go here
	set fish_greeting
	alias py=python3
	alias pip='python3 -m pip'
	alias vim=nvim
    alias fd=fdfind
    alias batcat=bat
	export PYTHONSTARTUP=$HOME/.config/pythonstartup	
end
