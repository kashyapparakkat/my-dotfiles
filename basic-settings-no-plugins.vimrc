noremap gl G
noremap q :q<cr>
" next/prev buffer
noremap e <C-w><C-w>
noremap <C-o> :bp<CR>
noremap <C-l> :bn<CR>

noremap <C-j> <PageDown><CR>
noremap <C-k> <PageUp><CR>
noremap gl G
noremap <leader>f :Ranger<CR>

 
noremap b :CtrlPMixed<CR>
noremap <C-x>b :CtrlP<CR>
" Press <c-f> and <c-b> to cycle between modes.

 

noremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>



noremap <C-l> <C-w>v:ConqueTerm bash<CR>
" open a file"
noremap <F7> :tabe %:p:h<CR>
noremap <F7> <C-w>v<C-w>l<CR>

"noremap ,r :! C:/cygwin64/bin/python3.6m.exe C:/cygwin64/bin/ranger<CR>

"  %:p to get the full path to the current file."
"  :~: Get the file path relative to the home directory (this one didn't work for me for some reason)
"  :.: Get the file path relative to the current directory (% default)
"  :r: File name root. The name of the file without the extension.
"  :e: File's extension.
"  :h: Split on / and return the left half (i.e. if I'm editing a file in a path of /tmp/test.txt and run %:p:h will return /tmp
"  :t: Split on / and return the right half (i.e. if I'm editing a file in a path of /tmp/test.txt and run %:p:t will return text.txt


noremap od :silent !~/my-scripts/open_explorer.sh "$(~/my-scripts/convert_path_to_windows.sh %:p)"<CR>
noremap oe :silent !~/my-scripts/emacs.sh "$(~/my-scripts/convert_path_to_windows.sh %:p)"<CR>
noremap os :silent !~/my-scripts/sublime_text.sh "$(~/my-scripts/convert_path_to_windows.sh %:p)"<CR>
noremap on :silent !~/my-scripts/npp.sh "$(~/my-scripts/convert_path_to_windows.sh %:p)"<CR>
noremap ol :silent !less "$(~/my-scripts/convert_path_to_windows.sh %:p)"<CR>
noremap or :! C:/cygwin64/bin/python3.6m.exe C:/cygwin64/bin/ranger --selectfile=%:p<CR>
" --choosedir=%:p:h"


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

" open in less"
nnoremap c :exe ':silent !less %'<CR>
