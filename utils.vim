
function! g:LogMessage(...)
    let l:ret = 0

    let l:messages=[]
    call add(l:messages, a:1)
    call writefile(l:messages, "/tmp/vimscript.log", "a")
    return l:ret
endfunction
" Function: SplitStringOnce(mainString, delimiter)
" Description: Splits a string into two pieces based on the first
"              occurrence of a delimiter string.
" Arguments:
"   mainString (String): The string to be split.
"   delimiter (String):  The string to use as the split point.
" Returns:
"   (List): A list containing two strings: [before, after].
"           If the delimiter is not found or is empty,
"           returns [mainString, ""].
function! SplitStringOnce(mainString, delimiter)
  " If the delimiter is empty, we can't split.
  " Return the original string as the 'before' part.
  if empty(a:delimiter)
    return [a:mainString, ""]
  endif

  " Find the byte index of the first occurrence of the delimiter.
  " stridx() is 0-based.
  let index = stridx(a:mainString, a:delimiter)

  " Check if the delimiter was found.
  if index == -1
    " Delimiter not found.
    return [a:mainString, ""]
  else
    " Delimiter was found.
    " Extract the part before the delimiter.
    " String slicing [s:e] is inclusive.
    let l:before = a:mainString[0 : index - 1]

    " Calculate the starting index of the 'after' part.
    let l:after_start = index + strlen(a:delimiter)
    
    " Extract the part after the delimiter to the end of the string.
    let l:after = a:mainString[l:after_start :]

    return [l:before, l:after]
  endif
endfunction



function! CapitalizeWords(inputString)
  " Use substitute() to find the beginning of each word ('\<\w')
  " and replace it with its uppercase version ('\u&').
  " '\<' matches the beginning of a word.
  " '\w' matches any word character.
  " '\u' makes the next character uppercase.
  " '&' refers to the entire matched text (the single character).
  " 'g' flag ensures all matches in the line are replaced.
  let l:arr = SplitStringOnce(a:inputString, " - ")
  return l:arr[1] == "" ? l:arr[0] : l:arr[0] . " - " . substitute(l:arr[1], '\<\w', '\u&', 'g')
endfunction

                
" Function to check if a:haystack ends with a:needle
function! EndsWith(haystack, needle)
  let l:len_haystack = strlen(a:haystack)
  let l:len_needle = strlen(a:needle)

  " If the needle is longer than the haystack, it can't be the tail.
  if l:len_needle > l:len_haystack
    return 0
  endif

  " Extract the tail of the haystack, with the same length as the needle.
  " strpart(str, start_index) extracts from start_index to the end.
  let l:tail = strpart(a:haystack, l:len_haystack - l:len_needle)

  " Compare the tail with the needle.
  " ==? performs a case-sensitive comparison.
  " Use ==# for case-insensitive.
  return l:tail ==? a:needle
endfunction


" Vimscript function to pad an array of strings to a uniform length.
"
" This function takes a list of strings, finds the longest string in
" the list, and then pads each string with spaces so that all strings
" have a length equal to the (longest string's length + 2).

function! g:PadStrings(stringList)
  let l:ret = []
  " Check if the list is empty. If so, return an empty list.
  if empty(a:stringList)
    return []
  endif

  " 1. Calculate the target length
  let l:mx = -1
  for item in a:stringList
      let l:ll = len(item)
      if l:ll > l:mx
          let l:mx = l:ll
     endif
  endfor
  let l:tx = l:mx + 3

  " 2. pad the new list
  for item in a:stringList
      call add(l:ret, item . repeat(" ", l:tx - len(item)) )
  endfor
  "call add(l:ret, '' . repeat(" ", l:tx - 0) )

  " 3. Return the new list
  return l:ret
endfunction




