" for xterm 256-color support, create the following files:
" ~/.Xdefaults 
"     customization: -color
"     XTerm*termName:  xterm-256color
" ~/.xsession
"     if [ -f $HOME/.Xdefaults ]; then
"       xrdb -merge $HOME/.Xdefaults
"     fi

" plugins:
"  - pathogen
"  - command-t (building?)
"  - syntastic
"  - taglist
"  - fugitive
"  - pyflakes

" other things to find out:
"  - decent colorscheme
"  - 80-column highlight bar
"  - current cursor pos vertical highlight bar
"  - statusline - filetype, syntax errors etc.

" avoid potential security problem: prevent modelines from being evaluated
set modelines=0
" we don't want true vi compatibility
set nocompatible

call pathogen#infect()
call pathogen#helptags()

" when TAB is pressed, insert the appropriate amount of spaces (which is 2!)
set expandtab
set shiftwidth=2
set tabstop=2 " TODO: this could stay at 8 for correct displaying of other code?

" make TAB and BS work on whole indentation levels (not affecting just single spaces/tabs)
set smarttab " TODO: see cindent

" enable "smart" and "automatic" indentation
set smartindent
set autoindent

" do not make backup before overwriting a file
set nobackup

" backspacing: allow BS-ing across line breaks, beggining of insert etc.
set backspace=indent,eol,start

" save state of vim in .viminfo file
"   %:    save/restore buffer list (reload it when vim is invoked without params)
"   '50:  remember marks for 50 files
"   \"50: (also <50) would limit register buffers to 50 lines (unset:unlimited)
set viminfo=%,'50,n~/dotfiles/vim/viminfo
" remember 50 lines of history
set history=50

" enable highlighting of search term
set hlsearch

" always show curser position in status line
set ruler

" show line numbers
set number

" enable syntax highlighting by default
syntax on


" show (partial) command in status line
set showcmd

" show matching brackets
set showmatch

" do case insensitive matching ... unless when search pattern contains upper case letters
set ignorecase
set smartcase

" incremental (as you type) search
set incsearch
" automatically save before :make, :next etc.
set autowrite

" make F2 / \K pop up a vim window with the current word's MAN page
runtime! ftplugin/man.vim
nnoremap <silent> <F2> :normal \K<CR>


" Make p in Visual mode replace the selected text with the "" register.
vnoremap p <Esc>:let current_reg = @"<CR>gvdi<C-R>=current_reg<CR><Esc>

" suffixes that get lower priority when autocompleting filenames
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc

" F12 toggles between paste mode and nopaste
set pastetoggle=<F12>

" Set dark background
set background=dark

" c indent option: indent using 1 shiftwidth
set cinoptions=>1s 


set statusline =
set statusline+=%< " truncate starts here
set statusline+=%1*%f%* " filename with custom color
set statusline+=%f " filename
set statusline+= " "
set statusline+=%h " help buffer flag
set statusline+=%m " modified flag
set statusline+=%r " read only flag
set statusline+=%#warningmsg#%{SyntasticStatuslineFlag()}%* " syntax warnings
set statusline+=%=%-14.(%l,%c%V%)\ %P

" function to be called with autocmd to enable F5 = :make
fun! F5Wrapper()
    if &filetype != "tex" && &filetype != "plaintex" 
        nnoremap <buffer> <silent> <F5> :make<CR><CR> :cwindow<CR>
    else
        nnoremap <buffer> <silent> <F5> :make<CR>
    endif
endfun

"autocmd BufNewFile,BufRead *.lsp,*.lisp,*.lsh,*.lush source ~/.vim/noautoload/VIlisp.vim
autocmd BufNewFile,BufRead *.launch set syntax=xml
autocmd BufNewFile,BufRead * call F5Wrapper()

" For omnicompletion
set tags+=~/.vim/tags/stl.tags
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"] " ????
set completeopt-=preview

" center display after searching
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#z

"set t_Co=256  " sometimes helps on term's without correct $TERM set
colorscheme evening

""""""""""""""""""""""""""""""""""""""
" double check the rest of this file "
""""""""""""""""""""""""""""""""""""""
" if has("autocmd")
"  " Enabled file type detection
"  " Use the default filetype settings. If you also want to load indent files
"  " to automatically do language-dependent indenting add 'indent' as well.
"  filetype plugin indent on
" endif " has ("autocmd")

" map <c-w><c-t> :NERDTreeToggle<cr>
" map <S-Left> <C-W>h
" map <S-Right> <C-W>l
" map <S-Up> <C-W>k
" map <S-Down> <C-W>j

" " ?
" let g:bufExplorerWidth = 50
" let g:winManagerWindowLayout = "FileExplorer"
" 
" " NERD_tree stuff
" let g:NERDTreeMapActivateNode = '<CR>'
" let g:NERDTreeMapCloseDir = '-'
" let g:NERDTreeMapCloseChildren = '<BS>'
" let g:NERDTreeSortOrder = [ '\/$', '\.asd', '\.nsp', '\.lisp', '\.h$\|\.hpp$\|\.hh$', '\.c$\|\.cc$\|\.cpp$\|\.cxx$', '*' ]

