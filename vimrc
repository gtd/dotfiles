filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
filetype plugin indent on

syntax on

set nocompatible
set modelines=0
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set encoding=utf-8
set scrolloff=3
set autoindent
set showmode
set showcmd
set nohidden
set bufhidden=wipe
set wildmenu
set wildmode=list:longest
set visualbell
set ttyfast
set ruler
set backspace=indent,eol,start
set laststatus=2
set history=1000
set undolevels=1000
set nobackup
set noswapfile
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch
set wrap
set textwidth=80
set formatoptions=qrn1
set list
set listchars=tab:▸\ ,eol:¬
set wildignore=tmp/**

" turn on powerline
"set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim

let mapleader = ","

nnoremap <leader>t :CtrlP<cr>
nnoremap <leader>b :CtrlPBuffer<cr>
nnoremap <leader><space> :noh<cr>
nnoremap <F2> :NERDTreeMirror<cr>
nnoremap <F3> :NERDTreeToggle<cr>
nnoremap <leader>r :NERDTreeFind<cr>
nnoremap <tab> %
vnoremap <tab> %

nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> :tabprevious<cr>
nnoremap <right> :tabnext<cr>

nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

nnoremap <Space> @q

vnoremap <leader>s d:execute 'normal i' . join(sort(split(getreg('"'))), ' ')<CR>
nnoremap <leader>s :call setline('.', join(sort(split(getline('.'), ' ')), " "))<CR>

au BufRead,BufNewFile *.thor set filetype=ruby

" vim-airline config
let g:airline_powerline_fonts = 1 " See font setting in .gvimrc
let g:airline_section_x = '%{airline#util#wrap(airline#parts#filetype(),0)} #%{bufnr(''%'')}'

" Macros
let @h="/:\\w\\+\\s\\+=>\rxt a:ldf>" " Convert old-style Ruby hash key to 1.9-style
let @p="o[#]" " Insert a Pivotal story git commit message hook (can't paste from system clipboard in terminal vim though)

" Reload .vimrc on write automatically
au! BufWritePost .vimrc source %
