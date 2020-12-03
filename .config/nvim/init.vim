let maplocalleader = ','
call plug#begin('/home/lars/.config/nvim/plugged')

"Plug 'ycm-core/YouCompleteMe',{'for': ['h','cpp','hpp','header']}
Plug 'derekwyatt/vim-fswitch' " switch between h and c/cpp
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'jreybert/vimagit'
Plug 'scrooloose/nerdtree'  " explorer
Plug 'lervag/vimtex' " used for compiling
Plug 'baskerville/vim-sxhkdrc' " for sxhkdrc    
Plug 'gerw/vim-latex-suite' " for latex completion
Plug 'rhysd/vim-grammarous' " spell check + grammat test which better
Plug 'dpelle/vim-LanguageTool' "spell check + grammar
call plug#end()

source /home/lars/.config/nvim/subrc.vim
