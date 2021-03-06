set rtp+=$HOME/.vim/bundle/Vundle.vim/
runtime macros/matchit.vim
call vundle#rc()
source $HOME/.vim/vundle.vim

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BASIC EDITING CONFIGURATION
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
scriptencoding utf8
set encoding=utf8
set fileencoding=utf8
set termencoding=utf8

set list " display unprintable characters
set listchars=tab:▸\ ,trail:·
set nowrap " avoid breaking a line single line into multiple lines
set nocompatible " make vim not compatible with vi
set hidden " allow unsaved background buffers and remember marks/undo for them
set history=100 " remember more commands and search history (default is 20)
set expandtab " insert spaces instead of tabs
set smarttab
set tabstop=2 " define how many spaces are added for a tab
set shiftwidth=2 " number of spaces used for autoindent (<<, >>)
set laststatus=2 " always shows statusline for every window
set incsearch " show search result as I type
set hlsearch " highlight the search results
set ignorecase smartcase " make searches case-sensitive only if they contain upper-case characters
set cursorline " highlight current line
set cmdheight=1 " number of screen lines used for the command-line
set number " show line numbers
" set relativenumber " show line numbers relative to the current line
set numberwidth=1 " minimal number of columns to used for the line number
set showtabline=2 " always displays tabs
set t_ti= t_te= " doesn't remove vim screen from the view when running external commands (:!ls)
set completefunc=syntaxcomplete#Complete " specifies a function to be used for Insert mode completion with CTRL-X CTRL-U.
set ruler " show line and column numbers in the status bar
set lazyredraw " using relativenumbers/cursorline makes vim pagination (j/k) extremely slow. This helps a little bit.

" entering normal mode timeout
set timeoutlen=1000 ttimeoutlen=0

" Store temporary files in a central spot
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set showcmd " display incomplete commands
set iskeyword+=-,?,! " include '?' and '!' in autocomplete

" Enable file type detection.
" Use the default filetype settings, so that mail gets 'tw' set to 72,
" Also load indent files, to automatically do language-dependent indenting.
filetype plugin indent on

set wildmode=longest,list " use emacs-style tab completion when selecting files, etc
set wildmenu " make tab completion for files/buffers act like bash
set wildignore+=*.zip,*.gz,*.bz,*.tar
set wildignore+=*.jpg,*.png,*.gif,*.avi,*.wmv,*.ogg,*.mp3,*.mov

set exrc            " enable per-directory .vimrc files
set secure          " disable unsafe commands in local .vimrc files

" indent with 2 spaces
autocmd FileType ruby,haml,eruby,yaml,html,javascript,sass,cucumber,sh set ai sw=2 sts=2 et

" indent with 4 spaces in java files
autocmd FileType java set ai sw=4 sts=4 et

autocmd FileType xml setlocal equalprg=xmllint\ --format\ -

" spell check markdown files
autocmd FileType markdown,gitcommit set textwidth=80
setlocal nospell

let &colorcolumn="100,".join(range(120,999),",")

" Clipboard interacts with system clipboard
set clipboard=unnamed

set autoread

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COLORS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set background=dark
set t_Co=256
syntax enable
" let g:solarized_termcolors=256
colorscheme monokai

hi SpellBad cterm=bold ctermbg=red ctermfg=white

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SNIPPETS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" source $HOME/.vim/snippets/support_functions.vim

" let g:snipMate = {}
" let g:snipMate.scope_aliases = {}
" let g:snipMate.scope_aliases['ruby'] = 'ruby,ruby-rails,ruby-rspec'
" let g:snipMate.scope_aliases['eruby'] = 'html'
" let g:snipMate.scope_aliases['eelixir'] = 'html'
" let g:snipMate.scope_aliases['haml'] = 'html'
" let g:snipMate.scope_aliases['javascript'] = 'javascript,javascript-jasmine,handlebars,angular'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" EXECUTE COMMAND PRESERVING THE LOCATION
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! Preserve(command)
let _s=@/

