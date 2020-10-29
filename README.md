# Docker Vim

![docker-vim mov](https://user-images.githubusercontent.com/4065733/97482945-7228fe80-191c-11eb-934d-754be6ad5178.gif)

**The problem**: A full development enviroment requires global tools installed (node, fzf, ripgrep)
but you can't install whatever you want in a **REMOTE SERVER**

**The goal** A containerized enviroment with all ingredients needed to get up and running. 

Vim version: v8.2.1916

System packages (recent):

- git
- node
- yarn
- ripgrep
- fzf
- tmux
- python3


# Requires

- Docker

# How to use

Clone, build and create a docker volume (so your changes to .vimrc aren't lost)

```
git clone https://github.com/eduardoarandah/docker-vim && cd docker-vim
docker build . -t docker-vim
docker volume create docker-vim
```

Go to the directory with your code and run vim. (it only mounts current directory)

```
docker run --rm -it -v ${PWD}:/app -w /app -v docker-vim:/root docker-vim
```

Open vim and install plugins

```
vim
:PlugInstall
```

Quit vim and open it again. `:qa!`

`F7` opens vim file explorer (nerdtree)

You can delete your volume later with

```
docker volume rm docker-vim 
```

# Contains

Optimized defaults, utilities and common mappings, please customize with your own!

Plugins:

- tomasr/molokai
- tpope/vim-surround
- tpope/vim-repeat
- tomtom/tcomment_vim
- tpope/vim-fugitive
- junegunn/gv.vim
- airblade/vim-gitgutter
- scrooloose/nerdtree
- jiangmiao/auto-pairs
- jremmen/vim-ripgrep
- vim-airline/vim-airline
- tpope/vim-eunuch
- sheerun/vim-polyglot
- junegunn/fzf
- kshenoy/vim-signature
- arthurxavierx/vim-caser
- neoclide/coc.nvim

# Tmux

Tmux is vim best frend, so I added it.

I added common defaults to `~/.tmux.conf`

If characters display funny, check first line in that file.