"
" Concatenates strings from two lists element-by-element.
"
" Takes two lists of strings (list1 and list2).
" Returns a new list where each element is the concatenation of the
" corresponding elements from list1 and list2.
"
" If one list is shorter than the other, it behaves as if the shorter
" list is padded with empty strings.
"
function! ConcatStringLists(list1, list2)
    let result = []
    
    " Determine the length of the longer list
    let len1 = len(a:list1)
    let len2 = len(a:list2)
    let maxLen = max([len1, len2])

    " Handle the case of two empty lists
    if maxLen == 0
        return []
    endif

    " Loop up to the length of the longer list
    for i in range(maxLen)
        " Use get() to safely access elements.
        " If the index 'i' is out of bounds for a list, get() will
        " return the default value, which we set to "".
        let s1 = get(a:list1, i, "")
        let s2 = get(a:list2, i, "")

        " Concatenate the two strings (Vimscript 8 uses .) and add to result
        call add(result, s1 . s2)
    endfor

    return result
endfunction

" Description: A Vimscript function to extract the first 
"              whitespace-delimited word from a given string.

" Define the function. In Vimscript, functions must start
" with an uppercase letter if they are global.
function! GetFirstWord(input_string)
    " a:input_string refers to the first argument passed to the function.
    
    " The split() function, when called with just one argument,
    " splits the string by whitespace and returns a List of words.
    " It automatically handles leading/trailing/multiple whitespace.
    let l:word_list = split(a:input_string)
    
    " Check if the list of words is not empty.
    " If the input string was empty or only contained whitespace,
    " the list will be empty.
    if len(l:word_list) > 0
        " Return the first item from the list (which is at index 0).
        return l:word_list[0]
    else
        " If the list is empty, return an empty string.
        return ""
    endif
endfunction

" +++++++++++++++++++++"
" Concatenates strings from two lists element-by-element.
"
" Takes two lists of strings (list1 and list2).
" Returns a new list where each element is the concatenation of the
" corresponding elements from list1 and list2.
"
" If one list is shorter than the other, it behaves as if the shorter
" list is padded with empty strings.
"
function! ConcatStringLists(list1, list2)
    let result = []
    
    " Determine the length of the longer list
    let len1 = len(a:list1)
    let len2 = len(a:list2)
    let maxLen = max([len1, len2])

    " Handle the case of two empty lists
    if maxLen == 0
        return []
    endif

    " Loop up to the length of the longer list
    for i in range(maxLen)
        " Use get() to safely access elements.
        " If the index 'i' is out of bounds for a list, get() will
        " return the default value, which we set to "".
        let s1 = get(a:list1, i, "")
        let s2 = get(a:list2, i, "")

        " Concatenate the two strings (Vimscript 8 uses .) and add to result
        call add(result, s1 . s2)
    endfor

    return result
endfunction

function! ToLowerUnderCursor()
  " Get the current cursor position.
  let [row, col] = getpos('.')[1:2]

  " Get the character under the cursor.
  let char = getline(row)[col-1]

  " Check if a character exists at the cursor position (not end of line).
  if char != ""

    " Convert the character to lowercase.
    let lower_char = tolower(char)

    " Replace the character under the cursor with the lowercase version.
    call setline(row, strpart(getline(row), 0, col-1) . lower_char . strpart(getline(row), col))

    " Restore the cursor position (important!).
    call cursor(row, col)
  endif
endfunction
function! ToUpperUnderCursor()
  " Get the current cursor position.
  let [row, col] = getpos('.')[1:2]

  " Get the character under the cursor.
  let char = getline(row)[col-1]

  " Check if a character exists at the cursor position (not end of line).
  if char != ""

    " Convert the character to uppercase.
    let upper_char = toupper(char)

    " Replace the character under the cursor with the uppercase version.
    call setline(row, strpart(getline(row), 0, col-1) . upper_char . strpart(getline(row), col))

    " Restore the cursor position (important!).
    call cursor(row, col)
  endif
endfunction
function! g:HSplit(...)
    let l:i = 0
    let l:bc = a:1 - 1
    while l:i < l:bc 
        execute "split"
        execute "bnext"
        let l:i = l:i + 1
    endwhile
    execute "wincmd t"
    normal! 0
endfunction
function! g:VSplit(...)
    let l:i = 0
    let l:bc = a:1 - 1
    while l:i < l:bc 
        execute "vsplit"
        execute "bnext"
        let l:i = l:i + 1
    endwhile
    execute "wincmd t"
    normal! 0
endfunction
function! g:NoSplits()
    execute "only"
    normal! 0
