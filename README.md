# dotfiles

## Dependencies

If you want to clone and install my dotfiles as I do, then you will need the
following things installed:

- Git
- GNU Stow

You can of course use code snippets, download folders over http and place them
wherever you like in which case you won't need all/any of these dependencies.


## Using Stow

I use GNU Stow to place the dotfiles in my home directory as followed from
this guide:

http://taihen.org/managing-dotfiles-with-gnu-stow/

Group different applications or machines or whatever you want under
subfolders in dotfiles, for example:

```
~/dotfiles/
    bash/
        .bashrc
        .bashrc_aliases
    bin/
        bin/
            script.sh
            my-tool.py
    irssi/
        .config
    themes/
    vim/
        .vimrc
        .vim/
            bundle/
            colors/
    zsh/
        .zshrc
        .zshenv
```

In this example all files relating to vim are grouped under a `vim` folder,
all bash files under a `bash` folder etc.

Then load a subfolder (for instance vim) with:

```
cd ~/dotfiles
stow vim
```

To unload a subfolder:

```
stow -D vim
```

To reload a subfolder:

```
stow -R vim
```

Use `-t` to load symlinks in any location:

```
stow -t /home/user vim
```

Using Stow it becomes very easy to load and unload a collection of dotfiles in
to your home folder. While it doesn't seem to give many benefits if you just
want a copy of your `~/.vim` folder, it works well in cases where you need to
merge folders (provided there are file conflicts).

For example, if you have a folder `~/bin` which contains files that look
something like:

```
$ ls -lah ~/bin
drwxr-xr-x.  2 dan user 4.0K Dec  3 22:54 .
drwxr-xr-x. 39 dan user 4.0K Dec  4 19:18 ..
-rwxr-xr-x.  1 dan user  16K Nov 28 21:19 ffmpeg
-rwxr-xr-x.  1 dan user  513 Oct  7 18:08 localscript.sh
-rwxr-xr-x.  1 dan user   65 Oct 14 19:26 localscript2.py
```

After running `stow bin` from the dotfiles repository, your `~/bin` folder
would now look something like this:

```
$ ls -lah ~/bin
drwxr-xr-x.  2 dan user 4.0K Dec  3 22:54 .
drwxr-xr-x. 39 dan user 4.0K Dec  4 19:18 ..
-rwxr-xr-x.  1 dan user  16K Nov 28 21:19 ffmpeg
-rwxr-xr-x.  1 dan user  513 Oct  7 18:08 localscript.sh
-rwxr-xr-x.  1 dan user   65 Oct 14 19:26 localscript2.py
lrwxrwxrwx.  1 dan user   27 Dec  3 22:54 script.sh -> ../dotfiles/bin/bin/script.sh
lrwxrwxrwx.  1 dan user   28 Dec  3 22:54 my-tool.py -> ../dotfiles/bin/bin/my-tool.py
```

Stow has only symlinked the files it needed to. If however there was no
existing `~/bin` folder then Stow would simply symlink the folder.

### When do I need to reload folder?

If in doubt over when you need to reload folders with Stow, just reload every
time you add or remove files. This way any changes should appear in the
correct places.
