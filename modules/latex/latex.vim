"---------------------------------latex-----------------------------------
let g:vimtex_toc_config = {
  \ 'resize': 1,
  \ 'show_help': 0,
  \ 'tocdepth': 2,
  \ 'layer_status': {
  \    'content': 1,
  \    'include': 0,
  \    'todo': 1,
  \ },
 \ }

let g:vimtex_compiler_latexmk = {
  \ 'build_dir': 'out',
  \ 'callback' : 1,
  \ 'continuous' : 1,
  \ 'executable' : 'latexmk',
  \ 'hooks' : [],
  \ 'options' :[
  \   '-synctex=1',
  \   '-interaction=nonstopmode',
  \   '-pdf -lualatex',
  \   '-usepretex',
  \  ],
  \ }

augroup vimtex_event_1
  au!
  au User VimtexEventQuit VimtexClean
  au User VimtexEventInitPost VimtexCompile
augroup END

if empty(v:servername) && exists('*remote_startserver')
  call remote_startserver('VIM')
endif

augroup tex
  autocmd!
  autocmd FileType tex nnoremap k gk
  autocmd FileType tex nnoremap j gj
  autocmd FileType tex set wrap breakindent

  autocmd FileType tex omap am <Plug>(vimtex-a$)
  autocmd FileType tex xmap am <Plug>(vimtex-a$)
  autocmd FileType tex omap im <Plug>(vimtex-i$)
  autocmd FileType tex xmap im <Plug>(vimtex-i$)

  autocmd FileType tex omap ai <Plug>(vimtex-am)
  autocmd FileType tex omap ai <Plug>(vimtex-am)
  autocmd FileType tex omap ii <Plug>(vimtex-ai)
  autocmd FileType tex omap ii <Plug>(vimtex-ai)
augroup END