endfunction
function! g:SplitBuffers()
    let l:last_bufno = bufnr("$")
    let l:i = 1
    let l:filenames = ""
    let l:filename  = ""

    let g:VimBufferPopUp_Init=1
    while l:i < l:last_bufno
        if bufexists(i) && buflisted(i)
            let fullpath = fnamemodify(bufname(i), ':p')
            if filereadable(fullpath)
                if v:version >= 702
                    let l:filename = fnameescape(fullpath)
                    let l:filenames = l:filenames . " " . fnameescape(fullpath)
                else
                    let l:filename  = fullpath
                    let l:filenames = l:filenames . " " . fullpath
                endif
            endif
            execute "split"
            execute "bnext "
        endif
        let l:i = l:i + 1
    endwhile
    execute "wincmd t"
    normal! 0
endfunction
" Function to reorder a list, moving the element at a:index to the front (index 0).
"
" Args:
"   a:list (List): The list to be modified. This list is modified IN-PLACE.
"   a:index (Number): The 0-based index of the element to move to the front.
"
" Returns:
"   (List): The modified list.
function! MoveToFront(list, index)
    " Get the length of the list
    let l:list_len = len(a:list)

    " --- Input Validation ---
    " Check if the list is empty
    if l:list_len == 0
        echoerr "MoveToFront: Cannot operate on an empty list."
        return a:list
    endif

    " Check if the index is within the valid bounds
    if a:index < 0 || a:index >= l:list_len
        echoerr "MoveToFront: Index " . a:index . " is out of bounds for list of length " . l:list_len
        return a:list " Return the list unmodified
    endif

    " If the item is already at the front, there's nothing to do.
    if a:index == 0
        return a:list
    endif

    " --- Reordering Logic ---
    " 1. Remove the element at the specified index.
    "    remove() returns the removed item.
    let l:item_to_move = remove(a:list, a:index)

    " 2. Insert the removed item at the beginning (index 0) of the list.
    "    We use 'call' because we are modifying the list in-place and
    "    don't need the return value of insert().
    call insert(a:list, l:item_to_move, 0)

    " 3. Return the modified list (though it was also modified in-place).
    return a:list
endfunction
" *****************************************************************************************************
                " Quickfix Resizing
                " *************************************************************************************
" Set quickfix window height to half the screen height
function! QuickfixResize()
  " Get the total height of the Vim window
  let total_height = &lines
  " Calculate half the height, using integer division (//) for a whole number
  let half_height = total_height / 2
  exe "resize " . half_height
endfunction

function! MenuCBDoNothing(id, result)
    let l:NOTHING=0
endfunction
function! MenuCBBuffer(id, result)
    if ( a:result > -1 ) 
        execute "e " . g:buffernames[a:result-1]
        call MoveToFront(g:buffernames, a:result-1)
        call MoveToFront(g:bufferdisplaynames, a:result-1)
    endif
endfunction

" https://vi.stackexchange.com/questions/24462/what-are-the-new-popup-windows-in-vim-8-2
"
" ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
" Vim Buffer Popup
" ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

let g:buffernames=[]
let g:bufferdisplaynames=[]


function! g:VimBufferPopUp()
    " let l:buffer_list = getbufinfo()
    " let listed_buffers = getbufinfo({'buflisted': 1})
    " let l:buffer_names = map(getbufinfo({'buflisted': 1}), 'v:val.name')
    let l:last_bufno  = bufnr("$")
    let l:i = 1
    let l:filenames = ""
    let l:filename  = ""
    let l:a1  = [] 
    let l:a2  = [] 
    let l:arr  = [] 
    " Notes
    " let buffer_list = getbufinfo()
    " buffer_list is a list of dictionaries.
    " Example element:
    " {'bufnr': 1, 'changed': 0, 'filetype': 'vim', 'hidden': 0, 'lnum': 1, 'name': '/path/to/file.vim', 'listed': 1, 'windows': [5001]}
    " Get info for buffers that are 'listed' (like :ls output)
    " let listed_buffers = filter(getbufinfo(), 'v:val.listed')
    " Or, more efficiently in recent Vim versions:
    " let listed_buffers = getbufinfo({'buflisted': 1})
    " Get a list of the names of all listed buffers
    " let buffer_names = map(getbufinfo({'buflisted': 1}), 'v:val.name')
    " Display the result (for demonstration)
    while l:i <= l:last_bufno
        if bufexists(i) && buflisted(i)
            let l:fullpath = fnamemodify(bufname(i), ':p')
            if filereadable(l:fullpath)
               call add(l:a1, bufname(i))
               call add(l:a2, l:fullpath)
            endif
        endif
        let l:i = l:i + 1
    endwhile
    " #{ title: "Vim Buffers", callback: 'MenuCBBuffer', line: 25, col: 40, 
    let l:arr =  ConcatStringLists(g:PadStrings(l:a1), g:PadStrings(l:a2))

    call g:PopMeUp(l:arr, "Buffers")

