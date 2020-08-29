let maplocalleader = ','
call plug#begin('/home/lars/.config/nvim/plugged')
"Plug 'ycm-core/YouCompleteMe',{'for': ['h','cpp','hpp','header']}
"Plug 'SirVer/ultisnips'
Plug 'derekwyatt/vim-fswitch'
"Plug 'kien/ctrlp.vim'
"Plug 'tpope/vim-obsession'
"Plug 'dhruvasagar/vim-prosession'
"Plug 'gikmx/vim-ctrlposession'
"Plug '/home/lars/.vim/plugged/junegunn/goyo.vim'
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'jreybert/vimagit'
Plug 'LukeSmithxyz/vimling'
"Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'
"Plug 'powerline/powerline'
"Plug 'vimwiki/vimwiki'
"Plug 'terryma/vim-multiple-cursors'
Plug 'scrooloose/nerdtree' 
"Plug 'coot/atp_vim'
Plug 'lervag/vimtex'
Plug 'baskerville/vim-sxhkdrc'
Plug 'gerw/vim-latex-suite'
Plug 'rhysd/vim-grammarous'
Plug 'dpelle/vim-LanguageTool'
Plug 'vuciv/vim-bujo'
Plug 'terryma/vim-multiple-cursors'
call plug#end()

source /home/lars/.config/nvim/subrc.vim
"autocmd VimEnter :AirlineToggle <CR>
