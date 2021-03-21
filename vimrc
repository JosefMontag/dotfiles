" For Vundle {{{1

set nocompatible               " Vundle required, be iMproved
filetype off                   " Vundle required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'     " Vundle required let Vundle manage Vundle
Plugin 'vim-scripts/xoria256.vim'
Plugin 'lervag/vimtex'
" Plugin 'Shougo/deoplete.nvim'
" Plugin 'roxma/nvim-yarp'
" Plugin 'roxma/vim-hug-neovim-rpc'
Plugin 'tomtom/tcomment_vim'
Plugin 'jalvesaq/Nvim-R'
Plugin 'gpanders/vim-oldfiles'
Plugin 'reedes/vim-pencil'
Plugin 'jceb/vim-orgmode'
call vundle#end() 

filetype on               " Vundle required
filetype plugin on        " Vundle required
filetype plugin indent on " Vundle required  

" Editing {{{1

" Automatically change the current directory
set autochdir

"" Set tab to 2 spaces
set tabstop=2	
set shiftwidth=2
set softtabstop=2
set expandtab
set autoindent

" Set spellcheck by default
set spell spelllang=en_us 

" Sets syntax folding and highlighting
set foldmethod=marker 
syntax on

" Preview PDFs
augroup pdf
  autocmd FileType markdown nmap ,v :execute '!zathura' 
                                     \ expand('%<:p') . '.pdf &' <cr><cr>
  autocmd FileType markdown nmap ,t :execute '!pandoc -s' expand('%:p')
                                     \ '-o' expand('%<:p') . '.pdf &' <cr><cr>
  autocmd FileType tex nmap ,v :VimtexView<cr>
augroup END

" Set PencilSoft
let g:pencil#wrapModeDefault = 'soft'
augroup pencil
  autocmd!
  autocmd FileType markdown call pencil#init()
  autocmd FileType tex call pencil#init()
  autocmd FileType txt call pencil#init()
augroup END

" Setup undo and file history
set undofile                             " Tell it to use an undo file
" set undodir=~/dotfiles/vim/undo/ " Set directory for undo history
set viminfo+=n~/.vim/viminfo

" Autosave 
let updatetime=10
autocmd CursorHold * update
set hidden
set autowrite
" let g:auto_save=0
" let g:auto_save_in_insert_mode=0
" let g:auto_save_no_updatetime=0
" autocmd FileType tex let g:auto_save=0

" Latex
" let g:vimtex_view_general_viewer = 'zathura'
let g:vimtex_view_method = 'zathura'
let g:tex_flavor = 'latex'
" let g:tex_conceal = ""
" This is new style
" This is new style
" call deoplete#custom#var('omni', 'input_patterns', {
"       \ 'tex': g:vimtex#re#deoplete
"       \})
" let g:deoplete#enable_at_startup = 1

" Remappings: {{{1

iab align \begin{align*}<cr><cr>\end{align*}<up>

nmap <silent> ,du :set hls<cr> /\(\<\w\+\>\)\_s*\1<cr> " Find duplicated words

" System default for mappings is now the "," character
let mapleader = ","

" Edit and source .vimrc file
nmap <silent> ,ev :e $MYVIMRC <cr>
nmap <silent> ,sv :so $MYVIMRC<cr>

" cd to the directory containing the file in the buffer
nmap ,cd :lcd %:h<cr>

" list buffers
nmap ,ls :ls<cr>

" Toggle paste mode
" nmap  ,p :set invpaste ":set paste?

" Turn off that stupid highlight search
" set nohlsearch
" nmap  ,n :set invhls<cr>

" cd to the directory containing the file in the buffer
nmap  ,cd :lcd %:h \| pwd<cr>

" Move the cursor to the window left of the current one
noremap <silent> ,h :wincmd h<cr>

" Move the cursor to the window below the current one
noremap <silent> ,j :wincmd j<cr>

" Move the cursor to the window above the current one
noremap <silent> ,k :wincmd k<cr>

" Move the cursor to the window right of the current one
noremap <silent> ,l :wincmd l<cr>

" Make the current window the only one
noremap <silent> ,o <C-W>o

" Close the current window
noremap <silent> ,cc :close<cr>

" Close the current window
noremap <silent> ,bw :bw<cr>

" Insert space
nmap <silent> ,<space> i<space><esc>l

" Browse old
" nmap <silent> ,b :Oldfiles<cr><cr>
nmap <silent> ,b :bro ol<cr>
" Make buff with Old disappear after selection
" augroup oldfiles
"     autocmd!
"     autocmd FileType qf autocmd WinLeave <buffer> if getqflist({'title': 0}).title =~# 'Oldfiles' | cclose | endif
" augroup END

" Match parentheses, quotes
" inoremap " ""<left>
" inoremap ' ''<left>
" inoremap ( ()<left>
" inoremap [ []<left>
" inoremap { {}<left>
" inoremap {<CR> {<CR>}<ESC>O
" inoremap {;<CR> {<CR>};<ESC>O

" GUI appearance {{{1

" winpos 0 0                        " Put Vim in top left corner
set guioptions=aAcg               " Hide menu buttons, etc.
set textwidth=80
set columns=80
set lines=49
" call system('wmctrl -ir '.v:windowid . '-b maximized_vert' )

set guifont=Inconsolata-dz\ 14
" set guifont=Font\ Awesome\ 14
set antialias
colorscheme xoria256 

" Set height of command line
set cmdheight=1

"set nojoinspaces
set vb                            " set visual bell
set mousehide                     " Hide the mouse pointer while typing


" Set the status line the way I like it
set laststatus=2
let g:airline_theme='raven'
let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#left_sep = ' '
" let g:airline#extensions#tabline#left_alt_sep = '|'
" set stl=%f\ %m\ %r\ Line:\ %l/%L[%p%%]\ Col:\ %c\ Buf:\ #%n\ [%b][0x%B]

set wildchar=<Tab> wildmenu wildmode=full
" set wildcharm=<C-Z>
nnoremap <Tab> :b 
nnoremap <S-Tab> :b#<cr> 

" Vim-R integration {{{1
let R_external_term = 'xterm'
let R_in_buffer=0
let R_applescript = 0
let R_in_buffer = 0
let R_assign_map = '<C-,>'
imap <C-.> <space>%>%<space>

nmap ,r <Plug>RStart
vmap <C-CR> \se<esc>
nmap <C-CR> V\se<esc>

" For Markdown {{{1
" map ,p :execute '!pandoc' '"' . expand('%:p') . '" -o "'. expand('%<:p') . '.pdf' . '" -t beamer' <cr> 
map ,p :execute '!pandoc' '"' . expand('%:p') . '" -o "'. expand('%<:p') . '.pdf' . '" --citeproc' <cr>