endfunction


" *****************************************************************************************************
                " Utility Popup
                " *************************************************************************************
function! g:UtilityPopupCommand(...)
    call system( a:1 . " > /tmp/out" )
    call UtilityPopUp("/tmp/out")
endfunction
let g:utilityPopupFilename = ""

function! g:UtilityPopUp(...)
    call g:PopMeUp(readfile(a:1), "Test")
endfunction

function! g:UtilityBufferCommand(...)
    call system( a:1 . " > /tmp/out" )
    call UtilityBuffer("/tmp/out")
endfunction
function! g:UtilityBuffer(...)
    if filereadable(a:1)
        execute "edit " . a:1
    endif
endfunction

function! g:UtilityPopUpClear(...)
    call popup_clear(1)
    nnoremap <DOWN> <down>
    nnoremap <UP>   <up>
    nnoremap <F10>  :call UtilityPopUp(g:utilityPopupFilename)<CR>
endfunction

function! ScrollPopup(nlines)
    let winids = popup_list()
    if len(winids) == 0
        return
    endif

    " Ignore hidden popups
    let prop = popup_getpos(winids[0])
    if prop.visible != 1
        return
    endif

    let firstline = prop.firstline + a:nlines
    let buf_lastline = str2nr(trim(win_execute(winids[0], "echo line('$')")))
    if firstline < 1
        let firstline = 1
    elseif prop.lastline + a:nlines > buf_lastline
        let firstline = buf_lastline + prop.firstline - prop.lastline
    endif

    call popup_setoptions(winids[0], {'firstline': firstline})
endfunction
function! GetUserInput(prompt)
  let user_input = input(a:prompt)
  return user_input
endfunction




" let user_string = GetUserInput("Enter your name: ")
function! g:GrepPopUpCallBack(id, result)
     "echom "XXXX: "
     echom "XXXX: " . a:id . " " . a:result
     execute ":" . s:numbers[a:result-1]
endfunction

function! g:GrepPopUp(szIn) 
    let l:item = ""
    let s:numbers=[]
    let l:fullpath = expand('%:p')
    let l:sz = "grep -n " . a:szIn .  " '" . l:fullpath . "'"
    let l:out=system(l:sz)
    let l:lines = split(l:out, "\n")

    for l:item in l:lines
        call add(s:numbers, "". split(l:item, ':')[0] )
        "let l:s=split(l:item, ':')
        "call add(s:numbers, l:s[0])
    endfor

    call popup_menu(l:lines,
    \ #{ title: "Command Output", callback: 'GrepPopUpCallBack', line: 25, col: 40, 
    \ highlight: 'Question', border: [], close: 'click',  padding: [2,2,0,2]} )

    " highlight: 'Question', border: [], close: 'click',  padding: [1,1,0,1]} )
endfunction

"   ***************************************************************************************************
                " Multi Toggle
                " *************************************************************************************
