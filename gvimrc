set colorcolumn=80
set relativenumber
set cursorline

set fuopt=maxvert,maxhorz

set guioptions=egmrt

set background=dark
colorscheme solarized

nnoremap <F4> :call ToggleLineNumberFormat()<CR>
function! ToggleLineNumberFormat()
  if &relativenumber
    set number
    echo "Absolute line numbers enabled"
  else
    set relativenumber
    echo "Relative line numbers enabled"
  endif
endfunction

set guifont=Anonymice\ Powerline:h14
