" Intro {{{1
" Author: Claudio Roncaglio
" License: GPL V3.0
" Description: 
" 
" ASCII_ART:
"        ________ ++     ________
"       /VVVVVVVV\++++  /VVVVVVVV\
"       \VVVVVVVV/++++++\VVVVVVVV/
"        |VVVVVV|++++++++/VVVVV/'
"        |VVVVVV|++++++/VVVVV/'
"       +|VVVVVV|++++/VVVVV/'+
"     +++|VVVVVV|++/VVVVV/'+++++
"   +++++|VVVVVV|/VVV___++++++++++
"     +++|VVVVVVVVVV/##/ +_+_+_+_
"       +|VVVVVVVVV___ +/#_#,#_#,\
"        |VVVVVVV//##/+/#/+/#/'/#/
"        |VVVVV/'+/#/+/#/+/#/ /#/
"        |VVV/'++/#/+/#/ /#/ /#/
"        'V/'  /##//##//##//###/
"                 ++

" General settings {{{1
syntax enable       " Enable syntax highlight
set filetype=on     " Enable filetype specific settings
filetype plugin on  " Load the plugin files for the file types 
filetype indent on  " Load the indent file for the file types
set encoding=utf8   " Set default encoding
set history=700     " Sets how many lines of history to remember
set showmatch       " When a bracket is inserted, show the matching one
set scrolloff=2     " Set scroll offset 2 lines from the cursor when moving vertically
set ttimeoutlen=50  " Make Esc work faster

" Backup {{{2
" I prefer do not keep a backup file
set nobackup        " Don't write a permanent backup before overwrite a file
set nowritebackup   " Don't write a temporary backup before overwrite a file
" Automatic action {{{2
set autoread        " Re-read the file when is changed from outside
set autowrite       " Write the buffer on :next, :last, :make, etc...

" Space, Tabs and Indentetion {{{1
set expandtab       " Tabs are spaces
set tabstop=8       " Number of visual spaces per tab
set softtabstop=4   " Number of spaces in tab when editing
set shiftwidth=4    " Number of spaces to use for each step of (auto)indent
set smarttab        " Automatically insert the right type of <tab>
set autoindent      " Copy indent from current line when starting a new line
set wrap            " Wrap lines longer than the width of the window

" Search Settings {{{1
set hlsearch        " Highlights all matches of previous search pattern
set ignorecase      " Perform case insensitive search 
set incsearch       " While typing, show if the pattern is matched
set lazyredraw      " Redraw the screen only when necessary
set magic           " Define how special characters are interpreted in pattern 
set smartcase       " Override ignorecase when search contain uppercase characters
set wildmenu        " enhanced mode for command-line completion
set completeopt=longest,menuone 
                    " Menu autocomplete (Ctrl+n) - requires exuberant-ctags

" UI configuration {{{1
set title           " Shows filename in window's title
set ruler           " Shows the line and column number of cursor position
set cmdheight=1     " Number of screen lines to use for the command-line
set cursorline      " Highlights the current line 
set number          " Shows line numbers
if &term =~ '256color'
    set t_Co=256    "If terminal support it, enable 256 colors
    
    set t_ut=       " disables Background Color Erase (BCE) so that color schemes 
                    " renders properly when inside 256-color tmux and GNU screen.
                    " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
endif
set background=dark " Set dark/light background for syntax highlighting
colorscheme gruvbox " My currently favorite color scheme
set laststatus=2    " Shows status line on every open windows
set noshowmode      " Don't displays mode because it's in lightline

set list            " Shows invisibles characters
set listchars=tab:▸\ ,eol:¬
                    " Defines custom symbol for invisibles characters

" Lightline configurations {{{2
let g:lightline = {
    \ 'colorscheme': 'gruvbox',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
    \   'right': [ [ 'lineinfo' ],
    \              [ 'percent' ],
    \              [ 'fileformat', 'fileencoding', 'filetype', 'charvaluehex' ] ]
    \ },
    \ 'component': {
    \   'charvaluehex': '0x%B'
    \ },
    \ 'component_function': {
    \   'gitbranch': 'fugitive#head'
    \ },
    \}

" Minpac package manager {{{1

packadd minpac
call minpac#init()
call minpac#add('k-takata/minpac', {'type': 'opt'}) " Register minpac