function! g:MultiToggle()
    let sMt=[]
    call add(sMt, [0, "Toggle Numbering",              ":set nu!<cr>"])
    call add(sMt, [1, "ls",                            ":ls<cr>"])
    call add(sMt, [2 ,"Edit dots and configs",         ":call EditDotFiles()<cr>"])
    call add(sMt, [3, "Open Vim Sheatsheet",           ":e ~/.vim/vimbrief.txt<cr>"])
    call add(sMt, [4, "Reselect Visual Selection",     "gv"])
    call add(sMt, [5, "Search for Word Under Cursor",  ":%s/\<<C-r><C-w>\>//gI<Left><Left><Left>"])
    call add(sMt, [6, "Upper Mode",                    ":call ToUpperUnderCursor()<cr>"])
    call add(sMt, [7, "Lower Mode",                    ":call ToLowerUnderCursor()<cr>"])
    call add(sMt, [8, "git status",                    ":!git status<cr>"])
    call add(sMt, [9, "git status",                    ":!git status<cr>"])
    let g:multi_toggle_state = g:multi_toggle_state  + 1
    if g:multi_toggle_state == 10
        let g:multi_toggle_state = 0
    endif
    execute "silent nnoremap <F7> " . sMt[g:multi_toggle_state][2]
    " >>>>>>>>>>>>>>>>  execute "silent nnoremap <F7> " . sMt[g:multi_toggle_state][2]
    " let l:szcmd = "nnoremap <F7> " . sMt[g:multi_toggle_state][2]
    " call g:Commander(l:szcmd,  " F7 - Multi-Toggle")

    let &statusline = sMt[g:multi_toggle_state][1]
endfunction

function! g:HelpPopUpPrime()
    "let maxLen = max([len1, len2])
    let l:maxLen = -100
    let l:maxLen = max([len(s:helpdisplaynames),  l:maxLen])
    let l:maxLen = max([len(s:helpdisplaynames2), l:maxLen])
    let l:maxLen = max([len(s:helpdisplaynames3), l:maxLen])
    let l:maxLen = max([len(s:helpdisplaynames4), l:maxLen])
    let l:maxLen = max([len(s:helpdisplaynames5), l:maxLen])

    let l:fullsize = l:maxLen
    for i in range(1, l:fullsize-len(s:helpdisplaynames))
        call add(s:helpdisplaynames, "" )
    endfor
    for i in range(1, l:fullsize-len(s:helpdisplaynames2))
        call add(s:helpdisplaynames2, "" )
    endfor
    for i in range(1, l:fullsize-len(s:helpdisplaynames3))
        call add(s:helpdisplaynames3, "" )
    endfor
    for i in range(1, l:fullsize-len(s:helpdisplaynames4))
        call add(s:helpdisplaynames4, "" )
    endfor
    for i in range(1, l:fullsize-len(s:helpdisplaynames5))
        call add(s:helpdisplaynames5, "" )
    endfor

    let l:temp1 =  ConcatStringLists(g:PadStrings(s:helpdisplaynames), g:PadStrings(s:helpdisplaynames2))
    let l:temp2 =  ConcatStringLists(l:temp1, g:PadStrings(s:helpdisplaynames3))
    let l:temp3 =  ConcatStringLists(l:temp2, g:PadStrings(s:helpdisplaynames4))
    let l:arr   =  ConcatStringLists(l:temp3, g:PadStrings(s:helpdisplaynames5))

    call add(l:arr,"=")
    call popup_menu(l:arr,
    \ #{ title: "Help", callback: 'MenuCBDoNothing', line: 25, col: 40, 
    \ highlight: 'Question', border: [], close: 'click',  padding: [1,1,0,1]} )
endfunction

function! MenuCBDoNothingPrime(id, result)
    let l:NOTHING=0
endfunction

function! g:CommanderTextPrime(...)
    if a:0 == 1
        call g:Commander('', a:1)
    else
        call g:Commander('', a:1 . " - " . a:2)
    endif
endfunction

