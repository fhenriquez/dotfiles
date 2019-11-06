" URL: http://vim.wikia.com/wiki/Example_vimrc
" Authors: http://vim.wikia.com/wiki/Vim_on_Freenode
" Description: A minimal, but feature rich, example .vimrc. If you are a
"              newbie, basing your first .vimrc on this file is a good choice.
"              If you're a more advanced user, building your own .vimrc based
"              on this file is still a good idea.

"------------------------------------------------------------
" Features {{{1
"
" These options and commands enable some very useful features in Vim, that
" no user should have to live without.

" Set 'nocompatible' to ward off unexpected things that your distro might
" have made, as well as sanely reset options when re-sourcing .vimrc
set nocompatible

" Attempt to determine the type of a file based on its name and possibly its
" contents. Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
filetype indent plugin on

" Enable syntax highlighting
syntax on

"------------------------------------------------------------
" Must have options {{{1
"
" These are highly recommended options.

" Vim with default settings does not allow easy switching between multiple files
" in the same editor window. Users can use multiple split windows or multiple
" tab pages to edit multiple files, but it is still best to enable an option to
" allow easier switching between files.
"
" One such option is the 'hidden' option, which allows you to re-use the same
" window and switch from an unsaved buffer without saving it first. Also allows
" you to keep an undo history for multiple files when re-using the same window
" in this way. Note that using persistent undo also lets you undo in multiple
" files even in the same window, but is less efficient and is actually designed
" for keeping undo history after closing Vim entirely. Vim will complain if you
" try to quit without saving, and swap files will keep you safe if your computer
" crashes.
set hidden

" Note that not everyone likes working this way (with the hidden option).
" Alternatives include using tabs or split windows instead of re-using the same
" window as mentioned above, and/or either of the following options:
" set confirm
" set autowriteall

" Better command-line completion
set wildmenu

" Show partial commands in the last line of the screen
set showcmd

" Highlight searches (use <C-L> to temporarily turn off highlighting; see the
" mapping of <C-L> below)
set hlsearch

" Modelines have historically been a source of security vulnerabilities. As
" such, it may be a good idea to disable them and use the securemodelines
" script, <http://www.vim.org/scripts/script.php?script_id=1876>.
" set nomodeline


"------------------------------------------------------------
" Usability options {{{1
"
" These are options that users frequently set in their .vimrc. Some of them
" change Vim's behaviour in ways which deviate from the true Vi way, but
" which are considered to add usability. Which, if any, of these options to
" use is very much a personal preference, but they are harmless.

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase

" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start

" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
set autoindent

" Stop certain movements from always going to the first character of a line.
" While this behaviour deviates from that of Vi, it does what most users
" coming from other editors would expect.
set nostartofline

" Display the cursor position on the last line of the screen or in the status
" line of a window
set ruler

" Always display the status line, even if only one window is displayed
set laststatus=2

" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm

" Use visual bell instead of beeping when doing something wrong
set visualbell

" And reset the terminal code for the visual bell. If visualbell is set, and
" this line is also included, vim will neither flash nor beep. If visualbell
" is unset, this does nothing.
set t_vb=

" Enable use of the mouse for all modes
set mouse=a

" Set the command window height to 2 lines, to avoid many cases of having to
" "press <Enter> to continue"
set cmdheight=2

" Display line numbers on the left
set number

" Display relative line numbers
set relativenumber

" Quickly time out on keycodes, but never time out on mappings
set notimeout ttimeout ttimeoutlen=200

" Use <F11> to toggle between 'paste' and 'nopaste'
set pastetoggle=<F11>


"------------------------------------------------------------
" Indentation options {{{1
"
" Indentation settings according to personal preference.

" Indentation settings for using 4 spaces instead of tabs.
" Do not change 'tabstop' from its default value of 8 with this setup.
set shiftwidth=4
"set softtabstop=4
set tabstop=4
set expandtab

" Indentation settings for using hard tabs for indent. Display tabs as
" four characters wide.
"set shiftwidth=4
"set tabstop=4


"------------------------------------------------------------
" Mappings {{{1
"
" Useful mappings

" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
" which is the default
map Y y$

" Map <C-L> (redraw screen) to also turn off search highlighting until the
" next search
nnoremap <C-L> :nohl<CR><C-L>

"----------------------------------------------------------------
" Franklin's edits

" To turn off autoindent when you paste code, there's a special "paste" mode.

" set paste

