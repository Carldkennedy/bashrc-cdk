" :colorscheme desert
:set background=dark
:set number
:set wildmenu
syntax on
:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
:  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
:augroup END

:set ruler
let mapleader = ","

" Remap window management commands
" nnoremap <C-l> <C-w>
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h

" Disable cursor keys
nnoremap <up>    <nop>
nnoremap <down>  <nop>
nnoremap <left>  <nop>
nnoremap <right> <nop>
inoremap <up>    <nop>
inoremap <down>  <nop>
inoremap <left>  <nop>
inoremap <right> <nop>

" for easier navigating
inoremap jj <Esc>

" Toggle between 'number' and 'relativenumber' settings
function! ToggleNumbering()
    if &number == 1
        set nonumber norelativenumber
    else
        set number relativenumber
    endif
endfunction

" Map the toggle function to a different key combination
nnoremap <F3> :call ToggleNumbering()<CR>

" Function to toggle 'paste' mode
function! TogglePaste()
    if &paste == 1
        set nopaste
        echo "Paste mode OFF"
    else
        set paste
        echo "Paste mode ON"
    endif
endfunction

" Map the function to F2
nnoremap <F2> :call TogglePaste()<CR>

function! InsertLineWithCharacter()
    let input_value = input('Enter a number (1: =, 2: -, 3: ~, 4: ^, 5: ") or a custom character: ')
    if input_value =~ '^[1-5]$'
        " Map number to predefined characters
        let char = matchstr('=-~^"', '\%' . input_value . 'c')
    elseif len(input_value) == 1
        " Use the custom character if it is a single character
        let char = input_value
    else
        " Handle invalid input
        echo 'Invalid input. Please enter a number (1-5) or a single character.'
        return
    endif
    " Generate the underline and insert it
    let line = repeat(char, virtcol('$') - 1)
    execute 'put =' . string(line)
endfunction

" Map the function to Leader +
nnoremap <Leader>= :call InsertLineWithCharacter()<CR>


nnoremap <Leader>= :call InsertLineWithCharacter()<CR>
nnoremap <Space> :

" Changing colours with mode

hi NormalColor guifg=Black guibg=Green ctermbg=46 ctermfg=0
hi InsertColor guifg=Black guibg=Cyan ctermbg=51 ctermfg=0
hi ReplaceColor guifg=Black guibg=maroon1 ctermbg=165 ctermfg=0
hi VisualColor guifg=Black guibg=Orange ctermbg=202 ctermfg=0
set laststatus=2
set statusline=
set statusline+=%#NormalColor#%{(mode()=='n')?'\ \ NORMAL\ ':''}
set statusline+=%#InsertColor#%{(mode()=='i')?'\ \ INSERT\ ':''}
set statusline+=%#ReplaceColor#%{(mode()=='R')?'\ \ REPLACE\ ':''}
set statusline+=%#VisualColor#%{(mode()=='v')?'\ \ VISUAL\ ':''}
set rtp+=~/.fzf

" https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source ~/bashrc-cdk/vimrc
\| endif
" autocmd vimenter * ++nested colorscheme gruvbox

call plug#begin('~/.vim/plugged')
Plug 'junegunn/seoul256.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/fzf.vim'
" Plug 'SirVer/ultisnips'
Plug 'tpope/vim-fugitive'
Plug 'morhetz/gruvbox'
call plug#end() 

" Limelight settings
" Color name (:help cterm-colors) or ANSI code
" let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240

" Color name (:help gui-colors) or RGB color
" let g:limelight_conceal_guifg = 'DarkGray'
let g:limelight_conceal_guifg = '#777777'

" Default: 0.5
let g:limelight_default_coefficient = 0.7

" Number of preceding/following paragraphs to include (default: 0)
let g:limelight_paragraph_span = 0

" Beginning/end of paragraph
"   When there's no empty line between the paragraphs
"   and each paragraph starts with indentation
" let g:limelight_bop = '^\s'
" let g:limelight_eop = '\ze\n^\s'

" Highlighting priority (default: 10)
"   Set it to -1 not to overrule hlsearch
let g:limelight_priority = -1

" GoYo Settings
let g:goyo_width = 120

" Filetype detection
au BufRead,BufNewFile *.eb set filetype=python

