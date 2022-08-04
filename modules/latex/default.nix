{ pkgs, config, lib, ...}:
with lib;
with builtins;

let
  cfg = config.vim.latex;
  mkIfNotNone = val: if val == "none" then null else val;
  mkVimBool = val: if val == "1" then null else "0";
in {
  options.vim.latex = {
    enable = mkEnableOption "Enable latex support";
    compiler = {
      enable = mkEnableOption "Enable compilation";
      method = mkOption {
        default = "latexmk";
        description = "compiler method used by vimtex";
        type = types.enum ["latexmk" "latexrun" "tectonic" "arara" "generic"];
      };
    };
    viewer = {
      enable = mkEnableOption "Enable pdf viewing";
      method = mkOption {
        default = "zathura";
        description = "viewer method used by vimtex";
        type = types.enum [  
          "evince"
          "mupdf"
          "okular"
          "qpdfview"
          "sioyek"
          "skim" 
          "sumatraPDF"
          "zathura"
        ];
      };
      searchOnStart = mkOption{
        default = false;
        type = types.bool;
      };
      options = mkOption {
        type = types.str;
      };
    };
  };

  config = mkIf cfg.enable {
    vim.startPlugins = with pkgs.neovimPlugins; [
      vimtex
    ];
    vim.globals = {
      "vimtex_compiler_method" = mkIfNotNone cfg.compiler.method;
      "vimtex_view_method" = mkIfNotNone cfg.viewer.method;
      "vimtex_view_automatic" = mkVimBool cfg.viewer.enable;
      "vimtex_view_forward_search_on_start" = mkVimBool cfg.viewer.searchOnStart;
      "vimtex_view_zathura_options" = mkIfNotNone cfg.viewer.options;
    };
    vim.configRC = ''
      "vimtex_view_zathura_options = '-d result/'
      "---------------------------------latex-----------------------------------
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
        
        
        "let g:vimtex_quickfix_method = 'pulp'
        "let g:vimtex_quickfix_mode = 0 " don't open window automatically
        
        let g:vimtex_syntax_enabled = 1
        let g:vimtex_syntax_conceal = {
        \ 'accents': 1,
        \ 'cites': 1,
        \ 'fancy': 1,
        \ 'greek': 1,
        \ 'math_bounds': 1,
        \ 'math_delimiters': 1,
        \ 'math_fracs': 1,
        \ 'math_super_sub': 1,
        \ 'math_symbols': 1,
        \ 'sections': 0,
        \ 'styles': 1,
        \}
      
      augroup vimtex_event_1
        au!
        au User VimtexEventQuit VimtexClean
        au User VimtexEventInitPost VimtexCompile
      augroup END
      
      if empty(v:servername) && exists('*remote_startserver')
        call remote_startserver('VIM')
      endif
      
      autocmd FileType tex set breakindent
      autocmd FileType tex nnoremap k gk
      autocmd FileType tex nnoremap j gj
      autocmd FileType tex set wrap linebreak
      
      autocmd FileType tex omap am <Plug>(vimtex-a$)
      autocmd FileType tex xmap am <Plug>(vimtex-a$)
      autocmd FileType tex omap im <Plug>(vimtex-i$)
      autocmd FileType tex xmap im <Plug>(vimtex-i$)
      
      autocmd FileType tex omap ai <Plug>(vimtex-am)
      autocmd FileType tex omap ai <Plug>(vimtex-am)
      autocmd FileType tex omap ii <Plug>(vimtex-ai)
      autocmd FileType tex omap ii <Plug>(vimtex-ai)
      
      map <leader>v <plug>(vimtex-view)
      map <leader>l <plug>(vimtex-compile)
      map <leader>e <Plug>(vimtex-errors)
      map <C-t> <plug>(vimtex-toc-toggle)

    '';
  };
}

