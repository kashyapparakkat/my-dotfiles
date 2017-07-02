noremap q :q<cr>
" next/prev buffer
noremap e <C-w><C-w>
noremap <C-k> :bp<CR>
noremap <C-l> :bn<CR>
noremap <leader>f :Ranger<CR>

noremap <F7> :vsplit<CR>
"noremap ,r :! C:/cygwin64/bin/python3.6m.exe C:/cygwin64/bin/ranger<CR>
noremap r :! C:/cygwin64/bin/python3.6m.exe C:/cygwin64/bin/ranger<CR>


" C-w s/v split
" C- c/o close current/all except current
" :e filename
" :b filen <TAB> 
"


"accelerated motion
:noremap <M-j> 4j
:noremap <M-k> 4k


function RangerExplorer()
    exec "silent !ranger --choosefile=/tmp/vim_ranger_current_file " . expand("%:p:h")
    if filereadable('/tmp/vim_ranger_current_file')
        exec 'edit ' . system('cat /tmp/vim_ranger_current_file')
        call system('rm /tmp/vim_ranger_current_file')
    endif
    redraw!
endfun
map w :call RangerExplorer()<CR>
map <leader>b :CtrlPBuffer
nnoremap ; :
" nnoremap : ;


" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'

Plug 'https://github.com/kien/ctrlp.vim.git'
" Initialize plugin system
call plug#end()
