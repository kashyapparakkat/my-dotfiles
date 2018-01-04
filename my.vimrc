" source ~/my.vimrc
source ~/basic-settings-no-plugins.vimrc






":oldfiles

" TODO"
"http://vim.wikia.com/wiki/Faster_loading_of_large_files

" open each buffer in its own tabpage, add this to your vimrc:
" may freeze also
:au BufAdd,BufNewFile * nested tab sball

" line numbers; lags
" set number

"enable number and relativenumber at the same time,
:set number relativenumber

" :set nonumber  " turn line numbers off

:set relativenumber
" TIP: Typing 5j will move the cursor five lines down
set cursorline




" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes
" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'hecal3/vim-leader-guide'
Plug 'junegunn/vim-easy-align'
Plug 'roman/golden-ratio'
" Plug 'junegunn/vader.vim'
Plug 'vim-scripts/ag.vim'
" shell inside vi
Plug 'wkentaro/conque.vim'
Plug 'https://github.com/kien/ctrlp.vim.git'
Plug 'junegunn/fzf.vim'
Plug 'hecal3/vim-leader-guide'
Plug 'francoiscabrol/ranger.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'airblade/vim-gitgutter'
" Initialize plugin system
call plug#end()
" use :PlugInstall from vim to install one time"

set title
" set titlestring=%t%(\ %M%)%(\ (%{expand(\"%:p:h\")})%)%(\ %a%)\ -\ %{v:servername}
set titlestring=vim:\ %{expand(\"%:p:h\")}/%t

set laststatus=2            " always a status line
set incsearch
set ignorecase
set smartcase
set showcmd
set scrolloff=4 		"offset


:let mapleader = ","

"#"suppose  leader is space
"nnoremap <silent> <leader> :<c-u>LeaderGuide '<Space>'<CR>
"vnoremap <silent> <leader> :<c-u>LeaderGuideVisual '<Space>'<CR>
autocmd FileType gitcommit  noremap <buffer> <leader> <Plug>leaderguide-buffer
" for fugitive

autocmd BufEnter __Tagbar__  noremap <buffer> <leader> <Plug>leaderguide-buffer
" for tagbar


" http://vim.wikia.com/wiki/Accessing_the_system_clipboard
" Note: in vim 7.3.74 and higher you can set clipboard=unnamedplus to alias unnamed register to the + register, which is the X Window clipboard.
set clipboard=unnamed

colorscheme elflord








" TODO
" https://github.com/junegunn/fzf/wiki/Examples-(vim)

command! -nargs=1 -bang Locate call fzf#run(fzf#wrap(
      \ {'source': 'locate <q-args>', 'options': '-m'}, <bang>0))


" fuzzy search files in parent directory of current file
" This command is very handy if you want to explore or edit the surrounding/neigbouring files of the file your currently editing. (e.g. files in the same directory)

function! s:fzf_neighbouring_files()
  let current_file =expand("%")
  let cwd = fnamemodify(current_file, ':p:h')
  "let command = 'ag -g "" -f ' . cwd . ' --depth 0'
  let command = 'ag <q-args>"" -G *.sh --depth 0'

  call fzf#run({
        \ 'source': command,
        \ 'sink':   'e',
        \ 'options': '-m -x +s',
        \ 'window':  'enew' })
endfunction

command! FZFNeigh call s:fzf_neighbouring_files()

" https://medium.com/@crashybang/supercharge-vim-with-fzf-and-ripgrep-d4661fc853d2
" :Find term where term is the string you want to search, this will open up a window similar to :Files but will only list files that contain the term searched."
command! -bang -nargs=* Find call fzf#vim#grep('ag --no-heading '.shellescape(<q-args>), 1, <bang>0)

command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, '--color-path "1;36"', fzf#vim#with_preview(), <bang>0)







" search
" https://stackoverflow.com/questions/12904490/limit-a-grep-search-in-vim-to-files-with-the-same-extension-as-the-current-file
" map st :grep -r --include='*.<C-R>=expand('%:e')<CR>' '<C-R><C-W>' ./<CR><CR>:cw<CR>
"  expand('%:e')=extension;    <C-R><C-W>" = current word;
noremap str :grep  '<C-R><C-W>' *.<C-R>=expand('%:e')<CR> -r --color=always
noremap sth :grep  '<C-R><C-W>' *.<C-R>=expand('%:e')<CR> --color=always


if &diff

    " Your setting you want to set when using diff mode.
    "

noremap s :grep  '<C-R><C-W>' *.<C-R>=expand('%:e')<CR> -r --color=always
endif
color desert
:hi CursorLine   cterm=NONE ctermbg=white ctermfg=black guibg=gray guifg=white
:hi CursorColumn cterm=NONE ctermbg=white ctermfg=black guibg=gray guifg=white
" Set line numbering on marging to red background:
:highlight CursorLineNR ctermbg=red
"" highlight CursorLineNR ctermbg=235 ctermfg=white

:nnoremap <Leader>c :set cursorline! cursorcolumn!<CR>

" https://stackoverflow.com/questions/6778961/alt-key-shortcuts-not-working-on-gnome-terminal-with-vim
let c='a'
while c <= 'z'
  exec "set <A-".c.">=\e".c
  exec "imap \e".c." <A-".c.">"
  let c = nr2char(1+char2nr(c))
endw

set timeout ttimeoutlen=50

map <M-j> gg

noremap <M-j> gg
nnoremap <M-j> gg

"TODO
source ~/my.guide.vim

" RENAME Tmux title
" https://stackoverflow.com/questions/15123477/tmux-tabs-with-name-of-file-open-in-vim
if exists('$TMUX')
" rename on entering
autocmd BufEnter * call system("tmux rename-window 'Vim: " . expand("%:t") . "'")
" rename on leaving
autocmd VimLeave * call system("tmux setw automatic-rename")
endif