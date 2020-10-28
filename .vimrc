scriptencoding utf-8 " basic 
set nocompatible " basic
filetype off " basic
filetype plugin on " Enable filetype plugins
filetype indent on " Enable loading the indent file for specific file types
syntax enable " Enable syntax highlighting
set encoding=utf-8 " Encoding (needed in youcompleteme)
set fileencoding=utf-8 " The encoding written to file.
set noerrorbells " No annoying sound on errors
set number " Line numbers on
set hidden " Allow buffer switching without saving
set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
set lazyredraw " Don't redraw while executing macros (good performance config)
set magic " For regular expressions turn magic on
set showmatch " Show matching brackets/parenthesis
set mat=2 " How many tenths of a second to blink when matching brackets
set autoread " Detect changes
set t_vb= " Flashing screen is annoying
set ruler " Always show current position
set cmdheight=1 " Height of the command bar
set showcmd " Show command in status bar
set autoindent " Auto indent
set formatoptions=tcqj " Format options, each letter means something
set history=10000 " Sets how many lines of history VIM has to remember
set so=5 " Set 7 lines to the cursor - when moving vertically using j/k
set backspace=indent,eol,start " fix: backspace past start of operation
set linespace=0 " No extra spaces between rows
set whichwrap=b,s,h,l,<,>,[,] " Backspace and cursor keys wrap too
set ff=unix " Use Unix as the standard file type
set ffs=unix,dos,mac " This gives the end-of-line (<EOL>) formats that will be tried
set virtualedit=block " If you need to define a block in visual block mode with bounds outside the actual text (that is, past the end of lines), you can allow this with:
set relativenumber " Use relative numbers instead of absolute
set wrap! " Don't wrap long lines
set background=dark " Dark
set shiftwidth=2 " Use indents of 2 spaces
set expandtab " Tabs are spaces, not tabs
set tabstop=2 " An indentation every four columns
set softtabstop=2 " Let backspace delete indent
set nojoinspaces " Prevents inserting two spaces after punctuation on a join (J)
set ai " Auto indent
set si " Smart indent
set switchbuf=useopen,usetab " Specify the behavior when switching between buffers
set hlsearch " Highlight search results
set incsearch " Makes search act like search in modern browsers
set ignorecase " Ignore case when searching
set smartcase " When searching try to be smart about cases
set gdefault " Add g (global) to substitute operations, :s/pattern/replacement/
set splitbelow " Open split below
set splitright " Open split right
set iskeyword-=.#$
set listchars=trail:-

" Leader Key
let mapleader=" "
let maplocalleader = "\\"

augroup basic
  autocmd!
  autocmd GUIEnter * set vb t_vb= " turn off flashing screen
augroup END

" Copy text to the end of line
nnoremap Y y$

" Repeat last command
nnoremap g. @:

" Scroll viewport faster: >
nnoremap <C-e> 2<C-e>
nnoremap <C-y> 2<C-y>

" Ctrl-Backspace delete word backwards
inoremap <C-BS> <esc>dBxi

" Deleting to blackhole
nnoremap <leader>x "_x
nnoremap <leader>d "_d
nnoremap <leader>c "_c

" Refresh
nnoremap <F5> :e<CR>

" Indent all document
nnoremap == gg=G

" Save
nnoremap <C-s> :w!<CR>
vnoremap <C-s> <Esc>:w!<CR>
inoremap <C-s> <Esc>:w!<CR>

"""""""""""""""""""""""
" Clipboard
"""""""""""""""""""""""

" Yank in word
nnoremap <leader>y yiW

" Don't lose clipboard when pasting
vnoremap p pgvy

"""""""""""""""""""""""
" Wildmenu
"""""""""""""""""""""""

set wildmenu " Show list instead of just completing
set wildignore=*.o,*~,*.pyc " Ignore compiled files
if (has('win32') || has('win64'))
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

"""""""""""""""""""""""
" Vim Info
"""""""""""""""""""""""

" The idea of "viminfo" is to save info from one editing session for the next by saving the data in an "viminfo file".
" So next time I satrt up Vim I can use the search patterns from the search history and the commands from the command line again. I can also load files again with a simple ":b bufname".
" And Vim also remember where the cursor was in the files I edited. See ":help viminfo" for more info on Vim's "viminfo". :-}
" https://www.guckes.net/vim/setup.html

" Create vim dir if not exists
if !isdirectory($HOME."/.vim")
  call mkdir($HOME."/.vim","p")
