set exrc
set nocompatible
set nowrap
set bs=2		" allow backspacing over everything in insert mode
set ai			" always set autoindenting on
set backup		" keep a backup file
set backupdir=~/tmp
set viminfo='20,\"50	" read/write a .viminfo file, don't store more
			" than 50 lines of registers
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time

set shiftwidth=4
set tabstop=4

set statusline=%-3.30([%F]%)%(%r%m%h%w%y%)%=[off\ %o][line\ %l\/%L][col\ %c][buf\ %n][%P]
set wildignore=*.o,*.obj,*.bak

set hidden
set foldclose=all
set foldmethod=marker
set foldcolumn=2
set foldtext=v:folddashes.substitute(getline(v:foldstart),'/\\*\\\|\\*/\\\|{{{\\d\\=','','g')
set fillchars=fold:\ 
" hi Folded ctermbg=black ctermfg=green
" hi FoldColumn ctermbg=black ctermfg=green
colorscheme diablo3

"
" menu
"let did_install_default_menus = 1
"let did_install_syntax_menu = 1
"set guioptions-=T

if has('gui_running')
	set guifont=Monospace\ 9
"	:amenu Tools.-Sep- :
"	:amenu Tools.Indent.Increase\ indent\ for\ block >i{
"	:amenu Tools.Indent.Decrease\ indent\ for\ block <i{
"	:amenu Tools.Indent.Reformat\ block =a{
endif

"if has('gui_running')
":amenu icon=/usr/share/pixmaps/nautilus/Bluecurve/gnome-text-html.png 1.271 ToolBar.Doxygen :!doxygen Doxyfile<CR>
"endif

set showcmd
set showmatch

"
" kolory podswietlania
"hi StatusLine ctermbg=Yellow ctermfg=LightBlue
"hi StatusLineNC ctermbg=LightBlue ctermfg=White
"hi LineNr ctermfg=darkblue ctermbg=black

set laststatus=2
set notagbsearch
"set wildmenu
syntax on
filetype plugin on
filetype indent on
set nohlsearch
set incsearch
set ignorecase
set smartcase

"
" ustawienia pluginu netrw
let g:netrw_ftp = 0

"
" ustawienia pluginu dbext
let g:dbext_default_profile_MySQL_oscommerce = 'type=MYSQL:user=pawel:passwd=pawel:dbname=oscommerce:host=127.0.0.1'

"
" ustawienia pluginu latex-suite
let Tex_FoldedEnvironments = "figure,table"
let Tex_FoldedMisc = "preamble"
let Tex_Folding = "0"

"
" ustawienia pluginu vimspell
"let spell_executable = "aspell"
"let spell_language_list = "english"
"let spell_auto_type = ""

"
" ustawienia pluginu csupport
let g:C_AuthorName = "Pawel Stolowski"
let g:C_AuthorRef = ""
let g:C_Email = "pawel.stolowski@wp.pl"
let g:C_Company = ""
let g:C_Template_Directory = $HOME."/.vim/plugin/templates-my/"

"
" ustawienia pluginu perlsupport
let g:Perl_Template_Directory  = $HOME.".vim/plugin/templates-my/"


"
" zmiana bufora
nmap <TAB> :bnext<CR>

"
" skok o wyraz w przod/tyl
imap <C-w> <ESC><Right>wi
imap <C-b> <ESC><Right>bi

nmap <F2> :wall<CR>
imap <F2> <ESC>:wall<CR>
map <F7> :w!<CR>:!aspell -c --lang pl %<CR>:e! %<CR>
nmap <F9> :make<CR>
imap <F9> <ESC>:make<CR> 
"nnoremap <silent> <S-F12> :BufExplorer<CR>
"imap <S-F10> <ESC>:buffers<CR>
map <F3> :BufExplorer<CR>
imap <F3> <ESC>:BufExplorer<CR>
imap <F11> <ESC>:set invnumber<CR>a
map <F11> :set invnumber<CR>
map <S-F10> :reg<CR>
imap <S-F10> <ESC>:reg<CR>
nnoremap <silent> <F12> :Tlist<CR>
let Tlist_WinWidth = 35

"
" cscope
"map <C-_> :cstag <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-_>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-_>d :cs find d <C-R>=expand("<cword>")<CR><CR>

set grepprg=ack-grep\ --cpp\ --cc\ --perl\ --python\ --make 
"
" grep word under cursor
:nmap _g :grep <C-R>=expand("<cword>")<CR><CR>
:nmap _a :grepadd <C-R>=expand("<cword>")<CR><CR>

"
" plugin win_full_screen
map \\ :WinFullScreen<ENTER>
imap \\ <ESC>:WinFullScreen<ENTER>i

"
" klawisze pluginu winmanager
"nnoremap <silent> <F12> :WMToggle<CR>
"map <c-w><c-b> :BottomExplorerWindow<cr>
"map <c-w><c-f> :FirstExplorerWindow<cr>
"map <c-w><c-t> :WMToggle<cr>

source $VIMRUNTIME/ftplugin/man.vim

" Don't use Ex mode, use Q for formatting
map Q gq

" Make p in Visual mode replace the selected text with the "" register.
vnoremap p <Esc>:let current_reg = @"<CR>gvdi<C-R>=current_reg<CR><Esc>

augroup cprog
" Remove all cprog autocommands
au!

" When starting to edit a file:
"   For C and C++ files set formatting of comments and set C-indenting on.
"   For other files switch it off.
"autocmd FileType * set formatoptions=tcql nocindent comments&
autocmd FileType tex set tw=110
"autocmd FileType c,cpp,cc  set formatoptions=croql cindent comments=sr:/*,mb:*,el:*/,://
autocmd BufRead *.txt set tw=78
autocmd BufNewFile *.html 0r ~/.vim/template/templ.html
autocmd BufNewFile *.tex 0r ~/.vim/template/templ.tex
"autocmd BufNewFile *.h 0r ~/.vim/template/templ.h
"autocmd BufNewFile *.c 0r ~/.vim/template/templ.c
"autocmd BufNewFile *.cpp 0r ~/.vim/template/templ.cpp
autocmd BufNewFile *.sh 0r ~/.vim/template/templ.sh
autocmd BufNewFile *.pl 0r ~/.vim/template/templ.pl
autocmd BufNewFile *.py 0r ~/.vim/template/templ.py
autocmd BufNewFile *.spec 0r ~/.vim/template/templ.spec
autocmd BufWinLeave *.{htm*,pas,c,cc,cpp,pl,sh,txt,conf} mkview
autocmd BufWinEnter *.{htm*,pas,c,cc,cpp,pl,sh,txt,conf} silent loadview
augroup END

