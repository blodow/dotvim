" some more plugins to check out:
"  - command-t (building?)
"  - pyflakes

" other things to find out:
"  - statusline - filetype, syntax errors etc.

" avoid potential security problem: prevent modelines from being evaluated
set modelines=0
" we don't want true vi compatibility
set nocompatible

" have Pathogen load all plugins
call pathogen#infect()
call pathogen#helptags()

" enable all mouse modes
set mouse=a

" save state of vim in .viminfo file
"   %:    save/restore buffer list (reload it when vim is invoked w/o params)
"   '50:  remember marks for 50 files
"   \"50: (also <50) would limit register buffers to 50 lines (unset:unlimited)
set viminfo=%,'50,n~/.vim/viminfo
" remember 50 lines of history
set history=50
" remember last edit pos
au BufReadPost * 
   \ if line("'\"") > 0
   \|   if line("'\"") <= line("$") 
   \|     exe("norm '\"")
   \|   else
   \|     exe "norm $"
   \|   endif
   \| endif

" do not make backup before overwriting a file
set nobackup

" automatically save before :make, :next etc.
set autowrite

" Make p in Visual mode replace the selected text with the "" register.
vnoremap p <Esc>:let current_reg = @"<CR>gvdi<C-R>=current_reg<CR><Esc>

" suffixes that get lower priority when autocompleting filenames
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,
            \.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc

" enable file type detection
filetype plugin indent on

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" "                                IDE OPTIONS                             " "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" make F2 / \K pop up a vim window with the current word's MAN page
runtime! ftplugin/man.vim
nnoremap <silent> <F2> :normal \K<CR>

" function to be called with autocmd to enable F5 = :make
fun! F5Wrapper()
    if &filetype != "tex" && &filetype != "plaintex" 
        nnoremap <buffer> <silent> <F5> :make<CR><CR> :cwindow<CR>
    else
        nnoremap <buffer> <silent> <F5> :make<CR>
    endif
endfun
autocmd BufNewFile,BufRead * call F5Wrapper()

" for ROS launch files:
autocmd BufNewFile,BufRead *.launch set syntax=xml

" For omnicompletion
set tags+=~/.vim/tags/stl.tags
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"] " ????
set completeopt-=preview

" " TAGBAR  stuff "
nmap <F7> :TagbarToggle<CR>

" " NERDTree stuff "
map <F6> :NERDTreeToggle<CR>

" " PYFLAKES stuff "
let g:pyflakes_use_quickfix = 1

" map space to toggle folding
nnoremap <space> za
vnoremap <space> zf

" Shift-Arrow for easier window navigation
nnoremap <S-Left> <C-W>h
nnoremap <S-Right> <C-W>l
nnoremap <S-Up> \<C-W>k
nnoremap <S-Down> \<C-W>j

" Shift-Tab to unindent
nnoremap <Tab> >>
nnoremap <S-Tab> <<
inoremap <S-Tab> <C-D>
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" "                         INDENTATION OPTIONS                            " "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" when TAB is pressed, insert the appropriate amount of spaces (which is 2!)
set expandtab
set shiftwidth=2
set tabstop=2 " TODO: could this stay at 8?

" make TAB and BS work on whole indentation levels (not single spaces/tabs)
set smarttab " TODO: see cindent

" enable "smart" and "automatic" indentation
set smartindent
set autoindent

" F12 toggles between paste mode and nopaste
set pastetoggle=<F12>

" backspacing: allow BS-ing across line breaks, beggining of insert etc.
set backspace=indent,eol,start

" c indent option: indent using 1 shiftwidth
set cinoptions=>1s 

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" "                           SEARCH OPTIONS                               " "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" do case insensitive matching ... unless when search pattern contains
" upper case letters
set ignorecase
set smartcase

" incremental (as you type) search
set incsearch

" center display after searching
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#z

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" "                       APPEARANCE OPTIONS                               " "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" for xterm 256-color support, create the following files:
" ~/.Xdefaults 
"     customization: -color
"     XTerm*termName:  xterm-256color
" ~/.xsession
"     if [ -f $HOME/.Xdefaults ]; then
"       xrdb -merge $HOME/.Xdefaults
"     fi
"for gnome-terminal etc, just override $TERM (see ./bashrc_vim.sh)
"set t_Co=256  " sometimes helps on term's without correct $TERM set
"colorscheme lucius
colorscheme evening

" enable syntax highlighting by default
syntax on

" set default background back to NONE (to allow transparent bg)
hi Normal ctermbg=NONE

" enable highlighting of search term
set hlsearch

" always show curser position in status line
" set ruler "unnecessary with powerline

" show line numbers
set number

" show (partial) command in status line
set showcmd

" show matching brackets
set showmatch

" enable "cross-hair" cursor highlight
set cursorcolumn
set cursorline
" highlight columns 80 & 120
"set colorcolumn=80,120

" Resize splits when the window is resized
au VimResized * exe "normal! \<c-w>="

" enable powerline's fancy symbols
let g:Powerline_symbols = 'fancy'
" and have it always show
set laststatus=2

" tell indent guides plugin to compute indent colors, set default colors
if has('gui_running')
  let g:indent_guides_auto_colors = 1
  set guioptions-=T  " no toolbar
  set guifont=Ubuntu\ Mono\ 12
else
  let g:indent_guides_auto_colors = 0
endif
  
let g:indent_guides_enable_on_vim_startup = 1

autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=gray7 ctermbg=233
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=gray11 ctermbg=234
hi VertSplit cterm=bold ctermfg=22 ctermbg=148 gui=bold guifg=#005f00 guibg=#afd700
hi ColorColumn term=reverse ctermbg=233 guibg=#484038

" " let g:indent_guides_default_ctermbg_colors = [234, 235]
" " 
" " " hack to register a function overriding indent_guides' behavior
" " function! OverrideIndentGuidesFunction ()
" "   function! indent_guides#basic_highlight_colors()
" "     if exists('g:indent_guides_default_ctermbg_colors')
" "       let l:cterm_colors = g:indent_guides_default_ctermbg_colors
" "     else
" "       let l:cterm_colors = (&g:background == 'dark') ? ['darkgrey', 'black'] : ['lightgrey', 'white']
" "     endif
" "     let l:gui_colors   = (&g:background == 'dark') ? ['grey15', 'grey30']  : ['grey70', 'grey85']
" "   
" "     exe 'hi IndentGuidesEven guibg=' . l:gui_colors[0] . ' ctermbg=' . l:cterm_colors[0]
" "     exe 'hi IndentGuidesOdd  guibg=' . l:gui_colors[1] . ' ctermbg=' . l:cterm_colors[1]
" "   endfunction
" " endfunction
" " 
" " " register hook to override basic_highlight_colors after plugins are loaded
" " autocmd VimEnter * :call OverrideIndentGuidesFunction()


""""""""""""""""""""""""""""""""""""""
" double check the rest of this file "
""""""""""""""""""""""""""""""""""""""


" " ?
" let g:bufExplorerWidth = 50
" let g:winManagerWindowLayout = "FileExplorer"
" 
" " NERD_tree stuff
" let g:NERDTreeMapActivateNode = '<CR>'
" let g:NERDTreeMapCloseDir = '-'
" let g:NERDTreeMapCloseChildren = '<BS>'
" let g:NERDTreeSortOrder = [ '\/$', '\.asd', '\.nsp', '\.lisp', '\.h$\|\.hpp$\|\.hh$', '\.c$\|\.cc$\|\.cpp$\|\.cxx$', '*' ]

