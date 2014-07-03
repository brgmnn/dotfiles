dotfiles
========

Using GNU Stow to place the dotfiles in the home directory as followed from this guide:
http://taihen.org/managing-dotfiles-with-gnu-stow/

Group different applications or machines or whatever under subfolders in dotfiles, for example:

	~/dotfiles/
		irssi/
			.config
		themes/
		bash/
			.bashrc
			.bashrc_aliases
		vim/
			.vimrc
			.vim/
				bundle/
				colors/

Then load a subfolder (for instance vim) with:

	cd ~/dotfiles
	stow vim

To unload a subfolder:

	stow -D vim

To reload a subfolder:

	stow -R vim

Use `-t` to load symlinks in any location:

	stow -t /home/user vim
