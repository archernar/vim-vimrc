"
" ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
" Gemini AI Interface
" ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
"
function! InsertSystemOutput(command, query)
  " Run the system command and store the output in a variable.
  let output = system(a:command)

  " Get the current cursor position.
  let current_line = line('.')
  let current_col = col('.')

  " Insert the output into the buffer at the current cursor position.
  call append(current_line - 1, split(output, '\n'))

  let l:current_date = strftime("%Y-%m-%d")
  call writefile( ['', l:current_date] , "/tmp/gem.txt", "a") 
  call writefile( ['--------------------------------------'] , "/tmp/gem.txt", "a") 
  call writefile( ['New Gemini Query  --------------------'] , "/tmp/gem.txt", "a") 
  call writefile( ['--------------------------------------'] , "/tmp/gem.txt", "a") 
  call writefile( [ a:query, '' ]                            , "/tmp/gem.txt", "a") 
  let l:xx = split(output, '\n')
  call writefile( l:xx,                      "/tmp/gem.txt", "a")

  " Move the cursor to the end of the inserted text.
  let output_lines = len(split(output, '\n'))
  call cursor(current_line + output_lines, current_col)
endfunction


function! Gemini()
    let l:dq="\""
    let l:szIn = GetUserInput("Gemini prompt: ")
    if l:szIn != ""
      let l:sz = $HOME . "/scm/private/qg " . l:dq . l:szIn . l:dq . " | fold -sw 80"
      call InsertSystemOutput(l:sz, l:szIn)
    else
      echo "Input cancelled."
    endif
  return 0
endfunction

