# Docker Vim

![docker-vim mov](https://user-images.githubusercontent.com/4065733/97482945-7228fe80-191c-11eb-934d-754be6ad5178.gif)

Docker image with vim and system requirements for popular plugins and tools:

- python3
- git
- node
- yarn
- ripgrep
- fzf
- tmux

Vim version: v8.2.1916

# Requires

- Docker

# How to use

Build image:

```
docker build . -t docker-vim
```

Run it:

This command opens the container and binds your current directory to /app

```
docker run --rm -it -v ${PWD}:/app -w /app docker-vim
```

On first run you need to install vim plugins with:

```
:PlugInstall
```

Then exit vim `:qa!` and open it again, press `F7` to see your files.

# Persistency

Docker is volatile, so all your changes will be lost when you close the container.

To persist them, create a volume:

```
docker volume create docker-vim
```

Then launch it again, this time, your changes will persist

``` 
docker run --rm -it -v ${PWD}:/app -w /app -v docker-vim:/root docker-vim 
```

You can delete the volume later with

```
docker volume rm docker-vim 
```

# This vim contains:

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