function! g:CommanderPrime(szCommand, szHelp)
    if len(a:szCommand)+len(a:szHelp) == 0
        call add(s:helpdisplaynames, "" )
    else
        if len(a:szHelp) > 0
            let l:szSz = CapitalizeWords(a:szHelp)

            if EndsWith(l:szSz,"++++")
                call add(s:helpdisplaynames5, strpart(l:szSz, 0, len(l:szSz) - 4) )
            else
                if EndsWith(l:szSz,"+++")
                    call add(s:helpdisplaynames4, strpart(l:szSz, 0, len(l:szSz) - 3) )
                else
                    if EndsWith(l:szSz,"++")
                        call add(s:helpdisplaynames3, strpart(l:szSz, 0, len(l:szSz) - 2) )
                    else
                        if EndsWith(l:szSz,"+")
                            call add(s:helpdisplaynames2, strpart(l:szSz, 0, len(l:szSz) - 1) )
                        else
                            call add(s:helpdisplaynames, l:szSz )
                        endif
                    endif
                endif
            endif
        else
            call add(s:helpdisplaynames, '' )

        endif

        if len(a:szCommand) > 0
            let l:firstword = GetFirstWord(a:szCommand)
            if l:firstword == 'nnoremap' || l:firstword == 'inoremap' || l:firstword == 'command!'
                execute a:szCommand
            else
                execute 'nnoremap ' . a:szCommand
            endif
       endif

   endif
endfunction



" https://vi.stackexchange.com/questions/24462/what-are-the-new-popup-windows-in-vim-8-2
function! g:GitPopUp()
call popup_menu(['Status', 'add', 'commit', 'push', 'all', 'make', 'deploy','df','vim', 'pop' ], 
     \ #{ title: "Git", callback: 'MenuCBBuffer', line: 25, col: 40, 
     \ highlight: 'Question', border: [], close: 'click',  padding: [1,1,0,1]} )
endfunction
"https://www.baeldung.com/linux/vim-find-full-path-current-file#:~:text=The%20%25%20Register,%2C%20depending%20on%20the%20context).
"let l:command = "/usr/bin/git add " . expand('%') . ";git commit -m \"Update\"; git push origin master"
function! MenuCB(id, result)
    if ( a:result == 1 )
        let l:command = "git status > /tmp/out"
        call system(l:command)
        call UtilityPopUp("/tmp/out")
        "execute "new | r ! " . l:command
        "call g:BufferDelete(0)
    endif
    if ( a:result == 2 )
        let l:command = "/usr/bin/git add " . expand('%')
        execute "new | r ! " . l:command
        call g:BufferDelete(0)
    endif
    if ( a:result == 3 )
        let l:command = "git commit -m \"Update\""
        execute "new | r ! " . l:command
        call g:BufferDelete(0)
    endif
    if ( a:result == 4 )
        let l:command = "git push origin master"
        execute "new | r ! " . l:command
        call g:BufferDelete(0)
    endif
    if ( a:result == 5 )
        let l:command = "/usr/bin/git add " . expand('%') . ";git commit -m \"Update\"; git push origin master"
        execute "new | r ! " . l:command
        call g:BufferDelete(0)
    endif
    if ( a:result == 6 )
        let l:command = "./make"
        execute "new | r ! " . l:command
        call g:BufferDelete(0)
    endif
    if ( a:result == 7 )
        let l:command = "./deploy"
        execute "new | r ! " . l:command
        call g:BufferDelete(0)
    endif
    if ( a:result == 8 )
        call g:UtilityPopupCommand("df -h")
    endif
    if ( a:result == 9 )
        call g:UtilityBufferCommand("cat /usr/share/vim/vim82/doc/*.txt")
    endif
    if ( a:result == 10 )
        call g:UtilityBufferCommand("cat /usr/share/vim/vim82/doc/pop*.txt")
    endif

endfunc

function! DoNothingCB(id, result)
    let l:NOTHING=0
endfunc

" *****************************************************************************************************
                " PopUps
                " *************************************************************************************
function! g:PopMeUp(...)
    if a:0 == 4
        let l:thefilter = a:3
        let l:thecallback = a:4
        call popup_menu(a:1,
        \ #{ title: a:2, callback: l:thecallback , line: 1, col: 1, 
        \ highlight: 'Question', border: [], minheight: 28, minwidth: 132, maxheight: 10000, filter: l:thefilter, scrollbar: 1, close: 'click',  padding: [1,1,0,1]} )
    else
        if a:0 == 3
            let l:thefilter = a:3
            call popup_menu(a:1,
            \ #{ title: a:2, callback: 'MenuCBDoNothing', line: 1, col: 1, 
            \ highlight: 'Question', border: [], minheight: 28, minwidth: 132, maxheight: 10000, filter: l:thefilter, scrollbar: 1, close: 'click',  padding: [1,1,0,1]} )
        else
            if a:0 == 2
                call popup_menu(a:1,
                \ #{ title: a:2, callback: 'MenuCBDoNothing', line: 1, col: 1, 
                \ highlight: 'Question', border: [], minheight: 28, minwidth: 132, maxheight: 10000, scrollbar: 1, close: 'click',  padding: [1,1,0,1]} )
            else
                if a:0 == 1
                    call popup_menu(a:1,
                    \ #{ callback: 'MenuCBDoNothing', line: 1, col: 1, 
                    \ highlight: 'Question', border: [], minheight: 28, minwidth: 132, maxheight: 10000, scrollbar: 1, close: 'click',  padding: [1,1,0,1]} )
                endif
            endif
        endif
    endif

