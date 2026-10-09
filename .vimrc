" *********************************************************DATEOMATIC: Sun Jun 29 10:07:30 AM EDT 2025
" *********************************************************HASHOMATIC: c110cf899e129b42a5862d73b1d553c3
" *****************************************************************************************************
                " W e l c o m e   t o   m y  V I M R C
                " *************************************************************************************
set nocompatible
set hidden                        " Will switch to next buffer without raising an error
set nowrap
set nohlsearch
set noerrorbells
set scrolloff=0
let loaded_matchparen = 1         
            " http://vimrc-dissection.blogspot.com/2006/09/vim-7-re-turn-off-parenparenthesiswhat.html
set splitbelow
set splitright
set cmdheight=2                   " Set the command window height to 2 lines, to avoid many cases
                                  " of having to  press <Enter> to continue
set ruler                         " Display crsr pos on last line of scr or in status line of a window
set number                        " Display line numbers on the left
set wildmenu                      " Better command-line completion
set showcmd                       " Show partial commands in the last line of the screen
set ignorecase                    " Use case insensitive search, except when using capital letters
set smartcase
set backspace=indent,eol,start    " Allow bckspcing over autoindent, line brks & start of insrt action
set nostartofline                 " Stop certain movements from always going to the 1st char of a line.
set laststatus=2                  " Always display the status line, even if only 1 window is displayed
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set colorcolumn=104
set background=dark
set laststatus=2                  " For Status Line
set t_Co=256                      " For Status Line