" Then paste your code. Note that the text in the tooltip now says -- INSERT (paste) --.
" After you pasted your code, turn off the paste-mode, so that auto-indenting when you type works correctly again.

" set nopaste

"----------------------------------------------------------------
" vim to auto-reload your configuration
augroup myvimrchooks
    au!
    autocmd bufwritepost .vimrc source ~/.vimrc
augroup END

"----------------------------------------------------------------
" Foldable Code snippets
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=2
"set foldmethod=syntax

" z+o opens a fold at the cursor.
" z+Shift+o opens all folds at the cursor.
" z+c closes a fold at the cursor.
" z+m increases the foldlevel by one.
" z+Shift+m closes all open folds.
" z+r decreases the foldlevel by one.
" z+Shift+r decreases the foldlevel to zero -- all folds will be open.

"----------------------------------------------------------------
runtime! config/**/*.vim

"------------------------------------------------------
" Bash Funciton edits.
let g:BASH_AuthorName   = 'Franklin Henriquez'
let g:BASH_Email        = 'franklin.a.henrqiuez@gmail.com'
let g:BASH_Company      = ''

"----------------------------------------------------------------
" NERDTree
" Open a NERDTree automatically when vim starts up.
" autocmd vimenter * NERDTree

" Open a NERDTree automatically when vim starts up if no files were specified.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Open NERDTree automatically when vim starts up on opening a directory.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

" Map a specific key or shortcut to open NERDTree
" open NERDTree with Ctrl+O (you can set whatever key you want).
map <C-O> :NERDTreeToggle<CR>

" Close vim if the only window left open is a NERDTree.
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Change default arrows.
"let g:NERDTreeDirArrowExpandable = '▸'
"let g:NERDTreeDirArrowCollapsible = '▾'

"------------------------------------------------------
" NERD Commenter
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1

" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1

" map <C-/> to toggle comments in vim
" Add following code to your .vimrc file.
"
"     map ,cc <plug>NERDCommenterToggle
"
" or if you have defined your <leader> as ,
"
"     map <leader>cc <plug>NERDCommenterToggle
"
" Check if you can use ,cc to toggle comments in vim
" Open iTerm2 -> Preferences -> Keys, click the + button
" Select Send Text with "vim" Special Chars, enter ,cc, like this.
" Now you can use C-/ to toggle comments in vim.

nnoremap <C-_>   <Plug>NERDCommenterToggle<CR>
vnoremap <C-_>   <Plug>NERDCommenterToggle<CR>gv

"    [count]<leader>cc |NERDCommenterComment|
"    Comment out the current line or text selected in visual mode.

"    [count]<leader>cn |NERDCommenterNested|
"    Same as cc but forces nesting.

"    [count]<leader>c<space> |NERDCommenterToggle|
"    Toggles the comment state of the selected line(s). If the topmost selected line is commented, all selected lines are uncommented and vice versa.

"    [count]<leader>cm |NERDCommenterMinimal|
"    Comments the given lines using only one set of multipart delimiters.

"    [count]<leader>ci |NERDCommenterInvert|
"    Toggles the comment state of the selected line(s) individually.

"    [count]<leader>cs |NERDCommenterSexy|
"    Comments out the selected lines with a pretty block formatted layout.

"    [count]<leader>cy |NERDCommenterYank|
"    Same as cc except that the commented line(s) are yanked first.

"    <leader>c$ |NERDCommenterToEOL|
"    Comments the current line from the cursor to the end of line.

"    <leader>cA |NERDCommenterAppend|
"    Adds comment delimiters to the end of line and goes into insert mode between them.

"    |NERDCommenterInsert|

"    Adds comment delimiters at the current cursor position and inserts between. Disabled by default.
"
"    <leader>ca |NERDCommenterAltDelims|
"    Switches to the alternative set of delimiters.

"    [count]<leader>cl |NERDCommenterAlignLeft [count]<leader>cb |NERDCommenterAlignBoth
"    Same as |NERDCommenterComment| except that the delimiters are aligned down the left side (<leader>cl) or both sides (<leader>cb).

"    [count]<leader>cu |NERDCommenterUncomment|
"    Uncomments the selected line(s).