let l:winview = winsaveview()
silent execute a:command
call winrestview(l:winview)

let @/=_s
endfunction


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MAP LEADER KEY
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader = ","

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ARROW KEYS ARE UNACCEPTABLE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <Left> :echo "Arrow keys are not allowed"<cr>
map <Right> :echo "Arrow keys are not allowed"<cr>
map <Up> :echo "Arrow keys are not allowed"<cr>
map <Down> :echo "Arrow keys are not allowed"<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" REMOVE TRAILING WHITESPACES AND BLANK LINES
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! StripTrailingWhitespace()
if &ft !~ 'markdown'
  call Preserve('%s/\s\+$//e')
endif
endfun

autocmd BufWritePre * call StripTrailingWhitespace()
autocmd BufWritePre * call Preserve('%s/\v($\n\s*)+%$//e')

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" USE A BAR-SHAPED CURSOR FOR INSERT MODE.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MAKE SURE VIM RETURNS TO THE SAME LINE WHEN YOU REOPEN A FILE.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup line_return
  au!
  au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \     execute 'normal! g`"zvzz' |
        \ endif
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SHUT UP BACKUP FILES
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set undodir=/tmp/
set backupdir=/tmp/
set directory=/tmp/
set backup
set noswapfile

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" USE THE MOUSE TO SCROLL
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set mouse=a " works in all modes
" set ttymouse=xterm2

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" USE *, # AND ! IN VISUAL MODE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! VSetSearch()
try
  let temp = @s
  norm! gv"sy
  return substitute(escape(@s, '\'), '\n', '\\n', 'g')
finally
  let @s = temp
endtry
endfunction

vnoremap * :<c-u>set hls \| let @/=VSetSearch()<CR>//<CR>
vnoremap # :<c-u>set hls \| let @/=VSetSearch()<CR>??<CR>
vnoremap <silent> ! :<c-u>set hls \| let @/=VSetSearch()<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" DISABLE STANDARD PLUGINS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:loaded_getscriptPlugin=1 " download latest version of vim scripts
" let g:loaded_netrwPlugin=1 " read and write files over a network
let g:loaded_tarPlugin=1 " tar file explorer
let g:loaded_2html_plugin=1 " convert to html
let g:loaded_vimballPlugin=1 " create self-installing Vim-script
let g:loaded_zipPlugin=1 " zip archive explorer
let loaded_gzip=1 " reading and writing compressed files
let loaded_rrhelper=1 " helper function(s) for --remote-wait

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" TAGS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set tags=./.git/tags;
set notagrelative " Look for tags relative to CWD, not tags file


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MISC KEY MAPS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SPLITS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
nnoremap < 3<c-w><
nnoremap > 3<c-w>>
nnoremap _ :exe "resize +3"<CR>
nnoremap - :exe "resize -3"<CR>


set splitright
set splitbelow


" Clear the search buffer when hitting return
nnoremap <cr> :nohlsearch<cr>

" switch between last two files
nnoremap <leader><leader> <c-^>

" jk to go to normal mode
inoremap jk <esc>l

" run current file
autocmd FileType elixir nnoremap ,1 :w <enter> :!elixir %<cr>
autocmd FileType ruby   nnoremap ,1 :w <enter> :!ruby %<cr>
autocmd FileType go     nnoremap ,1 :w <enter> :!go run %<cr>
autocmd FileType node   nnoremap ,1 :w <enter> :!node %<cr>

nnoremap j gj
nnoremap k gk

" TABS
nnoremap <leader>tt :tabnew<cr>
nnoremap <leader>cc :tabc<cr>
nnoremap <leader>to :tabonly<cr>
" gt Next Tab
nnoremap gr gT

" Redo
nnoremap U <c-r>

" highlight word under cursor w/o moving the cursor position
nnoremap <silent> ! :set hls \| let @/=expand('<cword>')<CR>

" edit and source vimrc
nnoremap <leader>ev :100vs  ~/.vimrc<cr>
nnoremap <leader>sv :source ~/.vimrc<cr>

" indent file
" nnoremap <leader>f :call Preserve('normal gg=G')<CR>

" nnoremap ,dp Obinding.pry<esc>
" nnoremap ,db Orequire 'byebug'; byebug<esc>

" nnoremap <F4> :TagbarToggle<cr>
" nnoremap <C-]> g<C-]>
" nnoremap ,mt <c-w>T<cr> " move current buffer to its own tab
" nnoremap ,mb :sbp <bar> wincmd p <bar> wincmd T<cr> " split buffer and move it to a tab

" eval clojure code
" vnoremap ,e :Eval<cr>
" nnoremap ,e :Eval<cr>

" select entire buffer
nnoremap <leader>a maggVG

" duplicate selected text [b]ellow or [a]bove
vnoremap ,cb y'>o<esc>p
vnoremap ,ca y'<O<esc>P

inoremap <c-b> <left>
inoremap <c-f> <right>

" type (( to have (<cursor>)
inoremap {{{<cr> {};<esc>hi<cr><esc>O
inoremap ((<cr> ()<esc>i<cr><esc>O
inoremap [[<cr> []<esc>i<cr><esc>O
inoremap {{<cr> {}<esc>i<cr><esc>O

inoremap (( ()<esc>i
inoremap [[ []<esc>i
inoremap {{ {}<esc>i
inoremap '' ''<esc>i
inoremap "" ""<esc>i
inoremap `` ``<esc>i

" Delete a word on alt+backspace
inoremap <m-bs> <c-w>

" inoremap <c-k> []()<esc>F[a

" finds duplicate words
" nnoremap ,fd /\(\<\w\+\>\)\_s*\1<cr>

" reloads the active chrome tab
" nnoremap ,r :!sh $HOME/.dotfiles/vim/custom-scripts/reload-chrome<cr> | redraw

" Moves selected lines up and down with <c-{j,k}>
" '> is the last line of the visual selection
vnoremap <c-j> :m'>+1<cr>gv=gv
vnoremap <c-k> :m-2<cr>gv=gv

" nnoremap ,s :AV<cr>
nnoremap <silent> ,gf :vertical botright wincmd f<cr>

" move horizontal to vertical split
nnoremap ,v <c-w>t<c-w>H

" Copy github link to current line
" nnoremap ,b <S-v>:Gbrowse!<cr>
" nnoremap <leader>to :vs ~/Dropbox/.todo<cr>
" nnoremap ,as :vs ~/Dropbox/.alphasights-todo<cr>

let g:VimuxOrientation = "h"
nnoremap ,ns :set nospell<cr>
nnoremap ,ss :set spell<cr>

" Apply a macro to the selected visual block
" https://medium.com/@schtoeffel/you-don-t-need-more-than-one-cursor-in-vim-2c44117d51db
source $HOME/.vim/custom_scripts/visual-at.vim

" Easily tab through buffers
" http://vim.wikia.com/wiki/Cycle_through_buffers_including_hidden_buffers
:nnoremap <Tab> :bnext<CR>
:nnoremap <S-Tab> :bprevious<CR>
:nnoremap <leader>q :bd<CR>

" Keep the cursor centered while scrolling
set scrolloff=999

" Shortcuts I tend to forget...
" zz        Center the cursor in the middle of the screen
" zt        Move the cursor to the top of the screen
" zb        Move the cursor to the bottom of the screen

" Ruby Snippets
inoremap rcc<Tab> context '' do<cr>end<esc>kf'a
inoremap rdd<Tab> describe '' do<cr>end<esc>kf'a
inoremap rii<Tab> it '' do<cr>end<esc>kf'a
inoremap doo<Tab> do<cr>end<esc><s-o>
