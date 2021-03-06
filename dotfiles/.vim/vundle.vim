set nocompatible
filetype off

set rtp+=~/.vim/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

" Color schemes
Bundle 'sickill/vim-monokai'

" UI / Theme
Bundle 'scrooloose/nerdtree'

Bundle 'ryanoasis/vim-devicons'
Bundle 'vim-airline/vim-airline'
Bundle 'vim-airline/vim-airline-themes'
Bundle 'edkolev/tmuxline.vim'

" Fuzzy Finder
Bundle 'junegunn/fzf'
Bundle 'junegunn/fzf.vim'

" Syntax
Bundle 'w0rp/ale'

" Git related
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-rhubarb'
Bundle 'airblade/vim-gitgutter'

" Utilities
Bundle 'mileszs/ack.vim'
Bundle 'skywind3000/asyncrun.vim'
Bundle 'Valloric/YouCompleteMe'
Bundle 'ludovicchabant/vim-gutentags'
" Bundle 'tpope/vim-dispatch'
" Bundle 'jsfaint/gen_tags.vim'

" Javascript
Bundle 'pangloss/vim-javascript'
Bundle 'mxw/vim-jsx'
Bundle 'flowtype/vim-flow'

" Ruby
Bundle 'vim-ruby/vim-ruby'
Bundle 'noprompt/vim-yardoc'

" Test runner
Bundle 'janko-m/vim-test'

" Markdown
Bundle 'godlygeek/tabular'
Bundle 'plasticboy/vim-markdown'

" Hacklang
Bundle 'hhvm/vim-hack'

" Rust
Bundle 'rust-lang/rust.vim'

" Bundle 'L9'

" Tab visualizer
Bundle 'majutsushi/tagbar'

" LSP
Bundle 'prabirshrestha/async.vim'
Bundle 'prabirshrestha/vim-lsp'

" Bundle 'ekalinin/dockerfile.vim'
" Bundle 'altercation/vim-colors-solarized'
" Bundle 'chrisbra/color_highlight'
" Bundle 'tpope/vim-endwise'
" Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-surround'
" Bundle 'tpope/vim-repeat'
" Bundle 'tpope/vim-commentary'
" Bundle 'tomtom/quickfixsigns_vim'
" Bundle 'pangloss/vim-javascript'
" Bundle 'terryma/vim-multiple-cursors'
" Bundle 'sunaku/vim-ruby-minitest'
" Bundle 'mustache/vim-mustache-handlebars'
" Bundle 'lambdatoast/elm.vim'
" Bundle 'benmills/vimux'
" Bundle 'elixir-lang/vim-elixir'
" Bundle 'fatih/vim-go'

" snippets
" Bundle 'MarcWeber/vim-addon-mw-utils'
" Bundle 'tomtom/tlib_vim'
" Bundle 'garbas/vim-snipmate'

" tmux
" Bundle 'jgdavey/tslime.vim'

" ### PLUGINS ###

" NERD Tree
map <C-n> :NERDTreeToggle<CR>
" autocmd vimenter * NERDTree " Auto open nerdtree on open
let NERDTreeShowHidden=1

" FZF
nmap ; :Buffers<CR>
nmap ,f :Files<CR>
nmap ,r :Tags<CR>
let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git --ignore node_modules -g ""'

" vim-test
let test#strategy = "dispatch"
nmap <silent> <leader>tn :TestNearest<CR>
nmap <silent> <leader>tf :TestFile<CR>
nmap <silent> <leader>ts :TestSuite<CR>
nmap <silent> <leader>tl :TestLast<CR>
nmap <silent> <leader>tc :TestVisit<CR>

" Search?
" nmap <M-k>    :Ag! "\b<cword>\b" <CR>
" nmap <Esc>k   :Ag! "\b<cword>\b" <CR>
" nmap <M-S-k>  :Ggrep! "\b<cword>\b" <CR>
" nmap <Esc>K   :Ggrep! "\b<cword>\b" <CR>

" Ale linter config
let g:ale_sign_error = '●' " Less aggressive than the default '>>'
let g:ale_sign_warning = '.'
let g:ale_lint_on_enter = 0 " Less distracting when opening a new file
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0
let g:airline#extensions#ale#enabled = 1
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" FF
if v:version >= 800
  let g:ale_completion_enabled = 1
  nnoremap <silent> K :ALEHover<CR>
  nnoremap <silent> gd :ALEGoToDefinition<CR>
  nnoremap <M-LeftMouse> <LeftMouse>:ALEGoToDefinition<CR>

  " show type on hover
  if v:version >= 801
    set balloonevalterm
    let g:ale_set_balloons = 1
  endif
endif

let g:ale_echo_msg_format = "[%linter%]%[ code]% %s"

" vim-jsx
let g:jsx_ext_required = 0 " Allow JSX in normal JS files

" Run prettier on js file save
autocmd BufWritePost *.js AsyncRun -post=checktime ./node_modules/.bin/eslint --fix %
autocmd BufWritePost *.jsx AsyncRun -post=checktime ./node_modules/.bin/eslint --fix %

" == Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_powerline_fonts = 1 " Install fonts first!
let g:airline_theme = 'bubblegum'

" Use Ag instead of Ack for searching using :Ack, this requires
" the silver searcher program installed
" https://github.com/ggreer/the_silver_searcher
let g:ackprg = 'ag --hidden --ignore .git --ignore node_modules --nogroup --nocolor --column'

" == Gutentags
let g:gutentags_ctags_tagfile = './.git/tags'

" == TmuxLine
" :Tmuxline vim_statusline_3
" :Tmuxline airline
let g:tmuxline_preset = 'full'

" vim-lsp
if executable('flow')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'flow',
        \ 'cmd': {server_info->['flow', 'lsp']},
        \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), '.flowconfig'))},
        \ 'whitelist': ['javascript', 'javascript.jsx'],
        \ })
endif


" Rust
"  YCM autocompleter
nmap <C-]> :YcmCompleter GoTo<CR>
imap <C-]> <ESC>:YcmCompleter GoTo<CR>
" '/Users/sergiodelrio/.rustup/toolchains/stable-x86_64-apple-darwin/lib/rustlib/src/rust/src'
" let g:ycm_rust_src_path = "$(rustc --print sysroot)/lib/rustlib/src/rust/src"

"  Auto format on save
let g:rustfmt_autosave = 1
