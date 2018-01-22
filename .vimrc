" GENERAL SETTINGS {{{1
syntax enable       " Enable syntax highlight
set filetype=on     " Enable filetype specific settings
filetype plugin on  " Load the plugin files for the file types 
filetype indent on  " Load the indent file for the file types
set encoding=utf8   " Set default encoding
set history=700     " Sets how many lines of history to remember
set showmatch       " When a bracket is inserted, show the matching one
set scrolloff=2     " Set scroll offset 2 lines from the cursor when moving vertically
set ttimeoutlen=50  " Make Esc work faster

" Backup Settings {{{2
" I prefer do not keep a backup file
set nobackup        " Don't write a permanent backup before overwrite a file
set nowritebackup   " Don't write a temporary backup before overwrite a file

" Automatic action {{{2
set autoread        " Re-read the file when is changed from outside
set autowrite       " Write the buffer on :next, :last, :make, etc...

" SPACE, TABS AND INDENTETION {{{1
set expandtab       " Tabs are spaces
set tabstop=4       " Number of visual spaces per tab
set softtabstop=4   " Number of spaces in tab when editing
set shiftwidth=4    " Number of spaces to use for each step of (auto)indent
set smarttab        " Automatically insert the right type of <tab>
set autoindent      " Copy indent from current line when starting a new line
set smartindent     " Autoindenting when starting a new line of code
set wrap            " Wrap lines longer than the width of the window


" SEARCH SETTINGS {{{1
set hlsearch        " Highlight all matches of previous search pattern
set ignorecase      " Perform case insensitive search 
set incsearch       " While typing, show if the pattern is matched
set lazyredraw      " Redraw the screen only when necessary
set magic           " Define how special characters are interpreted in pattern 
set smartcase       " Override ignorecase when search contain uppercase characters
set wildmenu        " enhanced mode for command-line completion
set completeopt=longest,menuone 
                    " Menu autocomplete (Ctrl+n) - richiede exuberant-ctags
" UI CONFIGURATION {{{1
set background=dark " Set dark/light background for syntax highlighting
set title           " Show filename in window's title
set ruler           " Show the line and column number of cursor position
set cmdheight=1     " Number of screen lines to use for the command-line
set cursorline      " Highlight the current line 
set number          " Show line numbers
set t_Co=256        " Number of colors
if &term =~ '256color'
    set t_ut=       " Clearing uses the current background color
endif
colorscheme dracula " My favorite dark color scheme
set laststatus=2    " Show status line on every open windows
set noshowmode      " Don't display mode because it's in lightline

set list            " Show invisibles characters
set listchars=tab:▸\ ,eol:¬
                    " Define personal symbol for invisibles characters

" Lightline configuration {{{2
let g:lightline = {
    \ 'colorscheme': 'Dracula',
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

" MINPAC PACKAGE MANAGER {{{1
" For a paranoia.
" Normally `:set nocp` is not needed, because it is done automatically
" when .vimrc is found.
if &compatible
    " `:set nocp` has many side effects. Therefore this should be done
    " only when 'compatible' is set.
    set nocompatible
endif

packadd minpac
call minpac#init()
call minpac#add('k-takata/minpac', {'type': 'opt'}) " Register minpac

" Additional plugins
call minpac#add('2072/PHP-Indenting-for-VIm')
call minpac#add('JamshedVesuna/vim-markdown-preview')
call minpac#add('MarcWeber/vim-addon-mw-utils')
call minpac#add('StanAngeloff/php.vim')
call minpac#add('fatih/vim-go')
call minpac#add('garbas/vim-snipmate')
call minpac#add('honza/vim-snippets')
call minpac#add('itchyny/lightline.vim')
call minpac#add('mattn/emmet-vim')
call minpac#add('tomtom/tlib_vim')
call minpac#add('tpope/vim-commentary')
call minpac#add('tpope/vim-fugitive')
call minpac#add('tpope/vim-repeat')
call minpac#add('tpope/vim-surround')
call minpac#add('tpope/vim-unimpaired')
call minpac#add('vimwiki/vimwiki')

" Define user commands for updating/cleaning the plugins.
command! PackUpdate call minpac#update()
command! PackClean call minpac#clean()

" REMAPPING {{{1
" Leader shortcuts {{{2
:noremap <leader>ee :edit $MYVIMRC<CR>
:noremap <leader>eh :split $MYVIMRC<CR>
:noremap <leader>ev :vsplit $MYVIMRC<CR>
:noremap <leader>h :help <C-r><C-w><CR>
" Combination beginnig with [ and ] are used by vim-unimpaired

" Function keys shortcuts {{{2
" <F2> Toggle 'paste mode' for pasting indented code {{{3
set pastetoggle=<F2>

" <F3> Switch between various line number mode {{{3
" absolute / relative / relative + absolute / no number
nnoremap <F3> :call NumberToggle()<CR>

" <F4> Retab and remove all trailing whitespace by pressing F4 {{{3
nnoremap <F4> :retab<CR> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

" <F5> Toggle visibility of invisible characters {{{3
nnoremap <F5> :set list!<CR>

" LANGUAGE SPECIFIC SETTINGS {{{1
let g:user_emmet_install_global = 0 " Disable emmet completion: it will be enabled by autocmd

augroup configgroup
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
    autocmd FileType html,css,scss,sass,xml setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType html,css,php,scss EmmetInstall
    autocmd FileType html,php let g:html_indent_tags = 'li\|p'
                    " Treat <li> and <p> tags like block tags
    autocmd FileType go nmap <leader>r  <Plug>(go-run)
    autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
    autocmd FileType go map <C-n> :cnext<CR>
    autocmd FileType go map <C-m> :cprevious<CR>
    autocmd FileType go nnoremap <leader>a :cclose<CR>
    autocmd FileType go let g:go_list_type = "quickfix"
                    " Put all the build issue in the quickfix-list 
    autocmd FileType go let g:go_fmt_command = "goimports"
                    " Replace the fmt tool with goimports
augroup END

" CUSTOM FUNCTIONS {{{1
" Toggle absolute/relative/relative+absolute/no number
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

"  VIMWIKI SETTINGS {{{1
let g:vimwiki_list = [{'path': '~/Documenti/Personale/vimwiki/', 'path_html': '/var/www/html/vimwiki/'}]
