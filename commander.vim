let g:LogCommandMessages=[]

function! g:LogCommandInit()
    let g:LogCommandMessages=[]
endfunction
function! g:LogCommandWrite()
    call writefile(g:LogCommandMessages, $HOME . "/.vim/vimsetup/LogCommands.log")
endfunction

function! g:LogCommand(...)
    let l:ret = 0
    call add(g:LogCommandMessages, a:1)
    return l:ret
endfunction


function! g:Commander(...)
    if a:0 == 3
        let l:nCol      = a:1
        let l:szCommand = a:2
        let l:szHelp    = a:3
        " Syntax: substitute({expr}, {pat}, {sub}, {flags})
        let l:szCommand = substitute(l:szCommand, 'DOUBLEQUOTE', '"', '')
        let l:szCommand = substitute(l:szCommand, '<DQ>', '"', '')

        if len(l:szHelp) > 0
            let l:szSz = CapitalizeWords(l:szHelp)
            call add(g:pageSetList[g:pageno][l:nCol + 1], l:szSz)
        endif

        if len(l:szCommand) > 0
            let l:firstword = GetFirstWord(l:szCommand)
            if l:firstword == 'nnoremap' || l:firstword == 'inoremap' || l:firstword == 'command!'
                execute l:szCommand
            else
                execute 'nnoremap ' . l:szCommand
            endif
       endif

       call g:LogCommand(l:szHelp)

   endif
endfunction

function! g:CommanderStr(...)
    call add(g:pageSetList[g:pageno][a:1 + 1], a:2)
endfunc

function! g:CommanderDash(...)
    call add(g:pageSetList[g:pageno][a:1 + 1], '----' )
endfunc

function! g:CommanderSpace(...)
    call add(g:pageSetList[g:pageno][a:1 + 1], '' )
endfunc

function! g:CommanderText(...)
    if a:0 == 2
        call add(g:pageSetList[g:pageno][a:1 + 1], a:2 )
    else
        if a:0 == 3
            call add(g:pageSetList[g:pageno][a:1 + 1], a:2 . " - " . a:3)
        endif
    endif
endfunc
