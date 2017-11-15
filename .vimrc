execute pathogen#infect()

syntax enable


" {{{1 Enable filetype specific settings
set filetype=on

" {{{1 Set UTF-8 as standard encoding
set encoding=utf8

" {{{1 Use Unix as the standard file type
set ffs=unix,dos,mac

" {{{1 Edit .vimrc in a vertical split window
:noremap <leader>ev :vsplit $MYVIMRC<cr>

" {{{1 Airline settings and font if the GUI is running
if has("gui_running")
    " let's set a good-looking font
    set guifont=Source\ Code\ Pro\ for\ Powerline\ Regular\ 11
    " airline theme settings
    let g:airline_powerline_fonts = 1
    let g:airline_theme='dracula'
else
    let g:airline_powerline_fonts = 1
    let g:airline_theme='dracula'
endif

" {{{1 Do not keep a backup files
set nobackup
set nowritebackup

" {{{1 Sets how many lines of history VIM has to remember
set history=700

" {{{1 Enable filetype plugins
filetype plugin on
filetype indent on

" {{{1 Set to auto read when a file is changed from the outside
set autoread

" {{{1 Writes the content of the file automatically when calling :make
set autowrite

" {{{1 <F2> Temporarily switch to "paste mode" for pasting indented code
set pastetoggle=<F2>

" {{{1 <F3> Switch between various line number mode
" absolute / relative / relative + absolute / no number
" Default is absolute number
set number
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
nnoremap <F3> :call NumberToggle()<CR>


" {{{1 <F4> Retab and remove all trailing whitespace by pressing F4
nnoremap <F4> :retab<CR> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

" {{{1 <F5> Toggle visibility of invisible characters
nnoremap <F5> :set list!<CR>

" {{{1 various theme options (to move in GUI section)
set background=dark title ruler cmdheight=1
set cursorline
set t_Co=256
if &term =~ '256color'
    set t_ut=
endif
colorscheme dracula
set laststatus=2

" {{{1 Show the matching bracket for the last ')'?
set showmatch

" {{{1 Don't display mode
set noshowmode

" {{{1 Set status line
" Disabled in favor to airline
"set statusline=[%02n]\ %f\ %(\[%M%R%H]%)%=\ %4l,%02c%2V\ %P%*

set hlsearch ignorecase incsearch lazyredraw  magic smartcase

" {{{1 Show invisibles characters
set list
set listchars=tab:▸\ ,eol:¬
set expandtab

" {{{1 Be smart when using tabs ;)
set smarttab

" {{{1 Default indentation: 1 tab == 4spaces
" ts>tabstop, sts->softtabstop, sw->shiftwidth
" expandtab > Use spaces instead of tabs
set ts=4 sts=4 sw=4 expandtab

" {{{1 Settings for web related filetype
autocmd FileType html,css,scss,sass,xml setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType vim setlocal foldmethod=marker

" {{{1 Settings for Golang environment
" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#cmd#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

autocmd FileType go nmap <leader>r  <Plug>(go-run)
autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
" Put all the build issue in the quickfix-list for better navigate them
let g:go_list_type = "quickfix"
autocmd FileType go map <C-n> :cnext<CR>
autocmd FileType go map <C-m> :cprevious<CR>
autocmd FileType go nnoremap <leader>a :cclose<CR>
" Replace the fmt tool with goimports
let g:go_fmt_command = "goimports"


" {{{1 Treat .rss and .atom file as XML
" autocmd Bufnewfile,BufRead *.rss,*.atom setfiletype xml

" {{{1 Indentation settings
set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

" {{{1 Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" {{{1 Turn on the WiLd menu
set wildmenu

" {{{1 Menu autocomplete (Ctrl+n) - richiede exuberant-ctags
set completeopt=longest,menuone

" {{{1 Set a short ttimeout to increase airline mode switching speed
set ttimeout
set ttimeoutlen=50

" {{{1 Enable emmet only for certain filetype
let g:user_emmet_install_global = 0

autocmd FileType html,css,php,scss EmmetInstall

" {{{1 Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'
