"vi:syntax=vim



"SETUP:

set foldenable
set foldmethod=marker
set modeline
set nohlsearch
set directory^=$XDG_CONFIG_HOME/nvim/tmp//
set nowrap
set tabstop=4
set shiftwidth=4
set expandtab
set smartindent
set autoindent

set hidden
set history=200
set showmatch 

set number relativenumber
set nu rnu


set nocompatible "Useless because if user vimrc is loaded it is set automaticaly

set <F11>=[23~
let mapleader="\<F11>"


set bg=light
syntax enable

filetype indent on
filetype plugin on

" LATEX SETUP:
let g:tex_flavor='latex'
let g:vimtex_compiler_progname = 'pdflatex'
let g:vimtex_view_general_viewer = 'zathura'
let g:vimtex_latexmk_options = '-pdf -shell-escape -verbose -file-line-error -synctex=1 -interaction=nonstopmode'



" FINDING FILES:

set path+=**
set wildmenu


" TAG JUMPING:
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


"AUTOCOMPLETION:
set wildmode=longest,list,full



"FILE SPECIFIC THINGS:
set <F5>=[15~
autocmd Filetype rmd map <F5> :w <bar> !echo<space>"require(rmarkdown);<space>render('<c-r>%')"<space>\|<space>R<space>--vanilla 
autocmd Filetype sh  call SetShOptions()
autocmd Filetype py  map <F5> :exec '!python' shellescape(@%, 1) <CR>
autocmd Filetype tex call SetTexOptions()
autocmd Filetype cpp call SetCppOptions() 
autocmd Filetype c call SetCOptions()
autocmd Filetype h call SetCOptions()

"FILE TYPE FUNTIOINS:

function! SetShOptions()
    map <F5> :w <bar> !%:p <CR>
    let g:sh_fold_enabled=5
    let g:is_bash=1
    set foldmethod=syntax
endfunction


function! SetCOptions()
    call SetCppOptions()
endfunction

function SetTexOptions()
    inoremap ,l <CR>\item<Space>
endfunction

function SetCppOptions()
    "Set brackets like vscode
    inoremap <expr> ( ConditionalPairMap('(', ')')
    inoremap <expr> { ConditionalPairMap('{', '}')
    inoremap <expr> [ ConditionalPairMap('[', ']')
    inoremap <expr> < ConditionalPairMap('<', '>')
    inoremap <expr> \" ConditionalPairMap('\"', '\"')
    inoremap ' ''<left>
    
    "close bracket if no pair is fond on the right side of curser. If found jump over
    inoremap ) <c-r>=ClosePair(')')<CR>
    inoremap ] <c-r>=ClosePair(']')<CR>
    inoremap } <c-r>=CloseBracket()<CR>
    inoremap " <c-r>=QuoteDelim('"')<CR>
    inoremap ' <c-r>=QuoteDelim("'")<CR>

    "open curly brackets if pressed enter between. like vscode
    inoremap <expr> <CR> getline(".")[col(".")-2:col(".")-1]=="{}" ? "<cr><esc>O" : "<CR>"
    
    "use tab to move in autocomplete
    inoremap <expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
    inoremap <expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<TAB>"
    
    " Insert comments markers
    map - :s/^/\/\//<CR>:nohlsearch<CR>
    
    " formatting:
    set formatprg=astyle\ -T4p
endfunction


"BRACKETS PARENTHESIS QUOTATION MARKS:
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




" AUTO UNCOMMENT:
" Clear all comment markers (one rule for all languages)
map _ :s/^\/\/\\|^--\\|^> \\|^[#"%!;]//<CR>:nohlsearch<CR>



"OPEN NEW BUFFERS ON THE RIGHT OR BOTTOM:
  set splitbelow splitright


" STATUSBAR:
hi StatusLine ctermfg=Black ctermbg=White
set laststatus=0



" ENCAPSULATE TEXT:
:vnoremap _( <Esc>`>a)<Esc>`<i(<Esc>



" COPY PASTE CLIPBOARD:
map <C-p> "+p
map <C-y> "+y



" DISABLE AUTOMATIC COMENTING ON NEW LINE:
   autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o


" SPELLCHECK:
  map <leader>o :setlocal spell! spelllang=de_de<CR>
  map <leader>p :setlocal spell! spelllang=en_us<CR>
  map <leader>ü :setlocal spell! spelllang=fr<CR> 

"GRAMMAR:
:nmap <leader>f (grammarous-move-to-next-error)
:nmap <leader>a (grammarous-move-to-previous-error)
:nmap <leader>w (grammarous-fixit)
:nmap <leader>e (grammarous-remove-error)
:nmap <leader><CR> (grammarous-move-to-info-window)


" RELOAD VIMRC:
  map <leader>s :so $MYVIMRC<CR>


" NERDTREE:
  map <leader>n :NERDTreeToggle<CR>
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
  

"TOGGLE LINE NUBMERS:
  map <leader>x :set relativenumber!<CR>
  

" STOP HIGHLIGTING:
nnoremap <leader> <Esc> :nohlsearch<Bar>:echo<CR>

" Switch to second file
nnoremap <Leader><Leader> :e#<CR> 



" FIND PLACEHOLDER:
map <Leader><Tab> <Esc>/<++><CR>ca<
" ATP_vim
let g:atp_Compiler='bash'

" CODE FOLDS:
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent! loadview

" LIST TODOS:
nmap ,t :vimgrep /\<TODO\>/j **/*.* <BAR> :cope <CR>


" non underlined CurserLineNr
hi CursorLineNr cterm=none

" spell correction layout
  hi clear spellBad
  hi Spellbad cterm=underline


nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
