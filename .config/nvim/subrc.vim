
filetype plugin indent on

set foldenable

set foldmethod=marker

au FileType sh let g:sh_fold_enabled=5

au FileType sh let g:is_bash=1

au FileType sh set foldmethod=syntax

syntax enable



set modeline

set nocompatible
set <F11>=[23~
let mapleader="\<F11>"
"Basics
""let g:ycm_confirm_extra_conf = 1
"let g:ycm_global_ycm_extra_conf = "$HOME/.vim/plugged/YouCompleteMe/.ycm_extra_conf.py"
let g:tex_flavor='latex'
nnoremap <SPACE> <Nop>
set clipboard=
set bg=light
set nohlsearch
set directory^=$XDG_CONFIG_HOME/nvim/tmp//

syntax enable

filetype indent on
filetype plugin on

set nowrap
set tabstop=4
set shiftwidth=4
set expandtab
set smartindent
set autoindent

set hidden
set history=200
set hlsearch
set showmatch 

set number relativenumber
set nu rnu




let g:vimtex_compiler_progname = 'pdflatex'
let g:vimtex_view_general_viewer = 'zathura'
" FINDING FILES:

set path+=**
set wildmenu

" TAG JUMPING:
set nocp
filetype plugin on
command! CppTags !ctags -R --c++-kinds=+p --fields=+iaS --extras=+q .<CR><CR>
command! MakeTags !ctags -R .
set tags=~/.config/nvim/stdtags,tags,.tags,../tags
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
" SNIPPETS:
nnoremap ,art :-1read $HOME/.config/nvim/snippets/latex_art.tex<CR>a
nnoremap ,bea :-1read $HOME/.config/nvim/snippets/latex_bea.tex<CR>a
nnoremap ,ett :-1read $HOME/.config/nvim/snippets/latex_let.tex<CR>a
nnoremap ,pm a \begin{pmatrix}\end{pmatrix}<ESC>F}a
nnoremap ,bm a \begin{bmatrix}\end{bmatrix}<ESC>F}a
" FORCE SUDO WRITE:
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!
"autocompletion
"set wildmode=longest,list,full

"Set <F5> filesspecific
set <F5>=[15~
autocmd Filetype rmd map <F5> :w <bar> !echo<space>"require(rmarkdown);<space>render('<c-r>%')"<space>\|<space>R<space>--vanilla 
autocmd Filetype sh  map <F5> :w <bar> !%:p <CR>
autocmd Filetype py  map <F5> :exec '!python' shellescape(@%, 1) <CR>
autocmd Filetype tex call SetTexOptions()
autocmd Filetype cpp call SetCppOptions() 
autocmd Filetype c call SetCOptions()
autocmd Filetype h call SetCOptions()

" Auto comment:

" Clear all comment markers (one rule for all languages)
map _ :s/^\/\/\\|^--\\|^> \\|^[#"%!;]//<CR>:nohlsearch<CR>

function! SetCOptions()
    call SetCppOptions()
  " Insert comments markers
  map - :s/^/\/\//<CR>:nohlsearch<CR>
endfunction




"splits open at the bottom and right, which is non-retarded, unlike vim defaults.
  set splitbelow splitright

" Autocmd functions
function SetCppOptions()
    inoremap <expr> ( ConditionalPairMap('(', ')')
    inoremap <expr> { ConditionalPairMap('{', '}')
    inoremap <expr> [ ConditionalPairMap('[', ']')
    inoremap <expr> [ ConditionalPairMap('<', '>')
    inoremap \" \""<left>
    inoremap ' ''<left>
    
    inoremap ) <c-r>=ClosePair(')')<CR>
    inoremap ] <c-r>=ClosePair(']')<CR>
    inoremap } <c-r>=CloseBracket()<CR>
    inoremap " <c-r>=QuoteDelim('"')<CR>
    inoremap ' <c-r>=QuoteDelim("'")<CR>
endfunction

function! ConditionalPairMap(open, close)
    let line = getline('.')
    let col = col('.')
    if col < col('$') || stridx(line, a:close, col + 1) != -1
        return a:open
    else
        return a:open . a:close . repeat("\<left>", len(a:close))
    endif
    endf
    function ClosePair(char)
        if getline('.')[col('.') - 1] == a:char
            return "\<Right>"
        else
            return a:char
        endif
    endf
    function CloseBracket()
        if match(getline(line('.') + 1), '\s*}') < 0
            return "\<CR>}"
        else
            return "\<Esc>j0f}a"
        endif
    endf

    function QuoteDelim(char)
        let line = getline('.')
        let col = col('.')
        if line[col - 2] == "\\"
            "Inserting a quoted quotation mark into the string
            return a:char
        elseif line[col - 1] == a:char
            "Escaping out of the string
            return "\<Right>"
         else
            "Starting a string
            return a:char.a:char."\<Esc>i"
        endif
        endf
function SetTexOptions()
    map <F5> :w <bar> !pdflatex %:t <CR><CR>
    inoremap ,l <CR>\item<Space>
endfunction

" Statusbar:
hi StatusLine ctermfg=Black ctermbg=White
set laststatus=0

" Parenthesies:

:vnoremap _( <Esc>`>a)<Esc>`<i(<Esc>

" COPY PASTE CLIPBOARD:
map <C-p> "+p
map <C-y> "+y

" Disables automatic commenting on newline:
   autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

"Goyo plugin makes text more readable when writing prose:
"  map <leader>f :Goyo \| set bg=light \| set linebreak<CR>

" Spell-check set to <leader>o, 'o' for 'orthography':
  map <leader>o :setlocal spell! spelllang=de_de<CR>
  map <leader>p :setlocal spell! spelllang=en_us<CR>
  map <leader>ü :setlocal spell! spelllang=fr<CR> 

"GRAMMAR:
:nmap <leader>f (grammarous-move-to-next-error)
:nmap <leader>a (grammarous-move-to-previous-error)
:nmap <leader>w (grammarous-fixit)
:nmap <leader>e (grammarous-remove-error)
:nmap <leader><CR> (grammarous-move-to-info-window)


" reload .vimrc
  map <leader>s :so $MYVIMRC<CR>


" Nerd tree
  map <leader>n :NERDTreeToggle<CR>
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
  
"toggle line numbers 
  map <leader>x :set relativenumber!<CR>
  
" set highlit to visible
nnoremap <leader> <Esc> :nohlsearch<Bar>:echo<CR>

" Switch to second file
nnoremap <Leader><Leader> :e#<CR> 

"map <Tab><Tab> <Esc>/<++><CR>ca<
" ATP_vim
let g:atp_Compiler='bash'

" CODE FOLDS:
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent! loadview

" TODO MANAGER
nmap <A-x> <Plug>BujoAddnormal
imap <A-x> <Plug>BujoAddinsert
nmap <C-x> <Plug>BujoChecknormal
imap <C-x> <Plug>BujoCheckinsert

" LIST TODOS:
nmap ,t :vimgrep /\<TODO\>/j **/*.* <BAR> :cope <CR>

" vimling:
	nm <leader>d :call ToggleDeadKeys()<CR>
	imap <leader>d <esc>:call ToggleDeadKeys()<CR>a
	nm <leader>i :call ToggleIPA()<CR>
	imap <leader>i <esc>:call ToggleIPA()<CR>a
	nm <leader>q :call ToggleProse()<CR>

" non underlined CurserLineNr
hi CursorLineNr cterm=none
" spell correction layout
  hi clear spellBad
  hi Spellbad cterm=underline


nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