" Installed plugins
call minpac#add('tpope/vim-commentary')
call minpac#add('tpope/vim-fugitive')
call minpac#add('tpope/vim-repeat')
call minpac#add('tpope/vim-surround')
call minpac#add('tpope/vim-unimpaired')
call minpac#add('junegunn/fzf')
call minpac#add('mattn/emmet-vim')
call minpac#add('2072/PHP-Indenting-for-VIm')
call minpac#add('StanAngeloff/php.vim')
call minpac#add('itchyny/lightline.vim')
call minpac#add('tomtom/tlib_vim')
call minpac#add('MarcWeber/vim-addon-mw-utils')
call minpac#add('fatih/vim-go')
call minpac#add('garbas/vim-snipmate')
call minpac#add('honza/vim-snippets')
call minpac#add('godlygeek/tabular')
call minpac#add('shinchu/lightline-gruvbox.vim')
call minpac#add('morhetz/gruvbox')
call minpac#add('christoomey/vim-tmux-navigator')
call minpac#add('edkolev/tmuxline.vim')
call minpac#add('vimwiki/vimwiki')
" call minpac#add('plasticboy/vim-markdown')

" Define user commands for updating/cleaning the plugins.
command! PackUpdate call minpac#update()
command! PackClean call minpac#clean()

" Remappings {{{1

" Fuzzy finder (fzf using Ripgrep) {{{2
" Install Ripgrep: https://vimawesome.com/plugin/ripgrep#installation
" Using ripgrep to exclude files matched by .gitignore

" Remap ctrl+p for fzf fuzzy finder
nnoremap <C-P> :<C-u>FZF<CR>

" Leader shortcuts {{{2
:noremap <leader>ee :edit $MYVIMRC<CR>
:noremap <leader>eh :split $MYVIMRC<CR>
:noremap <leader>ev :vsplit $MYVIMRC<CR>
:noremap <leader>h :help <C-r><C-w><CR>
" Combination beginnig with [ and ] are used by vim-unimpaired

" Functions keys shortcuts {{{2
" <F2> Toggle 'paste mode' for pasting indented code {{{3
set pastetoggle=<F2>

" <F3> Switches between various line number mode {{{3
" absolute / relative / relative + absolute / no number
nnoremap <F3> :call NumberToggle()<CR>

" <F4> Retabs and removes all trailing whitespace by pressing F4 {{{3
nnoremap <F4> :retab<CR> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

" <F5> Toggles visibility of invisible characters {{{3
nnoremap <F5> :set list!<CR>

" Language specific settings {{{1
"let g:vim_markdown_folding_disabled = 1 "Disables folding in markdown files
let g:user_emmet_install_global = 0 " Disables emmet completion: it will be enabled by autocmd
let g:vim_markdown_fenced_languages = ['html=html', 'bash=sh', 'css=css']

augroup webdev
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
    autocmd FileType html,css,scss,sass,less,xml setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType html,css,php,scss,sass,less,xml,markdown EmmetInstall
    autocmd FileType html,php let g:html_indent_tags = 'li\|p'
                    " Treats <li> and <p> tags like block tags
augroup END

augroup golang
    autocmd!
    autocmd FileType go nmap <leader>r  <Plug>(go-run)
    autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
    autocmd FileType go map <C-n> :cnext<CR>
    autocmd FileType go map <C-m> :cprevious<CR>
    autocmd FileType go nnoremap <leader>a :cclose<CR>
    autocmd FileType go let g:go_list_type = "quickfix"
                    " Puts all the build issue in the quickfix-list 
    autocmd FileType go let g:go_fmt_command = "goimports"
                    " Replaces the fmt tool with goimports
augroup END
"  Vimwiki settings {{{1
let g:vimwiki_list = [{'path': '~/Documenti/Personale/vimwiki/', 'path_html': '/var/www/html/vimwiki/'}]

" Custom functions {{{1

" Toggles absolute/relative/relative+absolute/no number
function! NumberToggle()
    if(&number==1)
        set number!
        set relativenumber!
      elseif(&relativenumber==1)
        set relativenumber
        set number
      else
        set norelativenumber
        set number
    endif
endfunction

" Run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#cmd#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction
