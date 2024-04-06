:set number

:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
:  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
:augroup END

:set ruler

" Remap window management commands
nnoremap <C-l> <C-w>


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
