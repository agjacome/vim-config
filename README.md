Vim configuration
=================

This repository contains my VIM configuration files. It's mostly based on
simple copypastes of tips and tricks found all over the internet over the years.

All plugins are loaded via [Pathogen](https://github.com/tpope/vim-pathogen)
and installed as git-submodules into the ```bundle``` directory. That behaviour
of using submodules to manage plugins will probably change in a nearby future,
favoring the use of [Vundle](https://github.com/gmarik/vundle); but in the
meantime, that's how it works.

Installation
------------

Backup (if necessary) your previous Vim configuration:

    mv $HOME/.vim $HOME/vim_backup

Clone repository with all its submodules:

    git clone --recursive https://github.com/agjacome/vim-config.git $HOME/.vim

Create required directories:

    mkdir $HOME/.vim/undo

Basic Usage
-----------

The first thing you should notice is that arrow keys are disabled outside of
Insert Mode. Navigation is required to be done via ```hjlk```. You can disable
that behaviour changing the configuration around line 145 in ```vimrc```.

The other big noticeable thing is the use of relative numbers in the left side
of the editor, instead of the most common absolute numbers. That behaviour can
be changed at runtime (toggle between relative and absolute numbers) by just
pressing ```F4```.

The mapleader key for all commands is a comma (```,```). So, for example to
open up NERDTree (a file explorer plugin) you should press ```,f``` (a comma
followed by an eff). Or, to insert the current date, press ```,d```.

You can also toggle the colorscheme used (between a dark and a light ones) by
pressing ```F3```. If you need to edit in hexadecimal mode after you opened up
a file you can toggle edit mode also by pressing ```F6```. And, if you **hate**
trailing whitespaces (like anybody mentally sane will), you can remove them all
with the function ```KillWitheSpace()```, that you can execute as a command, so
press ```:``` and write ```KillWitheSpace``` followed by an Enter and they will
go away.

If you want to know all keybindings, functions and configurations, open up and
read the ```vimrc``` file by yourself.

Known Problems
--------------

Depending on your Vim version, and compilation options, you'll probably need to
change some things.

#### vimrc
If you are using an old version of vim that does not read the ```vimrc``` file
inside the ```$HOME/.vim``` directory, but instead expects to found it in
```$HOME/.vimrc``` you can just make a link to it this way:

    ln -s $HOME/.vim/vimrc $HOME/.vimrc

And it should work as expected.

#### formatoptions
Another common problem is found in line 33 of vimrc:

    set formatoptions+=j

It's suppossed to allow vim to remove comments when joining lines, but the
feature was introduced in 7.3 patch 541, so if your version of vim is not
really up-to-date, it will complaint that the "j" formatoption is not found.
You can remove that line without any consequence whatsoever.

#### colorscheme
Depending on the terminal emulator you are using, you'll probably need to
change some config to correctly show the colorscheme. My config is tweaked to
work well with ```rxvt-unicode-256color``` (my preferred ```$TERM```) and
configured via ```Xresources```.

First check that when you open a file with vim, the colorscheme loaded looks
similar to this:

![screenshot](http://i.imgur.com/BJYTRzT.png)

If it is not, the easy solution (if your term supports 256 colors) is to change
the configuration in vimrc around line 42:

    " colorscheme
    if $TERM =~ "-256color"
        set t_Co=256
        let g:hybrid_use_Xresources = 1
    endif
    set background=dark
    colorscheme hybrid

To just:

    " colorscheme
    set t_Co=256
    set background=dark
    colorscheme hybrid

If that doesn't work... well, you're on your own.

#### more to come as found...

README TODO
-----------
* List all plugin's required dependencies.
