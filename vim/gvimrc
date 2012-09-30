" macvim shortcuts are setup in the system gvimrc,
" so we need to unset them here (not in .vimrc)

" map cmd-shift-t to new tab before current
function! NewTabBefore()
    let s:curr_tab=tabpagenr() - 1
    :silent! exec s:curr_tab .' tabnew'
endfunction

if has("gui_macvim")
    macmenu &File.Open\ Tab\.\.\. key=<nop>
    map <D-T> :call NewTabBefore()<CR>
endif