endif

set viminfo='50,<500,s100,:0,n$HOME/.vim/viminfo

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" For Unix and Win32, if a directory ends in two path separators "//" or "\\", the swap file name will be built from the complete path to the file with all path separators substituted to percent '%' signs. This will ensure file name uniqueness in the preserve directory.

" Create dir
if !isdirectory($HOME."/.vim/tmp")
  call mkdir($HOME."/.vim/tmp","p")
endif

set backupdir=$HOME/.vim/tmp//
set directory=$HOME/.vim/tmp//
set undodir=$HOME/.vim/tmp//
set undofile

command! TmpFilesClean !rm ~/.vim/tmp/**

"""""""""""""""""""""""""
" White space, blank lines
"""""""""""""""""""""""""

" Delete blank lines
:command! DeleteBlankLines g/^\s*$/d

" Replace multiple blank lines for single line
function! DoubleBlankLinesRemove(...)
  let save_pos = getpos(".")
  silent! %s/\(\n\n\)\n\+/\1/e
  nohlsearch
  call setpos('.', save_pos)
endfunction
command! DoubleBlankLinesRemove :call DoubleBlankLinesRemove()

" Replace multiple horizontal spacing to single space
function! DoubleSpacesRemove(...)
  let save_pos = getpos(".")
  silent! %s/\S\zs \+/ /e
  nohlsearch
  call setpos('.', save_pos)
endfunction
command! DoubleSpacesRemove :call DoubleSpacesRemove()

" Delete trailing white space
function! DeleteTrailingWhiteSpace(...)
    let save_pos = getpos(".")
    silent! %s/\s\+$//e
    call setpos('.', save_pos)
endfunction
command! DeleteTrailingWhiteSpace :call DeleteTrailingWhiteSpace()

" Clean bad spaces
command! SpacesClean :call DeleteTrailingWhiteSpace() | call DoubleSpacesRemove() | call DoubleBlankLinesRemove()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" search replace
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" * search and go to first match
nmap * *N

" Clear search
nnoremap <silent> <leader><Esc> :let @/=""<cr>

" No highlight search
nnoremap <leader>/ :nohlsearch<cr>

" don't higlight search when sourcing .vimrc
let @/ = ""

" spanish keyboard
nnoremap ñ /

" Visual mode pressing * or # searches for the current selection
vnoremap <silent> * :<C-u>call EscapedSearch()<CR>/<C-R>=@/<CR><CR>N
vnoremap <silent> # :<C-u>call EscapedSearch()<CR>?<C-R>=@/<CR><CR>N

" <leader>r replace one by one
nnoremap <silent> <leader>r viw:call EscapedSearch()<CR>cgn
vnoremap <silent> <leader>r :call EscapedSearch()<CR>cgn

" <leader>R replace all
nnoremap <silent> <leader>R viw:call EscapedSearch()<CR>:call CmdLine("%s".'/'.@/.'/'.@/)<CR>
vnoremap <silent> <leader>R :call EscapedSearch()<CR>:call CmdLine("%s".'/'.@/.'/'.@/)<CR>

function! EscapedSearch() range

    " Backup what's in default register
    let l:saved_reg = @"

    " Copy selection
    execute 'normal! vgvy'

    " Escape special chars
    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    " Set search
    let @/ = l:pattern

    " Restore default register
    let @" = l:saved_reg

endfunction

function! CmdLine(str)
    call feedkeys(":" . a:str)
endfunction

"""""""""""""""""""""""""""""""""""
" Appereance
"""""""""""""""""""""""""""""""""""

" Set extra options when running in GUI mode
if has("gui_running")

    set guioptions-=m "remove menu bar
    set guioptions-=T "remove toolbar

    " Good fonts: source code pro, jetbrains mono, consolas, cascadia
    " select with: set guifont=*
    " check current with: :echo &guifont
    set guifont=CascadiaCode-Regular:h13
    " set guifont=Cascadia_Code_SemiBold:h10:W600:cANSI:qDRAFT

    " in windows, set render option for ligatures <> != >= <=
    if (has('win32') || has('win64'))
      set renderoptions=type:directx
    endif

else

  " Cursor in terminal
  " https://vim.fandom.com/wiki/Configuring_the_cursor
  " 1 or 0 -> blinking block
  " 2 solid block
  " 3 -> blinking underscore
  " 4 solid underscore
  " Recent versions of xterm (282 or above) also support
  " 5 -> blinking vertical bar
  " 6 -> solid vertical bar

  if &term =~ '^xterm'
    " normal mode
    let &t_EI .= "\<Esc>[3 q"
    " insert mode
    let &t_SI .= "\<Esc>[6 q"
  endif

endif

"""""""""""""""""""""""""
" Copy Search Matches "
"""""""""""""""""""""""""

" Copy all search matches
function! CopyMatches(reg)
  let hits = []
  %s//\=len(add(hits, submatch(0))) ? submatch(0) : ''/gne
  let reg = empty(a:reg) ? '+' : a:reg
  execute 'let @'.reg.' = join(hits, "\n") . "\n"'
endfunction
command! -register CopyMatches call CopyMatches(<q-reg>)

"""""""""""""""""""""""""
" File Explorer Netrw
"""""""""""""""""""""""""

let g:netrw_altfile = 1 " Don't register netrw as the alternate buffer
noremap <F4> :Explore<CR>

""""""""""""""
" File names "
""""""""""""""

" Expand %% to current dir in command line
cnoremap %% <C-R>=fnameescape(expand("%:p:h")."/")<CR>

" Expand ^^ to current file path in command line
cnoremap ^^ <C-R>=fnameescape(expand("%:p"))<CR>

" Expand && to only file name (tail)
cnoremap && <C-R>=fnameescape(expand("%:t"))<CR>

" Change dir to current path
command! ChangeDir :cd %:p:h<CR>

" Insert filename
nnoremap <Leader>fn i<space><C-R>=expand("%:t:r")<CR><space><ESC>

""""""""""""""
" Movement "
""""""""""""""

" Lines
nnoremap <C-l> g_
vnoremap <C-l> g_
nnoremap <C-h> ^
vnoremap <C-h> ^

" Buffers
nnoremap <C-j> :bn<CR>
nnoremap <C-k> :bp<CR>

" Alternate buffer
nnoremap <leader>k :b#<CR>

" Tabs
nnoremap <leader>tt :tabnew<CR>
nnoremap <leader>tc :tabclose<CR>
nnoremap ]t :tabnext<CR>
inoremap ]t <Esc>:tabnext<CR>

nnoremap [t :tabprevious<CR>
inoremap [t <Esc>:tabprevious<CR>

" Go to end of page and center
nnoremap G Gzz

""""""""""""""""""""""""""""""""""""""""
" Saving, closing
""""""""""""""""""""""""""""""""""""""""

nnoremap <leader>q :bd<CR>
nnoremap <leader>Q :bd!<CR>
nnoremap <leader>gq :qa!<CR>
nnoremap <leader>w :w!<CR>
nnoremap <leader>o :only<CR>
nnoremap <leader>bd :%bd<CR>

""""""""""""""""""""""""""""""""""""""""
" Append colon and semicolon
""""""""""""""""""""""""""""""""""""""""
nnoremap <leader>, A,<ESC>
nnoremap <leader>; A;<ESC>

""""""""""""""""""""""""""""
" Visual Shortcuts
""""""""""""""""""""""""""""

" Visual line
nnoremap <leader>l _vg_

" Visual document
nnoremap <leader>a ggVG

" Move lines in visual mode
vnoremap N :m '>+1<CR>gv=gv
vnoremap P :m '<-2<CR>gv=gv

" J K just move
vnoremap J j
vnoremap K k

"""""""""""""""""""""""""
" Quick fix
"""""""""""""""""""""""""
nnoremap [c :cprevious<cr>
nnoremap ]c :cnext<cr>
nnoremap <leader>co :copen<CR>;
nnoremap <leader>cc :cclose<CR>;

"""""""""""""""""""""""""
" Macros
"""""""""""""""""""""""""

" Execute macro q
nnoremap Q @q

" En visual mode ejecutarlo también
vnoremap Q :normal @q<CR>

""""""""""""""""""""
" Duplicate File
""""""""""""""""""""
function! s:duplicate(name)
  if a:name != ''
    execute "w %:h/" . a:name
    execute "e %:h/" . a:name
  endif
endfunction
:command! -nargs=1 -bar Duplicate :call s:duplicate(<f-args>)

command! QuickFixOpenAll call QuickFixOpenAll()

""""""""""""""""""""
" Utils
""""""""""""""""""""

" Delete all registers
command! WipeReg for i in range(34,122) | silent! call setreg(nr2char(i), []) | endfor

" wrap/unwrap
nnoremap <leader>gw :set wrap<CR>
nnoremap <leader>gW :set wrap!<CR>

""""""""""""""""""""
" Markdown
""""""""""""""""""""

nnoremap <leader>- "zyy"zpVr-o<esc>
nnoremap <leader>= "zyy"zpVr=o<esc>

""""""""""""""""""""
" Special considerations for filetypes
""""""""""""""""""""

augroup filetypes
  autocmd!

  " PHP remove $ from keyword
  autocmd BufReadPost *.php setlocal iskeyword-=$

  " Blade filetype
  autocmd BufRead,BufNewFile *.blade.php set filetype=blade

  " - is part of the word in these filetypes
  autocmd BufRead,BufNewFile {*.blade.php,*.html,*.css,*.scss} setlocal iskeyword+=-

  " Txt as markdown
  autocmd BufReadPost *.txt set filetype=markdown

augroup END

""""""""""""""""""""
" Color
""""""""""""""""""""

set background=dark

"""""""""""""""""""
" Resize splits
"""""""""""""""""""

nnoremap <leader><up> :resize -5<CR>
nnoremap <leader><down> :resize +5<CR>
nnoremap <leader><left> :vertical resize -5<CR>
nnoremap <leader><right> :vertical resize +5<CR>

" Date
nnoremap <localleader>ff i<c-r>=strftime("%Y-%m-%d")<CR><esc>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim-Plug
" https://github.com/junegunn/vim-plug
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Download if not exists
if !filereadable($HOME."/.vim/autoload/plug.vim")
    !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

set rtp+=$HOME/.vim " set runtimepath to use .vim folder instead of vimfiles
call plug#begin('$HOME/.vim/plugged')

" Create dir if not exists
if !isdirectory($HOME."/.vim/plugged")
  call mkdir($HOME."/.vim/plugged","p")
endif

" Colorscheme 
Plug 'tomasr/molokai'

" Surround
Plug 'tpope/vim-surround'

" Repeat better with .
Plug 'tpope/vim-repeat'

" Comment with gc
Plug 'tomtom/tcomment_vim'

" Git
Plug 'tpope/vim-fugitive'
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>ga :Git add -A<cr>
nnoremap <leader>gl :Git log<cr>
nnoremap <leader>gp :Gpush<cr>
nnoremap <leader>gd :Gdiffsplit<cr>
nnoremap <leader>g2 :diffget //2<cr>
nnoremap <leader>g3 :diffget //3<cr>

" Git browser
Plug 'junegunn/gv.vim'

" Sows a git diff in the sign column.
Plug 'airblade/vim-gitgutter'

" File browser F7
Plug 'scrooloose/nerdtree', { 'on': [ 'NERDTreeToggle', 'NERDTreeFind', 'NERDTreeCWD' ] }
let NERDTreeShowHidden=1
nnoremap <F7> :NERDTreeToggle<CR>
nnoremap <F8> :NERDTreeFind<CR>

" Change directory also in nerdtree
nnoremap <leader>cd :cd %:p:h<CR>:NERDTreeCWD<CR>

" Auto close brackets
Plug 'jiangmiao/auto-pairs'
let g:AutoPairsShortcutToggle='' " disable alt-p

" Search with RipGrep :Rg
Plug 'jremmen/vim-ripgrep'

" Info in footer line, buffers as tabs
Plug 'vim-airline/vim-airline'

let g:airline#extensions#tabline#enabled = 1

" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

" Show terminal buffers
let g:airline#extensions#tabline#ignore_bufadd_pat = 'defx|gundo|nerd_tree|startify|tagbar|undotree|vimfiler'


" Useful commands: Delete, Rename, SudoWrite, Mkdir and more
Plug 'tpope/vim-eunuch'

" Syntax for popular languages
Plug 'sheerun/vim-polyglot'

" FZF Fuzzy Finder "
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Use RipGrep to list files for fzf
let $FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'

" Search files
nnoremap <C-p> :Files<CR>

" History files
noremap <leader>h :History<CR>

" Commands
nnoremap <leader>: :History:<CR>

" jump to line
nnoremap <leader>j :Lines<CR>

" Find buffer
nnoremap <C-f> :Buffers<CR>

" Open fzf below, floating window doesn't work as great
let g:fzf_layout = { 'down': '~40%' }

" Display markers "
Plug 'kshenoy/vim-signature'

" Change case (casing) gs
Plug 'arthurxavierx/vim-caser'
" MixedCase or PascalCase       gsm or gsp      <Plug>CaserMixedCase/<Plug>CaserVMixedCase
" camelCase     gsc     <Plug>CaserCamelCase/<Plug>CaserVCamelCase
" snake_case    gs_     <Plug>CaserSnakeCase/<Plug>CaserVSnakeCase
" UPPER_CASE    gsu or gsU      <Plug>CaserUpperCase/<Plug>CaserVUpperCase
" Title Case    gst     <Plug>CaserTitleCase/<Plug>CaserVTitleCase
" Sentence case gss     <Plug>CaserSentenceCase/<Plug>CaserVSentenceCase
" space case    gs<space>       <Plug>CaserSpaceCase/<Plug>CaserVSpaceCase
" dash-case or kebab-case       gs- or gsk      <Plug>CaserKebabCase/<Plug>CaserVKebabCase
" Title-Dash-Case or Title-Kebab-Case   gsK     <Plug>CaserTitleKebabCase/<Plug>CaserVTitleKebabCase
" dot.case      gs.     <Plug>CaserDotCase/<Plug>CaserVDotCase

"""""""""""""""""""""""""
" CoC Code Completion
" https://github.com/neoclide/coc.nvim
"""""""""""""""""""""""""

Plug 'neoclide/coc.nvim', {'branch': 'release'}

let g:coc_global_extensions = [
\ 'coc-snippets',
\ 'coc-prettier',
\ ]

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=50

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time diagnostics appear/become resolved.
set signcolumn=yes

inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1] =~# '\s'
endfunction

let g:coc_snippet_next = '<C-j>'
let g:coc_snippet_prev = '<C-k>'

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

augroup cursor
  autocmd!
  " Highlight the symbol and its references when holding the cursor.
  autocmd CursorHold * silent call CocActionAsync('highlight')
augroup END

" Symbol renaming.
nmap <leader>crn <Plug>(coc-rename)

" Range format like <leader>fip
vmap <leader>f <Plug>(coc-format-selected)
nmap <leader>f <Plug>(coc-format-selected)

" Complete document format
nnoremap <leader>ff :Format<cr>

" augroup mygroup
" autocmd!
  " Setup formatexpr specified filetype(s).
  " autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  " autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
" augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>ca <Plug>(coc-codeaction-selected)
nmap <leader>ca <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
" nmap <leader>ac <Plug>(coc-codeaction)
" " Apply AutoFix to problem on the current line.
nnoremap <leader>cf <Plug>(coc-fix-current)

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
" xmap if <Plug>(coc-funcobj-i)
" xmap af <Plug>(coc-funcobj-a)
" omap if <Plug>(coc-funcobj-i)
" omap af <Plug>(coc-funcobj-a)

" Use <TAB> for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support from the language server.
" coc-tsserver, coc-python are the examples of servers that support it.
" nmap <silent> <TAB> <Plug>(coc-range-select)
" xmap <silent> <TAB> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings using CoCList:
" Show all diagnostics.
" nnoremap <silent> <space>a :<C-u>CocList diagnostics<cr>
" Manage extensions.
" nnoremap <silent> <space>e :<C-u>CocList extensions<cr>
" Show commands.
" nnoremap <silent> <space>c :<C-u>CocList commands<cr>
" Find symbol of current document.
" nnoremap <silent> <space>o :<C-u>CocList outline<cr>
" Search workspace symbols.
" nnoremap <silent> <space>s :<C-u>CocList -I symbols<cr>
" Do default action for next item.
" nnoremap <silent> <space>j :<C-u>CocNext<CR>
" Do default action for previous item.
" nnoremap <silent> <space>k :<C-u>CocPrev<CR>
" Resume latest coc list.
" nnoremap <silent> <space>p :<C-u>CocListResume<CR>
"
""""""""""""""""""""""""""""
" Coc Extensions
""""""""""""""""""""""""""""
nnoremap <leader>p  :<C-u>CocList -A --normal yank<cr>

""""""""""""""""""""""""""""
" snippets
" https://github.com/neoclide/coc-snippets
""""""""""""""""""""""""""""

" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
" vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-n>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-p>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

" Edit snippets
nnoremap <leader>u :CocCommand snippets.editSnippets<CR>

""""""""""""""""""""""""""""""""""""""""""
" /plugins
""""""""""""""""""""""""""""""""""""""""""

call plug#end()

colorscheme molokai