" set relativenumber
" set signcolumn=yes
" set incsearch
" set hlsearch incsearch          " Highlight searches (use <C-L> to temporarily turn off highlighting
                                  " see the mapping of <C-L> below)

" *****************************************************************************************************
                " Indent and Tab  Setup
                " *************************************************************************************
" There are in fact four main methods available for indentation, each one
" overrides the previous if it is enabled, or non-empty for 'indentexpr':
" 'autoindent'	uses the indent from the previous line.
"               When opening a new line and no filetype-specific indenting is enabled, keep same
"               indent as line currently on.
" 'smartindent'	is like 'autoindent' but also recognizes some C syntax to
" 		increase/reduce the indent where appropriate.
" 'cindent'	Works more cleverly than the other two and is configurable to
" 		different indenting styles.
" 'indentexpr'	The most flexible of all: Evaluates an expression to compute
" 		the indent of a line.  When non-empty this method overrides
" 		the other ones.  See |indent-expression|.
" set cindent                       
set tabstop=4 softtabstop=4
set shiftwidth=4     " Indent settings for using 4 spaces instead of tabs.
                     " Do not change 'tabstop' from its default value of 8 
set expandtab
set smartindent
" *****************************************************************************************************
                " Syntax Highlighting
                " *************************************************************************************
syntax off

set confirm                       " Instead of failing a command because of unsaved changes,
                                  " raise a dialogue asking to save changed files.
set visualbell                    " Use visual bell instead of beeping when doing something wrong
set t_vb=
                                  " reset terminal code for visual bell. 
                                  " If visualbell is set, and this line is also included vim will
                                  " neither flash nor beep. If visualbell is unset, this does nothing.
let mapleader = " "               " Leader - ( Spacebar )
let MRU_Auto_Close = 1            " Set MRU window to close after selection
set notimeout ttimeout ttimeoutlen=200  " Quickly time out on keycodes, but never time out on mappings

" *****************************************************************************************************
                " Commands
                " *************************************************************************************
command! MyLinter :caddexpr system("cat zzzz") | copen
command! ZZZZ :caddexpr system("cat zzzz") | copen
map <C-j> :cn<CR>
map <C-k> :cp<CR>
map <C-@> @a

"  :copen " Open the quickfix window
"  :ccl   " Close it
"  :cw    " Open it if there are "errors", close it otherwise (some people prefer this)
"  :cn    " Go to the next error in the window
"  :cp    " Go to the previous error in the window
"  :cnf   " Go to the first error in the next file
"  :.cc   " Go to error under cursor (if cursor is in quickfix window)
"
" *****************************************************************************************************
                " Pre Vundle Setup
                " *************************************************************************************
filetype off

" let NOVUNDLE = 1
" *****************************************************************************************************
                " Vundle            - see :h vundle for more details or wiki for FAQ
                " *******************************************************************
                " git clone  https://github.com/VundleVim/Vundle.vim.git  ~/.vim/bundle/Vundle.vim
                " git clone  https://github.com/archernar/home.git .
                " git clone  https://github.com/archernar/dotfiles.git    ~/tmp
                " git clone
                " OLD TO BE REMOVED git clone  https://github.com/archernar/Snips.git .
                " :PluginList       - lists configured plugins
                " :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
                " :PluginUpdate     - <leader>p
                " :PluginSearch foo - searches for foo; append `!` to refresh local cache
                " :PluginClean      - confirms removal of unused plugins;
                "                     append `!` to auto-approve removal
                " *************************************************************************************
                
" *****************************************************************************************************
                " Vundle Begin
                " *************************************************************************************
if !exists("NOVUNDLE")
    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin()
    " Plugin 'VundleVim/Vundle.vim'
    Plugin 'archernar/vim-utils'
    Plugin 'archernar/vim-flashcard'
    Plugin 'archernar/vim-dir'
    Plugin 'archernar/vim-progsnips'
    Plugin 'archernar/vim-map'
    Plugin 'archernar/vim-session'
    Plugin 'archernar/vim-program'
    Plugin 'archernar/vim-monochrome'
    Plugin 'archernar/vim-mru'
    Plugin 'lifepillar/vim-solarized8'
    "Plugin 'gruvbox-community/gruvbox'
    "Bundle 'Lokaltog/vim-monotone.git'
    "Bundle 'owickstrom/vim-colors-paramount'
    Plugin 'tpope/vim-surround'
    Plugin 'vim-airline/vim-airline'
    " Plugin 'tpope/vim-fugitive'
    " Plugin 'vim-airline/vim-airline-themes'
    " Plugin 'jeetsukumaran/vim-buffergator'
    " Plugin 'ctrlpvim/ctrlp.vim'
    "
    call vundle#end()
endif
" *****************************************************************************************************
                " Vundle End
                " *************************************************************************************
                                  


" *****************************************************************************************************
                " Post Vundle Setup
                " *************************************************************************************
filetype plugin indent on         " required, to ignore plugin indent changes, instead use: 
                                  " filetype plugin on
                                  " Put non-Plugin stuff after this line

" *****************************************************************************************************
                " Utility Library Of Functions
                " *************************************************************************************
source ~/utils.vim

" *****************************************************************************************************
                " Commander Library
                " *************************************************************************************
source ~/commander.vim

" *****************************************************************************************************
                " Gemini Interface
                " *************************************************************************************
"source ~/gemini.vim



" ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
" Help Buffer Popup
" ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
let g:pageSetList=[]
for i in range(1, 10)
    let s:pageSet = []
    call add(s:pageSet, [])
    call add(s:pageSet, [])
    call add(s:pageSet, [])
    call add(s:pageSet, [])
    call add(s:pageSet, [])
    call add(s:pageSet, [])
    call add(g:pageSetList, s:pageSet)
endfor
let g:pageno = 1

function! g:NextHelpPage()
    let g:pageno = g:pageno + 1
    if g:pageno > 4
        let g:pageno = 1
    endif
    echom "Help Page Number " . g:pageno
    call HelpPopUp()
endfunction


let s:helpdisplaynames=[]
let s:helpdisplaynames2=[]
let s:helpdisplaynames3=[]
let s:helpdisplaynames4=[]
let s:helpdisplaynames5=[]
"for i in range(1, 10)
"    call add(s:helpdisplaynames3, "|" )
"endfor
"MODIFY
"
"let g:pageSetList[3][1] = readfile("zed",'',12)
function! g:HelpPopUpInit()
    let g:pageno = 0
    call g:HelpPopUp()
endfunction

function! g:HelpPopUp()
        let l:MAX = 5
        let g:pageno = g:pageno + 1
        if g:pageno > l:MAX 
            let g:pageno = 1
        endif

    "let maxLen = max([len1, len2])
    let l:maxLen = -100
    let l:maxLen = max([len(g:pageSetList[g:pageno][1]), l:maxLen])
    let l:maxLen = max([len(g:pageSetList[g:pageno][2]), l:maxLen])
    let l:maxLen = max([len(g:pageSetList[g:pageno][3]), l:maxLen])
    let l:maxLen = max([len(g:pageSetList[g:pageno][4]), l:maxLen])
    let l:maxLen = max([len(g:pageSetList[g:pageno][5]), l:maxLen])

    let l:fullsize = l:maxLen
    for i in range(1, l:fullsize-len(g:pageSetList[g:pageno][1]))
        call add(g:pageSetList[g:pageno][1], "" )
    endfor
    for i in range(1, l:fullsize-len(g:pageSetList[g:pageno][2]))
        call add(g:pageSetList[g:pageno][2], "" )
    endfor
    for i in range(1, l:fullsize-len(g:pageSetList[g:pageno][3]))
        call add(g:pageSetList[g:pageno][3], "" )
    endfor
    for i in range(1, l:fullsize-len(g:pageSetList[g:pageno][4]))
        call add(g:pageSetList[g:pageno][4], "" )
    endfor
    for i in range(1, l:fullsize-len(g:pageSetList[g:pageno][5]))
        call add(g:pageSetList[g:pageno][5], "" )
    endfor

    let l:temp1 =  ConcatStringLists(g:PadStrings(g:pageSetList[g:pageno][1]), g:PadStrings(g:pageSetList[g:pageno][2]))
    let l:temp2 =  ConcatStringLists(l:temp1, g:PadStrings(g:pageSetList[g:pageno][3]))
    let l:temp3 =  ConcatStringLists(l:temp2, g:PadStrings(g:pageSetList[g:pageno][4]))
    let l:arr   =  ConcatStringLists(l:temp3, g:PadStrings(g:pageSetList[g:pageno][5]))

    let l:szTitle = " Help " . g:pageno . " "
    call g:PopMeUp(l:arr, l:szTitle, 'HelpPopUpCustomFilter')

endfunction

func MyFilter100(winid, key)
      let l:MAX=3
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

	  if a:key == "\<F12>"
	    call popup_close(a:winid)
        let g:pageno = g:pageno + 1
        if g:pageno > l:MAX 
            let g:pageno = 1
        endif
        call HelpPopUp()
	    " do something
	    return 1
	  endif

	  if a:key == 'c'
	    call popup_close(a:winid)
        let g:pageno = g:pageno + 1
        if g:pageno > l:MAX 
            let g:pageno = 1
        endif
        call HelpPopUp()
	    return 1
	  endif

	  return 0
endfunc


" *****************************************************************************************************
                " Folding
                " *************************************************************************************

" set foldcolumn=3
" set foldmethod=marker
" set foldlevelstart=20
" set foldlevelstart=20
set foldlevel=1
set foldmethod=marker


" *****************************************************************************************************
                " Auto Commands
                " *************************************************************************************
    augroup AUTOGROUPONE
        autocmd!
        "au BufNewFile,BufRead *.ses let s=g:SessionMan()
        " Automatically close the quickfix window when you select a line
        autocmd FileType qf nnoremap <buffer> <CR> <CR>:cclose<CR>

        " Create an autocommand to call the function after a quickfix window is opened
        " The 'qf' filetype is used to target the quickfix window
        autocmd FileType qf call QuickfixResize()
        

    augroup END

" *****************************************************************************************************
                " Session Setup
                " *************************************************************************************
if ( 1 == 1 ) 
    if ( argc() == 0 ) 
         augroup VIMAUTOGROUPA
             autocmd!
             autocmd VimEnter * :call LoadSession()
         augroup END
    endif
    if ( argc() == 1 ) 
         let s:n=match(argv(0), "vimsession$")
         if (s:n>0)
             let $VIMFIRSTFILE=argv(0)
             let s:temp = argv(0)
             let s:temp = substitute(s:temp, ".vimsession$", "", "")
             let $VIMSESSION=s:temp
             let $VIMWINDOW="NIL"
             let $VIMSPLIT="NIL"
             if ( 1 == 1 ) 
             augroup VIMAUTOGROUPB
                 autocmd! VimEnter
                 "autocmd VimEnter * :call LoadSession()
                 "autocmd VimEnter * :echom "POPEYE"
             augroup END
             endif
         endif
    endif
endif

"   ***************************************************************************************************
                " Jump to Last Position When Reopening a File
                " *************************************************************************************
   if has("autocmd")
      au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
      \| exe "normal! g'\"" | endif
   endif
function! s:SLine(msg)
    let save_statusline = &statusline  " Save the current statusline
    let &statusline = a:msg
    "let &statusline = save_statusline
endfunction
"
" wget -O ~/.vim/vim.txt https://raw.githubusercontent.com/archernar/basics/refs/heads/master/vim.txt
" nnoremap         <F7> :call g:FlashCard($HOME . "/.vim/1.fc")<cr>
" nnoremap <leader><F7> :call g:UnFlashCard()<cr>

let g:multi_toggle_state = -1
let &statusline = "Void Mode"



function! g:OpenReadOnlyFileExit()
    silent exe "bd!"
    echom ""
endfunction
function! g:BufferDelete(...)
        if (a:1 == 0)
            nnoremap <silent> <buffer> q     :call g:BufferDelete(1)<cr>
            nnoremap <silent> <buffer> <F1>  :call g:BufferDelete(1)<cr>
            nnoremap <silent> <buffer> <esc> :call g:BufferDelete(1)<cr>
        else
            silent exe "bd!"
        endif
    echom ""
endfunction
function! g:OpenReadOnlyFile(...)
        let l:filename = a:1
        exe "set nopaste"
        let l:f = l:filename
        if filereadable(l:f)
            " silent exe "tabnew " . l:f
            silent execute "edit " . l:f
            silent exe "set buftype=nowrite"
            nnoremap <silent> <buffer> q     :call g:OpenReadOnlyFileExit()<cr>
            nnoremap <silent> <buffer> <F1>  :call g:OpenReadOnlyFileExit()<cr>
            nnoremap <silent> <buffer> <esc> :call g:OpenReadOnlyFileExit()<cr>
            silent exe "normal gg0"
        endif
        exe "set paste"
endfunction

function! SafeBufferNext()
    " Do nothing if the current buffer is a scratch or special buffer
    if &buftype != ''
        return
    endif

    " Close quickfix window if open
    cclose

    " Cycle to the next non-scratch buffer, avoiding infinite loops
    let l:start = bufnr('%')
    bnext
    while &buftype != '' && bufnr('%') != l:start
        bnext
    endwhile
endfunction


" ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
" ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++



function! LocalSetups()
    setlocal iskeyword=@,48-57,_,192-255,.
endfunction
command! SPEC      :call LocalSetups() 
command! LOC       :call LocalSetups() 
command! LOCAL     :call LocalSetups() 
call LocalSetups() 




" ----------------------------------------------------------------------------
"  Section 6: File Management & Backups
" ----------------------------------------------------------------------------

" --- Persistent Undo ---
" Keep undo history even after closing a file
set undofile
set undodir=~/.vim/undo
" Create the directory if it doesn't exist
silent !mkdir -p ~/.vim/undo

" ----------------------------------------------------------------------------
"  Section 7: Key Mappings (Quality of Life)
" ----------------------------------------------------------------------------

" *****************************************************************************************************
                " Remaps
                " Note: `nnoremap` means "non-recursive normal mode map".
                " It's the safest way to map keys.
                " --- Fast Escape ---
                " Use `jj` to exit Insert mode. Much faster than reaching for Esc.
                " *************************************************************************************
"
for i in range(0, 4)
    call g:CommanderText(i, "Help" )
    call g:CommanderSpace(i)
endfor


call g:Commander(0, "<F1>         :cclose<cr>:call SafeBufferNext()<cr>", " F1 - Next Buffer" )
call g:Commander(0, "<leader><F1> :set paste!<cr>",                       "+F1 - Set Paste")
call g:Commander(0, "<F2>         :call VimBufferPopUp()<CR>",  " F2 - Vim Buffer PopUp" )
call g:Commander(0, "<leader><F2> <C-w>w",                      "+F1 - Next Split")
call g:Commander(0, "<F3>         :call HelpPopUpInit()<CR>",   " F3 - Help Popup" )
call g:Commander(0, "<F5>         :call ProgramCompile()<cr>",  " F5 - Program Compile")
call g:Commander(0, "<F6>         :call ProgramRun()<cr>",      " F6 - Program Run")
call g:Commander(0, "<leader><F6> :cclose<cr>",                 "+F6 - Close QuickFix")
call g:Commander(0, "<F7> :call g:MultiToggleVoid()<CR>",       " F7 - Multi-Toggle")
call g:Commander(0, "<F8> :call g:MultiToggle()<CR>",           " F8 - Toggle Multi-Toggle")
call g:Commander(0, "<F9> <esc>:call g:FilePopUp(g:GUF())<CR>", " F9 - Utility Popup")
call g:Commander(0, "<Leader>p     :PluginUpdate<cr>",          "+p  - Plugin Update")
call g:CommanderSpace(0)
call g:Commander(0, "<leader>b :bnext<CR>",                     "+b  - Next buffer")
call g:Commander(0, "<leader>k :bprev<CR>",                     "+k  - Previous buffer")
call g:Commander(0, "<leader>d :bdelete<CR>",                   "+d  - Close buffer")
call g:Commander(0, "<leader>t :tabnew<CR>",                    "+t  - New tab")

" --- Window (Split) Management ---
call g:Commander(1, "<leader>vs  :call g:HSplit(2)<CR>",  "+vs     - Vertical split")
call g:Commander(1, "<leader>hs  :call g:VSplit(2)<CR>",  "+hs     - Horizontal split")
call g:Commander(1, "<leader>ss  :call g:VSplit(2)<CR>",  "+ss     - Horizontal split")
call g:Commander(1, "<leader>ns  :call g:NoSplits()<CR>", "+ns     - Close all splits")
call g:Commander(1, "<leader>as  :call g:SplitBuffers()<CR>", "+ss     - All splits")
call g:CommanderSpace(1)
" Navigate splits using Ctrl + (h,j,k,l)
call g:Commander(1, "<C-h> <C-w>h",           "^h      - Mv Split-Left")
call g:Commander(1, "<C-j> <C-w>j",           "^j      - Mv Split-Down")
call g:Commander(1, "<C-k> <C-w>k",           "^k      - Mv Split-Up")
call g:Commander(1, "<C-l> <C-w>l",           "^l      - Mv Split-Right")
" HEREHERE
call g:Commander(1, "<leader><Left>  :wincmd h<CR>","+<L>    - Mv Split-Left")
call g:Commander(1, "<leader><Down>  :wincmd j<CR>","+<D>    - Mv Split-Down")
call g:Commander(1, "<leader><Up>    :wincmd k<CR>","+<U>    - Mv Split-Up")
call g:Commander(1, "<leader><Right> :wincmd l<CR>","+<R>    - Mv Split-Right")
call g:CommanderSpace(1)
call g:CommanderText(1,                       ":sp <f> - edit in split")
call g:CommanderText(1,                       ":vsp    - edit in vsplit")
call g:CommanderText(1,                       "gv      - remember last select")
call g:CommanderText(1,                       "Sgq     - breaks down long line")
call g:CommanderText(1,                       "%       - jump to match ( { [")
call g:CommanderText(1,                       "ci<obj> - chg inside text obj")
call g:CommanderSpace(1)




call g:CommanderText(3, "--- Ex Commands")
call g:CommanderText(3, ":wincmd h","Cursor to win-left")
call g:CommanderText(3, ":wincmd j","Cursor to win-below")
call g:CommanderText(3, ":wincmd k","Cursor to win-above")
call g:CommanderText(3, ":wincmd l","Cursor to win-right")
call g:CommanderText(3, ":wincmd w","Cycle next win")
call g:CommanderText(3, ":wincmd p","Go to the prev active win")
call g:CommanderText(3, ":wincmd =","All winds equal size")
call g:CommanderText(3, ":wincmd _","Max wind height")
call g:CommanderText(3, ":wincmd |","Max wind width")
call g:CommanderText(3, ":wincmd H","Mv wind far left")
call g:CommanderText(3, ":wincmd J","Mv wind very bottom")
call g:CommanderText(3, ":wincmd K","Mv wind very top")
call g:CommanderText(3, ":wincmd L","Mv wind far right")
call g:Commander("inoremap jj <Esc>",                        " jj - <ESC>")
call g:CommanderText("")
let g:pageno = 1
call g:CommanderText(2,"","")
call g:CommanderText(2,"","")
call g:CommanderText(2,"","")
call g:CommanderText(2, "set nu!", "Toggle scrn #s")
call g:CommanderText(2,"","")
call g:CommanderText(2, "", "--- Scrolling")
call g:CommanderText(2, "C-F","Scrl fwd full scrn")
call g:CommanderText(2, "C-B","Scrl bck full scrn")
call g:CommanderText(2, "C-D","Scrl dn (fwd) half scrn")
call g:CommanderText(2, "C-U","Scrl up (bck) half scrn")
call g:CommanderText(2, "C-E","Scrl dn 1 line")
call g:CommanderText(2, "C-Y","Scrl up 1 line")
" ommand	Direction	Match Type	Description
" *	Forward	Whole Word	Finds the next exact match (e.g., "the" matches "the", but not "there").
" #	Backward	Whole Word	Finds the previous exact match.
" g*	Forward	Partial	Finds the next match, even if it's inside another word (e.g., "the" matches "there").
" g#	Backward	Partial	Finds the previous partial match.

call g:CommanderStr(4, "--- Notes")
call g:CommanderText(4, "*", "Forward Find Whole Word")
call g:CommanderText(4, "#", "Backward Find Whole Word")

call g:CommanderStr(4, "--- Register a Commands")
call g:Commander(4, "<leader>a  :normal <DQ>ayy<CR>",  "+a  - clear and yank to regA")
call g:Commander(4, "<leader>y  :normal DOUBLEQUOTEAyy<CR>",  "+y  - append yank to regA")
call g:Commander(4, "<leader>p  :normal DOUBLEQUOTEap<CR>",   "+p  - paste regA")
call g:CommanderSpace(4)
call g:CommanderStr( 4, "--- Current Line")
call g:CommanderText(4, "zz","Center")
call g:CommanderText(4, "zt","Top")
call g:CommanderText(4, "zb","Bottom")
call g:CommanderSpace(4)
call g:CommanderStr(4, "--- Commands")
"call g:Commander(4, "command! Gemini   :call Gemini()<cr>",     "Gemini")
"call g:Commander(4, "command! Gem      :call Gemini()<cr>",     "Gem")
"call g:Commander(4, "command! GEM      :call Gemini()<cr>",     "GEM")
call g:Commander(4, "command! SESSION  :call CaptureSession()", "SESSION") 
call g:Commander(4, "command! -nargs=+ GREP    call GrepPopUp(<q-args>)<cr>", "GREP")
call g:Commander(4, "command! -nargs=+ POPGREP call GrepPopUp(<q-args>)<cr>", "POPGREP")
call g:Commander(4, "command! -nargs=1 CLI call system( <q-args> . ' > /tmp/files.txt  ') | call FilePopUp('/tmp/files.txt', 'System','FilesDotTxtPopUpCustomFilter')", "CLI+++")
call g:Commander(4, "command! -nargs=0 BASHTOP call TopInclude('~/.vim/vimsetup/snips/top.bash')", "BASHTOP")
call g:Commander(4, "command! -nargs=0 TOPs    call TopInclude('~/.vim/vimsetup/snips/top.bash')", "BASHTOP")
call g:Commander(4, "command! -nargs=0 INC     call FilePopUp($HOME . '/.vim/vimsetup/includerfiles.txt', 'Includers','IncluderPopUpCustomFilter','IncluderCallBack')", "TOPS")
call g:Commander(4, "command! -nargs=0 HE      call FilePopUp($HOME . '/.vim/vimsetup/vim.md', 'vim.md','FileUpCustomFilter','')", "vim.md")
call g:CommanderSpace(4)
call g:CommanderStr(4, "--- Git Commands")
call g:Commander(4, "<leader>gaf  :!git add %<CR>",                                         "+gaf  - git add")
call g:Commander(4, "<leader>gac  :!git add % && git commit -m 'Staged changes' <CR>",      "+gac  - git add   + commit")
call g:Commander(4, "<leader>gaa  :!git add .<CR>",                                         "+gaa  - git add .")
call g:Commander(4, "<leader>gss  :!git add . && git commit -m 'Staged all changes' <CR>",  "+gss  - git add . + commit")
call g:Commander(4, "<leader>gas  :!git add %<CR>:!git status<CR>",                         "+gas  - git add   + status")
call g:Commander(4, "<leader>gaas :!git add .<CR>:!git status<CR>",                         "+gaas - git add . + status")
call g:CommanderSpace(4)


call g:LogCommandWrite()




" call g:Commander("<F9> :call system('ls -la > /tmp/files.txt')<cr>",           " Test Command")

let g:pageno = 1

"Key Sequence","Description"
".","Repeats the last change (insert, delete, change, replace)."
"CTRL-A / CTRL-X","In normal mode, increments (CTRL-A) or decrements (CTRL-X) the number under the cursor."
"CTRL-O / CTRL-I","In normal mode, navigates the jump list backward (CTRL-O) or forward (CTRL-I)."
"ci<object>","Changes inside a text object (e.g., ci"" changes inside quotes, ci( changes inside parentheses)."
"gv","In normal mode, re-selects the last visual selection."
"CTRL-O (in Insert Mode)","Executes a single normal mode command and immediately returns to insert mode."
"gi","In normal mode, moves the cursor to the last insert position and enters insert mode."
"* / #","In normal mode, searches forward (*) or backward (#) for the word under the cursor."
"%","In normal mode, jumps to the matching parenthesis, bracket, or brace."
":noh","Clears the search highlighting from the last search."
" Map a key to call the function.  For example, map <Leader>u to it.
" You can choose any key combination you prefer.  <Leader> is often \.
" See :help leader for more about setting the leader key.
" Example:
"
" hello
"
"
" Option 1: Add the current file
" nnoremap <leader>gaf :!git add %<CR>
" Option 2: Add the current file and stage changes
" nnoremap <leader>gac :!git add % && git commit -m "Staged changes" <CR>
" Option 3: Add all changes in the current directory
" nnoremap <leader>gaa :!git add .<CR>
" Option 4: Add all changes in the current directory and stage changes
" nnoremap <leader>gss :!git add . && git commit -m "Staged all changes" <CR>
" Option 5: Add the current file and show git status
" nnoremap <leader>gas :!git add %<CR>:!git status<CR>
" Option 6: Add all changes in the current directory and show git status
" nnoremap <leader>gaas :!git add .<CR>:!git status<CR>
" Option 7: Add the current file and run a custom git command
" nnoremap <leader>gac :!git add % && git commit -m <C-r>=@%<CR><CR>
" Option 8: Add all changes in the current directory and run a custom git command
" nnoremap <leader>gacc :!git add . && git commit -m <C-r>=getcwd()<CR><CR>
" 1. Define a function to run *when* the list changes.
"function! s:HandleBufferListChange()
"    Put your logic here. For demonstration, we'll just echo.
"   let l:NOTHING=0
"endfunction

" 2. Create an autocommand group to hold our listeners.
"augroup DetectBufferSetChange
"    autocmd! " Clear any existing autocommands in this group
"    3. Attach the function to the events.
"    Run when a new buffer is added to the list.
"    autocmd BufAdd * call s:HandleBufferListChange()
"    Run when a buffer is permanently wiped out.
"    autocmd BufWipeout * call s:HandleBufferListChange()
"augroup END
"
"
"
command!  StopSign      normal! a<Char-0x1F6D1>
command!  Cross         normal! a<Char-0x0274C>
command!  EMOJISTOP     normal!  a<Char-0x1F6D1>
command!  EMOJICROSS    normal!  a<Char-0x0274C>
command!  EMOJISIREN    normal!  a<Char-0x1F6A8>
command!  EMOJIWARN     normal!  a<Char-0x026A0>
command!  EMOJIBUILD    normal!  a<Char-0x1F6A7>
command!  EMOJIZAP      normal!  a<Char-0x026A1>
command!  EMOJICHECK    normal!  a<Char-0x02705>
command!  EMOJIPARTY    normal!  a<Char-0x1F389>
command!  EMOJIROCKET   normal!  a<Char-0x1F680>
command!  EMOJIINFO     normal!  a<Char-0x02139>
command!  EMOJISEARCH   normal!  a<Char-0x1F50D>
command!  EMOJIBUG      normal!  a<Char-0x1F41B>
command!  EMOJIWAIT     normal!  a<Char-0x023F3>
command!  EMOJISYNC     normal!  a<Char-0x1F504>
command!  EMOJIGEAR     normal!  a<Char-0x02699>
command!  EMOJIFIST     normal!  a<Char-0x0270A>
command!  EMOJIPALM     normal!  a<Char-0x0270B>
command!  EMOJITHUMBUP  normal!  a<Char-0x1F44D>
command!  EMOJITHUMBDN  normal!  a<Char-0x1F44E>

command!  ESTOP         normal!  a<Char-0x1F6D1>
command!  ECROSS        normal!  a<Char-0x0274C>
command!  ESIREN        normal!  a<Char-0x1F6A8>
command!  EWARN         normal!  a<Char-0x026A0>
command!  EBUILD        normal!  a<Char-0x1F6A7>
command!  EZAP          normal!  a<Char-0x026A1>
command!  ECHECK        normal!  a<Char-0x02705>
command!  EPARTY        normal!  a<Char-0x1F389>
command!  EROCKET       normal!  a<Char-0x1F680>
command!  EINFO         normal!  a<Char-0x02139>
command!  ESEARCH       normal!  a<Char-0x1F50D>
command!  EBUG          normal!  a<Char-0x1F41B>
command!  EWAIT         normal!  a<Char-0x023F3>
command!  ESYNC         normal!  a<Char-0x1F504>
command!  EGEAR         normal!  a<Char-0x02699>
command!  EFIST         normal!  a<Char-0x0270A>
command!  EPALM         normal!  a<Char-0x0270B>
command!  ETHUMBUP      normal!  a<Char-0x1F44D>
command!  ETHUMBDN      normal!  a<Char-0x1F44E>

" Plugin 'lifepillar/vim-solarized8'
" Enable true color (24-bit) support
if (has("termguicolors"))
  set termguicolors
endif
" https://vimawesome.com/plugin/solarized-8
" Tell Vim to optimize colors for a dark terminal background
set background=dark
colorscheme solarized8_high



" command! -nargs=+ GBASH execute 'r ! /home/mestes/center/gbash.sh -bash ' . shellescape(<q-args>)
" Function to send visual selection to Gemini and open in a new split
function! GeminiAnalyze(line1, line2, prompt)
  " 1. Yank the visually selected lines
  execute a:line1 . ',' . a:line2 . 'yank'
  
  " 2. Open a new vertical split (as a scratch buffer so it doesn't ask to save)
  vnew
  setlocal buftype=nofile bufhidden=wipe noswapfile
  
  " 3. Paste the yanked code into the new buffer
  put
  
  " 4. Remove the empty first line created by 'put'
  1d
  
  " 5. Filter this new buffer through your Bash script
  " shellescape() ensures your prompt text is safely passed to the shell
  execute '%!/home/mestes/vggs ' . shellescape(a:prompt)
endfunction

" Create a custom command :Gemini that calls the function
command! -range -nargs=* Gemini call GeminiAnalyze(<line1>, <line2>, <q-args>)






" --- tmux vim setup ---
    
" Required for airline statusline to display
set laststatus=2

" --- Fix 24-bit True Color inside Tmux ---
if &term =~# 'screen' || &term =~# 'tmux'
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

if has('termguicolors')
  set termguicolors
endif

" --- Vim-Airline Settings ---
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1


" *****************************************************************************************************
                " Utility Library Of Functions
                " *************************************************************************************
source ~/greps.vim



function! InsertFunctionHeader()
    " 1. Get the word (function name) currently under the cursor
    let l:func_name = expand('<cword>')
    if empty(l:func_name)
        echo "No word found under cursor."
        return
    endif

    " 2. Get the correct comment prefix for the current filetype
    let l:cms = empty(&commentstring) ? '" %s' : &commentstring
    let l:prefix = substitute(l:cms, '\s*%s.*$', '', '')
    if empty(l:prefix)
        let l:prefix = '"'
    endif

    " 3. Extract parameters from the current line
    let l:line_text = getline('.')
    " Match everything between the first ( and ) on the line
    let l:args_str = matchstr(l:line_text, '(\zs[^)]*\ze)')
    let l:args_list = []
    
    if !empty(l:args_str)
        " Split the arguments by comma
        let l:raw_args = split(l:args_str, ',')
        for l:arg in l:raw_args
            " Trim leading and trailing whitespace from each argument
            let l:clean_arg = substitute(l:arg, '^\s*\(.\{-}\)\s*$', '\1', '')
            if !empty(l:clean_arg)
                call add(l:args_list, l:clean_arg)
            endif
        endfor
    endif

    " 4. Construct the header dynamically
    let l:header = [
        \ l:prefix . ' =====================================================================',
        \ l:prefix . ' Function:    ' . l:func_name,
        \ l:prefix . ' Description: '
        \ ]

    " 5. Append individual argument lines
    if empty(l:args_list)
        call add(l:header, l:prefix . ' Parameters:  None')
    else
        call add(l:header, l:prefix . ' Parameters:')
        for l:arg in l:args_list
            call add(l:header, l:prefix . '   - ' . l:arg . ': ')
        endfor
    endif

    " 6. Finish the header
    call add(l:header, l:prefix . ' Returns:     ')
    call add(l:header, l:prefix . ' =====================================================================')

    " 7. Insert the header above the current line
    let l:cur_line = line('.')
    call append(l:cur_line - 1, l:header)

    " 8. Move the cursor to the 'Description: ' line
    call cursor(l:cur_line + 2, len(l:prefix) + 15)
endfunction

nnoremap <Leader>ch :call InsertFunctionHeader()<CR>
