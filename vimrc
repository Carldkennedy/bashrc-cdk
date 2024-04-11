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

function! InsertLineWithCharacter()
    let char = input('Enter the character to repeat: ')
    if len(char) == 1
        let line = repeat(char, virtcol('$') - 1)
        execute 'put = "' . line . '"'
    else
        echo 'Please enter a single character.'
    endif
endfunction

nnoremap <Leader>= :call InsertLineWithCharacter()<CR>

