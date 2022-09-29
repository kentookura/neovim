"	        _
"	 __   _(_)_ __ ___  _ __ ___ 
"	 \ \ / / | '_ ` _ \| '__/ __|
"	  \ V /| | | | | | | | | (__ 
"	   \_/ |_|_| |_| |_|_|  \___|


set autoread
set termguicolors
set laststatus=2
set clipboard+=unnamedplus
set encoding=utf-8
set fileencoding=utf-8
set foldmethod=syntax
set hidden
set nowrap
set noshowmode
set hlsearch
set ignorecase smartcase
set expandtab ts=2 sts=2 sw=2
set autoindent
set smarttab
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=2
set nobackup
set noswapfile
set nowritebackup
set path+=**
set so=10
set splitbelow
set splitright
set wildignore+=*.opus,*.flac,*.pdf,*.jpg,*.png,*.so,*.swp,*.zip,*.gzip,*.bz2,*.tar,*.xz,*.lrzip,*.lrz,*.mp3,*.ogg,*.mp4,*.gif,*.jpeg,*.webm,*.hi,*.o
set wildmenu
set lazyredraw
set magic
set showmatch
set mat=2
set backspace=indent,eol,start
set nu rnu
set wrap breakindent linebreak

colorscheme everforest

filetype indent plugin off
syntax on
let mapleader = " "
autocmd FocusGained, BufEnter * checktime
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!
nnoremap ! :!
runtime macros/matchit.vim
highlight SignColumn guibg=bg

"augroup AutoCD
"  autocmd BufRead vimrc,home.nix silent! lcd %:p:h
"  autocmd BufRead xmonad.hs silent! lcd %:p:h
"augroup END


try
  set undodir=~/.vim_runtime/temp_dirs/undodir
  set undofile
endtry

" open help vertically
command! -nargs=* -complete=help Help vertical belowright help <args>
autocmd FileType help wincmd L

map <leader>n :setlocal nu! rnu!<CR>

map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
map <leader>t<leader> :tabnext<cr>

nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
"au TabLeave * g:lasttab = tabpagenr()

"-------------------------------------remaps-------------------------------
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

nnoremap <NL> i<CR><ESC>

" movement
nnoremap <C-H> <C-W><C-H>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>

inoremap <C-H> <C-o>h
inoremap <C-J> <C-o>j
inoremap <C-K> <C-o>k
inoremap <C-L> <C-o>l

nnoremap c* /\<<C-R>=expand('<cword>')<CR>\>/C<CR>``cgn
nnoremap c# ?\<<C-R>=expand('<cword>')<CR>\>/C<CR>``cgN


function! VisualSelection(direction, extra_filter) range
  let l:saved_reg = @"
  execute "normal! vgvy"

  let l:pattern = escape(@", "\\/.*'$^~[]")
  let l:pattern = substitute(l:pattern, "\n$", "", "")

  if a:direction == 'gv'
      call CmdLine("Ack '" . l:pattern . "' " )
  elseif a:direction == 'replace'
      call CmdLine("%s" . '/'. l:pattern . '/')
  endif

  let @/ = l:pattern
  let @" = l:saved_reg
endfunction

map <silent> <cr> :noh<cr>

map <leader>cd :cd %:p:h<cr>:pwd<cr>
map <leader>te :tabedit <C-r>=expand("%:p:h")<cr>/

inoremap <C-h> <C-o>h
inoremap <C-j> <C-o>j
inoremap <C-k> <C-o>k
inoremap <C-l> <C-o>a

nnoremap - :vertical resize -5<CR>
nnoremap = :vertical resize +5<CR>
nnoremap _ :bel resize +5<CR>
nnoremap + :bel resize -5<CR>

map <C-f> :Files<CR>
map <C-b> :Buffers<CR>

let g:ackprg = 'ag --vimgrep'
let javaScript_fold=1
set fillchars+=eob:\ 


"----------------------------------autocmds--------------------------------

autocmd VimEnter * wincmd p
autocmd BufNewFile,BufRead *.md let maplocalleader = "\\"

"----------------------------markdown/pandoc------------------------------

augroup pandoc_syntax
  au! BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc tw=80
augroup END

