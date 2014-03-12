" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2008 Dec 17
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
	finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
	set nobackup		" do not keep a backup file, use versions instead
else
	set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
	set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
	syntax on
	set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

	" Enable file type detection.
	" Use the default filetype settings, so that mail gets 'tw' set to 72,
	" 'cindent' is on in C files, etc.
	" Also load indent files, to automatically do language-dependent indenting.
	filetype plugin indent on

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
                "		autocmd Filetype ruby colorscheme blackboard

		autocmd BufReadPost *.html set ts=6

	augroup END

else

	set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
	command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
				\ | wincmd p | diffthis
endif

set nu

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'bling/vim-airline'
Bundle 'OmniCppComplete'
Bundle 'gmarik/vundle'
Bundle 'pylint.vim'
Bundle 'molokai'
Bundle 'FencView.vim'
Bundle 'Lokaltog/vim-powerline'
Bundle 'Tagbar'
Bundle 'a.vim'
Bundle 'echofunc.vim'
Bundle 'taglist.vim'
Bundle 'winmanager'
Bundle 'https://github.com/Shougo/neocomplcache.vim.git'
Bundle 'snipMate'
Bundle 'blackboard.vim'
Bundle "pangloss/vim-javascript"
Bundle 'wesleyche/Trinity'
Bundle 'wesleyche/SrcExpl'
Bundle 'moll/vim-node'
Bundle 'kchmck/vim-coffee-script'     
Bundle 'fencview.vim'
Bundle 'peaksea'

syntax enable
filetype plugin indent on

let Tlist_Use_Right_Window=1
"let Tlist_Auto_Open=1
let Tlist_Exit_OnlyWindow = 1

set encoding=utf-8
set backupdir=~/.backup/
"set makeprg=c++\ -Wall\ -g\ %\ -o\ %:r
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
map <F5> :w<CR>:make<CR>:!./%:r<CR>
map <F6> :w<CR>:make<CR>:!cgdb %:r<CR>
map <F7> :w<CR>:make<CR>

colorscheme molokai
let g:winManagerWindowLayout='FileExplorer'

"autocmd BufEnter * nested :call tagbar#autoopen(0)
let g:neocomplcache_enable_at_startup = 1
set autochdir
let g:snippets_dir = '~/.vim/bundle/snipMate/snippets'
let g:js_indent_log = 0

set expandtab
set tags=tags;
let Tlist_Ctags_Cmd = '/usr/local/Cellar/ctags/5.8/bin/ctags'

set directory=/tmp//
if has("gui_macvim")
        set transparency=10
endif

let g:airline_powerline_fonts=1
let g:airline_theme='light'
let g:airline_powerline_fonts=0
set laststatus=2