"------------------------------------------------------
" Windows split navigation
" Alt+leftarrow will go one window left, etc.
"nmap <silent> <A-Up> :wincmd k<CR>
"nmap <silent> <A-Down> :wincmd j<CR>
"nmap <silent> <A-Left> :wincmd h<CR>
"nmap <silent> <A-Right> :wincmd l<CR>
" ctrl-h will go one window left, etc.
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Resize windows with + or - only works for horizontal windows
map - <C-W>-
map + <C-W>+

" To open a new VIM window next to the existing one, press <Ctrl>+<w> then press <v>.
" To open a new VIM window on the bottom of the currently selected window, press <Ctrl>+<w> then press <s>.
" Max out the height of the current split
" ctrl + w _

" Max out the width of the current split
" ctrl + w |

" Normalize all split sizes, which is very handy when resizing terminal
" ctrl + w =

" Swap top/bottom or left/right split
" Ctrl+W R

" Break out current window into a new tabview
" Ctrl+W T

" Close every window in the current tabview but the current one
" Ctrl+W o

"------------------------------------------------------
"fuzzy find Section
map ; :Files<CR>

"------------------------------------------------------
"vim-multiple-cursors Mapping
let g:multi_cursor_use_default_mapping=0

" Default mapping
let g:multi_cursor_start_word_key      = '<C-n>'
let g:multi_cursor_select_all_word_key = '<A-n>'
let g:multi_cursor_start_key           = 'g<C-n>'
let g:multi_cursor_select_all_key      = 'g<A-n>'
let g:multi_cursor_next_key            = '<C-n>'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'

"------------------------------------------------------
" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"------------------------------------------------------
" snipmate config
" let g:snipMate = {}
" let g:snipMate.scope_aliases = {}
" let g:snipMate.scope_aliases['ruby'] = 'ruby,rails'

"------------------------------------------------------
" Re-Map capitalize words
" gcw        - capitalize word (from cursor position to end of word)
" gcW        - capitalize WORD (from cursor position to end of WORD)
" gciw       - capitalize inner word (from start to end)
" gciW       - capitalize inner WORD (from start to end)
" gcis       - capitalize inner sentence
" gc$        - capitalize until end of line (from cursor postition)
" gcgc       - capitalize whole line (from start to end)
" gcc        - capitalize whole line
" {Visual}gc - capitalize highlighted text
if (&tildeop)
  nmap gcw guw~l
  nmap gcW guW~l
  nmap gciw guiw~l
  nmap gciW guiW~l
  nmap gcis guis~l
  nmap gc$ gu$~l
  nmap gcgc guu~l
  nmap gcc guu~l
  vmap gc gu~l
else
  nmap gcw guw~h
  nmap gcW guW~h
  nmap gciw guiw~h
  nmap gciW guiW~h
  nmap gcis guis~h
  nmap gc$ gu$~h
  nmap gcgc guu~h
  nmap gcc guu~h
  vmap gc gu~h
endif

"------------------------------------------------------
autocmd FileType vim let b:vcm_tab_complete = 'vim'

"------------------------------------------------------
" Insert timestamp.
nmap <F3> i<C-R>=strftime("%d%b%Y %a %T %Z")<CR><Esc>
imap <F3> <C-R>=strftime("%d%b%Y %a %T %Z")<CR>

"------------------------------------------------------
"Remove all trailing whitespace by pressing F5
"nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

nnoremap <F5> :call TrimWhitespace()<CR>

" Run TrimWhitespace function before you write the file.
" I do not have it enabled as some formats require trailing whitespace,
" future enhancement would be make a list of formats to exclude.
"autocmd BufWritePre * :call TrimWhitespace()

"------------------------------------------------------
" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" Declare the list of plugins.
Plug 'tpope/vim-sensible'
Plug 'junegunn/seoul256.vim'
Plug 'junegunn/fzf.vim'
Plug 'itchyny/lightline.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'scrooloose/nerdtree'
Plug 'editorconfig/editorconfig-vim'
Plug 'scrooloose/nerdcommenter'
" Plug 'ervandew/supertab'
Plug 'marcweber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'
Plug 'honza/vim-snippets'
Plug 'vim-syntastic/syntastic'
Plug 'elzr/vim-json'
Plug 'bronson/vim-trailing-whitespace'
Plug 'vim-scripts/SearchComplete'
Plug 'mileszs/ack.vim'
Plug 'vim-scripts/bash-support.vim'
Plug 'Valloric/YouCompleteMe' , { 'do': './install.py --all' }
" Plug 'ajh17/VimCompletesMe'
" Plug ''
" Plug ''
"Plug 'bash-support plug-in'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

