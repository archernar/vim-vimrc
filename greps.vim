
" =====================================================================
" Function:    GrepAllBuffers
" Description: 
" Parameters:
"   - pattern: 
" Returns:     
" =====================================================================
function! GrepAllBuffers(pattern) abort
    let l:qflist = []
    
    " getbufinfo({'bufloaded': 1}) gets all buffers currently in memory
    for l:buf in getbufinfo({'bufloaded': 1})
        
        " l:buf.listed ensures we only search normal buffers (visible in :ls)
        " and skips internal/unlisted buffers like the quickfix list itself
        if l:buf.listed
            let l:bufnr = l:buf.bufnr
            let l:lines = getbufline(l:bufnr, 1, '$')
            let l:lnum = 1
            
            for l:line in l:lines
                if match(l:line, a:pattern) != -1
                    call add(l:qflist, {
                        \ 'bufnr': l:bufnr,
                        \ 'lnum': l:lnum,
                        \ 'text': l:line
                        \ })
                endif
                let l:lnum += 1
            endfor
        endif
    endfor
    
    if empty(l:qflist)
        echohl WarningMsg | echo "No matches found for: " . a:pattern | echohl None
    else
        call setqflist([], 'r', {'title': 'Grep All Buffers: ' . a:pattern, 'items': l:qflist})
        copen
    endif
endfunction

command! -nargs=1 GrepAll call GrepAllBuffers(<q-args>)

function! GrepViewableBuffers(pattern) abort
    let l:qflist = []
    
    " getbufinfo() returns a list of dictionaries for all buffers
    " We filter for buffers that are loaded into memory
    for l:buf in getbufinfo({'bufloaded': 1})
        
        " If the 'windows' list is not empty, the buffer is viewable
        if !empty(l:buf.windows)
            let l:bufnr = l:buf.bufnr
            let l:lines = getbufline(l:bufnr, 1, '$')
            let l:lnum = 1
            
            " Iterate through the buffer's lines
            for l:line in l:lines
                " Check if the pattern matches the line. 
                " match() adheres to your standard Vim regex and 'ignorecase' settings.
                if match(l:line, a:pattern) != -1
                    call add(l:qflist, {
                        \ 'bufnr': l:bufnr,
                        \ 'lnum': l:lnum,
                        \ 'text': l:line
                        \ })
                endif
                let l:lnum += 1
            endfor
        endif
    endfor
    
    " Populate the quickfix list and open the window
    if empty(l:qflist)
        echohl WarningMsg | echo "No matches found for: " . a:pattern | echohl None
    else
        " 'r' replaces the current quickfix list instead of appending
        call setqflist([], 'r', {'title': 'Viewable Grep: ' . a:pattern, 'items': l:qflist})
        copen
    endif
endfunction

" Create a custom command to easily call the function
command! -nargs=1 GrepViewable call GrepViewableBuffers(<q-args>)
command! -nargs=1 VGrep call GrepViewableBuffers(<q-args>)


" =====================================================================
" Function:    GrepSessionFiles
" Description: 
" Parameters:
"   - arg_pattern: 
" Returns:     
" =====================================================================
function! GrepSessionFiles(arg_pattern) abort
    let l:qflist = []
    
    " Statically define the file containing the list of paths to search
    let l:pattern=a:arg_pattern
    if empty(a:arg_pattern) 
        let l:pattern=expand('<cword>')
    endif

    let l:list_file = '.vim.vimsession'
    
    " Check if .vim.vimsession exists and is readable in the current directory
    if !filereadable(l:list_file)
        echohl ErrorMsg | echo "Cannot read list file: " . l:list_file | echohl None
        return
    endif
    
    " Read the paths from .vim.vimsession
    let l:file_paths = readfile(l:list_file)
    
    for l:file_path in l:file_paths
        " Skip empty lines and ensure the target file is readable
        if !empty(l:file_path) && filereadable(l:file_path)
            
            " Read the contents of the target file
            let l:lines = readfile(l:file_path)
            let l:lnum = 1
            
            for l:line in l:lines
                if match(l:line, l:pattern) != -1
                    " Use 'filename' to populate the quickfix list
                    call add(l:qflist, {
                        \ 'filename': l:file_path,
                        \ 'lnum': l:lnum,
                        \ 'text': l:line
                        \ })
                endif
                let l:lnum += 1
            endfor
        endif
    endfor
    
    " Populate the quickfix list and open the window
    if empty(l:qflist)
        echohl WarningMsg | echo "No matches found for: " . l:pattern | echohl None
    else
        call setqflist([], 'r', {'title': 'Grep ' . l:list_file . ': ' . l:pattern, 'items': l:qflist})
        copen
    endif
endfunction

" Create a custom command that only requires the search pattern
command! -nargs=? GrepSession call GrepSessionFiles(<q-args>)



command! -nargs=1 GrepBuffers cexpr [] | sil! bufdo vimgrepadd /<args>/ % | copen
