:set number

:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
:  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
:augroup END

:set ruler

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

" Function for adding underline to title
function! InsertLineWithCharacter()
    let char = input('Enter the character to repeat: ')
    if len(char) == 1
        let line = repeat(char, virtcol('$') - 1)
        execute 'put =' . string(line)
    else
        echo 'Please enter a single character.'
    endif
endfunction

nnoremap <Leader>= :call InsertLineWithCharacter()<CR>

" Changing colours with mode

hi NormalColor guifg=Black guibg=Green ctermbg=46 ctermfg=0
hi InsertColor guifg=Black guibg=Cyan ctermbg=51 ctermfg=0
hi ReplaceColor guifg=Black guibg=maroon1 ctermbg=165 ctermfg=0
hi VisualColor guifg=Black guibg=Orange ctermbg=202 ctermfg=0
set laststatus=2
set statusline=
set statusline=%#NormalColor#%{(mode()=='n')?' NORMAL ':''}
set statusline+=%#InsertColor#%{(mode()=='i')?' INSERT ':''}
set statusline+=%#ReplaceColor#%{(mode()=='R')?' REPLACE ':''}
set statusline+=%#VisualColor#%{(mode()=='v')?' VISUAL ':''}
set rtp+=~/.fzf