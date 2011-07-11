:set nocompatible
:colorscheme diablo3
:set hidden
:set textwidth=160
:set tabstop=4
:set shiftwidth=4
:set expandtab
:set statusline=%<%f%=\ [%1*%M%*\ buf:%n%R%H]\ %-18(%l,%c\ %3p%%%)
:set laststatus=2
:set mouse=a
:set nowrap
:set ignorecase
:set smartcase
:set hlsearch
:set incsearch
:set cindent
:set wildmenu
:set guioptions=amgic
:set complete-=i
:set omnifunc=syntaxcomplete#Complete
:set number
:set path=.,~/adtech/build/**,/usr/include,,
:hi CursorLine ctermbg=darkgrey ctermfg=white guibg=grey37 guifg=white
:set guifont=Droid\ Sans\ Mono\ 10
" :set cursorline
:set tags=./tags.tags,/home/pawel/adtech/build/tags
let NERDTreeIgnore=['\.vim$', '\~$', '\.o$', '^\.']
let NERDTreeWinPos="right"

let Tlist_Show_One_File=1

if filereadable("cscope.out")
    cs add cscope.out
elseif $CSCOPE_DB != ""
    cs add $CSCOPE_DB
endif

" otwieranie wynikow cscope w oknie quickfix
:set cscopequickfix=s-,c-,d-,i-,t-,e-
:set cscopetag

command UpdateHelp helptags ~/.vim/doc
command VimRc edit ~/.vimrc

nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>

nmap \t :FufTag<CR>
nmap \f :FufFile<CR>
nmap \F :FufCoverageFile<CR>
nmap \b :FufBuffer<CR>

nmap <F1> <ESC>:Bstoc<CR>

:imap <F2> <ESC>:update<CR>
:imap <F3> <ESC>:BufExplorer<CR>
:imap <F4> <ESC>:NERDTreeToggle<CR>
:map <F3> :BufExplorer<CR>
:map <F4> :NERDTreeToggle<CR>
:map <F12> :TlistToggle<CR>
":map <F12> :TagbarToggle<CR>

:map <F2> :update<CR>
:map <F5> :cprev<CR>
:map <F6> :cnext<CR>
:map <F7> :botright cwindow<CR>
:map <F8> :colder<CR>
:map <F9> :cnewer<CR>

:noremap <C-left> :bprev<CR> 
:noremap <C-right> :bnext<CR> 

:let VCSCommandMapPrefix='<Leader>v'

set grepprg=ack-grep\ --cpp\ --cc\ --perl\ --python\ --make 
"
" grep word under cursor
:nmap _g :grep <C-R>=expand("<cword>")<CR><CR>
:nmap _a :grepadd <C-R>=expand("<cword>")<CR><CR>

"
" moje menu
:amenu Devel.Grep\ current\ dir :grep <C-R>=expand("<cword>")<CR><CR>
:amenu Devel.Grep\ file\ dir :grep <C-R>=expand(expand("<cword>") . " " . expand("%:h"))<CR><CR>
:amenu Devel.Grep\ adtech\ dir :grep <C-R>=expand(expand("<cword>") . " " . expand("~/adtech/build"))<CR><CR>

