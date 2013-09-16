" extra python helpers (to extend the default python ftplugin)
" Language:    python
" from: https://github.com/vim-scripts/Python-mode-klen
"

if exists("b:did_ftplugin2") | finish | endif
let b:did_ftplugin2 = 1

    nnoremap <buffer> ]]  :<c-u>call <sid>motion_move('^\(class\\|def\)\s', '')<cr>
    nnoremap <buffer> [[  :<c-u>call <sid>motion_move('^\(class\\|def\)\s', 'b')<cr>
    nnoremap <buffer> ]d  :<c-u>call <sid>motion_move('^\s*\zs\(class\\|def\)\s', '')<cr>zz
    nnoremap <buffer> [d  :<c-u>call <sid>motion_move('^\s*\zs\(class\\|def\)\s', 'b')<cr>zz


    onoremap <buffer> ]]  :<c-u>call <sid>motion_move('^\(class\\|def\)\s', '')<cr>
    onoremap <buffer> [[  :<c-u>call <sid>motion_move('^\(class\\|def\)\s', 'b')<cr>
    onoremap <buffer> ]d  :<c-u>call <sid>motion_move('^\s*\(class\\|def\)\s', '')<cr>
    onoremap <buffer> [d  :<c-u>call <sid>motion_move('^\s*\(class\\|def\)\s', 'b')<cr>

    vnoremap <buffer> ]]  :call <sid>motion_vmove('^\(class\\|def\)\s', '')<cr>
    vnoremap <buffer> [[  :call <sid>motion_vmove('^\(class\\|def\)\s', 'b')<cr>
    vnoremap <buffer> ]d  :call <sid>motion_vmove('^\s*\(class\\|def\)\s', '')<cr>
    vnoremap <buffer> [d  :call <sid>motion_vmove('^\s*\(class\\|def\)\s', 'b')<cr>


fun! <sid>BlockEnd(lnum, ...) "{{{
    let indent = a:0 ? a:1 : indent(a:lnum)
    let lnum = a:lnum
    while lnum
        let lnum = nextnonblank(lnum + 1)
        if getline(lnum) =~ '^\s*#' | continue
        elseif lnum && indent(lnum) <= indent
            return lnum - 1
        endif
    endwhile
    return line('$')
endfunction "}}}


fun! <sid>motion_move(pattern, flags, ...) "{{{
    let cnt = v:count1 - 1
    let [line, column] = searchpos(a:pattern, a:flags . 'sW')
    let indent = indent(line)
    while cnt && line
        let [line, column] = searchpos(a:pattern, a:flags . 'W')
        if indent(line) == indent
            let cnt = cnt - 1
        endif
    endwhile
    return [line, column]
endfunction "}}}


fun! <sid>motion_vmove(pattern, flags) range "{{{
    call cursor(a:lastline, 0)
    let end = <sid>motion_move(a:pattern, a:flags)
    call cursor(a:firstline, 0)
    normal! v
    call cursor(end)
endfunction "}}}


fun! <sid>motion_pos_le(pos1, pos2) "{{{
    return ((a:pos1[0] < a:pos2[0]) || (a:pos1[0] == a:pos2[0] && a:pos1[1] <= a:pos2[1]))
endfunction "}}}


fun! <sid>motion_select(pattern, inner) "{{{
    let cnt = v:count1 - 1
    let orig = getpos('.')[1:2]
    let snum = BlockStart(orig[0], a:pattern)
    if getline(snum) !~ a:pattern
        return 0
    endif
    let enum = BlockEnd(snum, indent(snum))
    while cnt
        let lnum = search(a:pattern, 'nW')
        if lnum
            let enum = BlockEnd(lnum, indent(lnum))
            call cursor(enum, 1)
        endif
        let cnt = cnt - 1
    endwhile
    if <sid>motion_pos_le([snum, 0], orig) && <sid>motion_pos_le(orig, [enum, 1])
        if a:inner
            let snum = snum + 1
            let enum = prevnonblank(enum)
        endif

        call cursor(snum, 1)
        normal! v
        call cursor(enum, len(getline(enum)))
    endif
endfunction "}}}
