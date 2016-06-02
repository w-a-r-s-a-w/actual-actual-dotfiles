" All system-wide defaults are set in $VIMRUNTIME/archlinux.vim (usually just
" /usr/share/vim/vimfiles/archlinux.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vimrc), since archlinux.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing archlinux.vim since it alters the value of the
" 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages.
runtime! archlinux.vim

" If you prefer the old-style vim functionalty, add 'runtime! vimrc_example.vim'
" Or better yet, read /usr/share/vim/vim74/vimrc_example.vim or the vim manual
" and configure vim to your own liking!

" config
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

:filetype plugin off
:syntax on
" :set number
:set cursorline
" :set cursorcolumn
:hi CursorLine   cterm=NONE ctermbg=blue ctermfg=white
" :hi CursorColumn   cterm=NONE ctermbg=green ctermfg=magenta
" :hi LineNr cterm=NONE ctermbg=blue ctermfg=cyan
" :hi CursorLineNr cterm=none ctermbg=blue ctermfg=white
:hi Comment cterm=NONE ctermbg=blue ctermfg=NONE
:nnoremap H :set cursorline! cursorcolumn!<CR>
:set showcmd
:set ignorecase
:set smartcase