endfunction

func g:StandardFilter(winid, key)
      if a:key ==# "\<Esc>"
	    call popup_close(a:winid)
	    return 1
	  endif
      if a:key ==# "\x1b"
	    call popup_close(a:winid)
	    return 1
	  endif
	  if a:key == 'x'
	    call popup_close(a:winid)
	    return 1
	  endif
	  if a:key == 'q'
	    call popup_close(a:winid)
	    return 1
	  endif

	  return 0
endfunc

" *****************************************************************************************************
                " HelpPopUp
                " *************************************************************************************
function! HelpPopUpCustomFilter(winid, key)
    if g:StandardFilter(a:winid, a:key) > 0
        return 1
    endif

    if a:key == "n"
        call popup_close(a:winid)
        call HelpPopUp()
        return 1
    endif

    return popup_filter_menu(a:winid, a:key)
endfunc
" *****************************************************************************************************
                " FilePopUp
                " *************************************************************************************
function! FilesDotTxtPopUpCustomFilter(winid, key)
    if g:StandardFilter(a:winid, a:key) > 0
        return 1
    endif

    if a:key == "\<F9>"
        call popup_close(a:winid)
        call g:FilePopUp('/tmp/files.txt')
        return 1
    endif

    return popup_filter_menu(a:winid, a:key)
endfunc
" *****************************************************************************************************
                " IncluderPopUp
                " *************************************************************************************
function! IncluderPopUpCustomFilter(winid, key)
    if g:StandardFilter(a:winid, a:key) > 0
        return 1
    endif

    if a:key == "\<F9>"
        call popup_close(a:winid)
        call g:FilePopUp($HOME . '/.vim/includerfiles.txt')
        return 1
    endif

    return popup_filter_menu(a:winid, a:key)
endfunc
" *****************************************************************************************************
                " IncluderCallBack
                " *************************************************************************************
function! IncluderCallBack(id, result)
    let l:arr = readfile($HOME . '/.vim/vimsetup/includerfiles.txt')
    if ( a:result > -1 ) 
        echom l:arr[a:result-1]
        call HereInclude(l:arr[a:result-1])
    endif
endfunction
" *****************************************************************************************************
                " FilePopUp
                " *************************************************************************************
let g:filepageno = 1
let g:filepages  = 1

function! FilePopUpCustomFilter(winid, key)
    if g:StandardFilter(a:winid, a:key) > 0
        return 1
    endif

    "if a:key == "\<F9>"
    if a:key == "n"
        call popup_close(a:winid)
        let g:filepageno = g:filepageno + 1 
        if g:filepageno > g:filepages
            let g:filepageno = 1
        endif
        call g:FilePopUp(g:GUF())
        return 1
    endif
    if a:key == "b"
        call popup_close(a:winid)
        let g:filepageno = g:filepageno - 1 
        if g:filepageno < 1
            let g:filepageno = g:filepages
        endif
        call g:FilePopUp(g:GUF())
        return 1
    endif

    return popup_filter_menu(a:winid, a:key)
endfunc

