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
- python3


# Requires

- Docker

# How to use

Create a volume and an alias. (you can put this alias in your `.bashrc`)

```
docker volume create docker-vim
alias docker-vim='docker run --rm -it -v ${PWD}:/app -w /app -v docker-vim:/root eduardoarandah/docker-vim'
```

Run in your desired directory (it only mounts current directory)

```
docker-vim
```

On your first run, install plugins

```
vim
:PlugInstall
```

Quit vim and open it again. `:qa!`

`F7` opens vim file explorer (nerdtree)

Changes in your `.vimrc` are persisted in a volume. You can delete it with:

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

# Rebuild

To rebuild this image:

```
git clone https://github.com/eduardoarandah/docker-vim && cd docker-vim
docker build . -t docker-vim
```
