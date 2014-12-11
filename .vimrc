set nocompatible
filetype on " avoid exiting with error
filetype off
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#rc()

Bundle 'gmarik/Vundle.vim'
Bundle 'bling/vim-airline'
"Bundle 'syntastic'
"Bundle 'pydave/AsyncCommand'
"Bundle 'stgpetrovic/syntastic-async'
Bundle 'molokai'
"auto detect encoding
Bundle 'FencView.vim'
Bundle 'Tagbar'
Bundle 'a.vim'
"Bundle 'echofunc.vim'
Bundle 'taglist.vim'
Bundle 'winmanager'
Bundle 'https://github.com/Shougo/neocomplcache.vim.git'
Plugin 'SirVer/ultisnips'
Bundle "pangloss/vim-javascript"
Bundle 'wesleyche/Trinity'
Bundle 'wesleyche/SrcExpl'
Bundle 'peaksea'
Bundle 'honza/vim-snippets'
""Bundle 'Valloric/YouCompleteMe'
Plugin 'kchmck/vim-coffee-script'
Bundle 'kien/rainbow_parentheses.vim'
Bundle 'nvie/vim-flake8'
Bundle 'myhere/vim-nodejs-complete'
"Bundle 'hallettj/jslint.vim'
Plugin 'bronson/vim-trailing-whitespace'

syntax enable
filetype plugin indent on

set hlsearch
set backspace=indent,eol,start
set history=50
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
	set mouse=a
endif

" Put these in an autocmd group, so that we can delete them easily.
augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif

  autocmd Filetype ruby set sw=2
  autocmd Filetype cpp set makeprg=g++\ -Wall\ -g\ %\ -o\ %:r
  autocmd Filetype java set makeprg=javac\ %\ &&\ java\ %:r
  autocmd Filetype python set makeprg=python\ %
  autocmd FileType python map <buffer> <F3> :call Flake8()<CR>
  " autocmd BufWritePost *.py call Flake8()

  autocmd BufReadPost *.html set ts=6

  au VimEnter * RainbowParenthesesToggle

augroup END

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
	command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
				\ | wincmd p | diffthis
endif


let Tlist_Use_Right_Window=1
"let Tlist_Auto_Open=1
let Tlist_Exit_OnlyWindow = 1

set encoding=utf-8
silent !mkdir -p ~/.backup > /dev/null 2>&1
silent !mkdir -p ~/.vimundo > /dev/null 2>&1
set backupdir=~/.backup/
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1

colorscheme molokai
let g:winManagerWindowLayout='FileExplorer'

let g:neocomplcache_enable_at_startup = 1
set autochdir
let g:js_indent_log = 0

set expandtab
set tags=tags;

set directory=/tmp//

let g:airline_theme='light'
let g:airline_powerline_fonts=0
set laststatus=2

map <D-r> :make<CR>

let g:snips_author='Bo Tian <smxtianbo@gmail.com>'

function! s:insert_gates()
  let gatename = substitute(toupper(expand("%:t")), "\\.", "_", "g")
  execute "normal! i#ifndef " . gatename
  execute "normal! o#define " . gatename . " "
  execute "normal! Go#endif /* " . gatename . " */"
  normal! kk
endfunction
autocmd BufNewFile *.{h,hpp} call <SID>insert_gates()

"set grepprg=grep\ -nH\ $*
set nofoldenable
set sw=2
set ts=2
set nu
set undofile
set undodir=~/.vimundo