function! g:FilePopUp(...)
    let s:filePagerList=[]
    let l:arr = readfile(a:1)
    let l:lines=len(l:arr)
    let l:linesperpage = 24
    let l:pagecount=l:lines/l:linesperpage

    let l:v = -1
    let l:pages = 1 
    let l:idx = 0

    for i in range(1, 50)
        call add(s:filePagerList, [])
    endfor

    for i in range(0, len(l:arr)-1)
        let l:n = (i/l:linesperpage)+1
        if l:n != l:v
            let l:v = l:n
            let l:pages = l:pages + 1
        endif
        call add(s:filePagerList[l:n], "" . l:arr[l:idx])
        let l:idx = l:idx +1
    endfor

    "let g:filepageno = g:filepageno + 1 
    "if g:filepageno > l:pages
    "    let g:filepageno = 1
    "endif
    let g:filepages  = l:pages
    let l:szTitle = " " . l:lines . " Lines, " . l:pages . " Pages,  Page# ". g:filepageno . " "
    if a:0 == 4
        call g:PopMeUp(s:filePagerList[g:filepageno], l:szTitle, 'FilePopUpCustomFilter', a:4)
    else
        call g:PopMeUp(s:filePagerList[g:filepageno], l:szTitle, 'FilePopUpCustomFilter')
    endif


endfunction


" Function: GetTypeName
" Description: Returns the string representation of a variable's type.
" Arguments: var (any) - The variable to check
" Returns: String (e.g., 'String', 'List', 'Number')

function! GetTypeName(var)
    " Get the numeric type code from Vim
    let l:code = type(a:var)

    " Define the mapping list. The index corresponds to the Vim type code.
    " 0: Number
    " 1: String
    " 2: Funcref
    " 3: List
    " 4: Dictionary
    " 5: Float
    " 6: Boolean (Vim 7.4.1154+)
    " 7: Null    (Vim 7.4.1154+)
    " 8: Job     (Vim 8.0+)
    " 9: Channel (Vim 8.0+)
    " 10: Blob   (Vim 8.1+)
    " 11: Class  (Vim 9.0+)
    " 12: Object (Vim 9.0+)
    let l:type_names = [
        \ 'Number',
        \ 'String',
        \ 'Funcref',
        \ 'List',
        \ 'Dictionary',
        \ 'Float',
        \ 'Boolean',
        \ 'Null',
        \ 'Job',
        \ 'Channel',
        \ 'Blob',
        \ 'Class',
        \ 'Object'
        \ ]

    " Check if the code is within the known range of types
    if l:code >= 0 && l:code < len(l:type_names)
        return l:type_names[l:code]
    endif

    return 'Unknown'
endfunction
" *****************************************************************************************************
                " GUF
                " *************************************************************************************

let g:GUFFILEDEFAULT = $HOME . "/.vim.txt"
let g:GUFFILE        = g:GUFFILEDEFAULT
function! g:SetGUF(...)
    let g:GUFFILE = a:1
    return g:GUFFILE
endfunction
function! g:ReSetGUF(...)
    let g:GUFFILE = g:GUFFILEDEFAULT
    return g:GUFFILE
endfunction
function! g:GUF()
    let l:arr = readfile(g:GUFFILE)
    return l:arr[0]
endfunction

function! RightPad(text, width)
    " %-Ns formats the string left-aligned within a field of N width
    return printf('%-' . a:width . 's', a:text)
endfunction
function! RP6(text)
    return RightPad(text, 6)
endfunction

function! TopInclude(...)
    normal gg
    execute "-1r " . a:1 
endfunction
function! HereInclude(...)
    execute "-1r " . a:1 
endfunction
function! GetUserInput(prompt)
    " Displays a popup window and prompts the user to enter a string.
    " Compatible with Vim 8.2 (using inputdialog).
    " Args:    prompt (string): The prompt message to display in the popup.
    " Returns: string: The user's input, or an empty string if cancelled.
    let input = inputdialog(a:prompt, '')
    if input == ''
      return "" " User cancelled
    else
      return input
    endif
endfunction

function! g:Test()
    echom "TEST TEST TEST TEST"
endfunction

function! EditDotFiles()
        execute  "edit ~/.bashrc"
        execute  "edit ~/.vimrc"
        execute  "edit ~/.profile"
        execute  "edit ~/.vim/vimbrief.txt"
        execute  "edit ~/.vim/vim.txt"
endfunction
function! g:MultiToggleVoid()
        let g:multi_toggle_state = 0
endfunction
