{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
with builtins; let
  cfg = config.vim.editor;
in {
  options.vim.editor = {
    indentGuide = mkEnableOption "Enable indent guides";
    underlineCurrentWord = mkEnableOption "Underline the word under the cursor";
    format = mkEnableOption "Enable autoformat";
    fzf = mkOption {
      description = "Enable fzf";
      type = types.bool;
      default = true;
    };

    colourPreview = mkOption {
      description = "Enable colour previews";
      type = types.bool;
      default = true;
    };
  };

  config = {
    vim.startPlugins = with pkgs.neovimPlugins; [
      (
        if cfg.format
        then neoformat
        else null
      )
      (
        if cfg.fzf
        then fzf
        else null
      )
      (
        if cfg.fzf
        then fzf-vim
        else null
      )
      nvim-which-key
      vim-nix
    ];

    vim.nnoremap = {
      "<leader>wc" = "<cmd>close<cr>";
      "<leader>wh" = "<cmd>split<cr>";
      "<leader>wv" = "<cmd>vsplit<cr>";
    };

    vim.luaConfigRC = ''
      local wk = require("which-key")

      wk.register({
        w = {
          name = "window",
          c = { "Close Window"},
          h = { "Split Horizontal" },
          v = { "Split Vertical" },
        },
      }, { prefix = "<leader>" })

    '';

    vim.configRC = ''

        "${
        if cfg.fzf
        then ''
          let g:fzf_action = {
            \ 'ctrl-t': 'tab split',
            \ 'ctrl-x': 'split',
            \ 'ctrl-v': 'vsplit' }
          let g:fzf_history_dir = '~/.local/share/fzf-history'
          let g:fzf_tags_command = 'ctags -R'
          let g:fzf_layout = {'up':'~90%', 'window': { 'width': 0.8, 'height': 0.8,'yoffset':0.5,'xoffset': 0.5, 'highlight': 'Todo', 'border': 'sharp' } }
          let $FZF_DEFAULT_OPTS = '--layout=reverse --info=inline' "might add --no-unicode
          let $FZF_DEFAULT_COMMAND="rg --files"

          let g:fzf_colors =
          \ { 'fg':      ['fg', 'Normal'],
            \ 'bg':      ['bg', 'Normal'],
            \ 'hl':      ['fg', 'Comment'],
            \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
            \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
            \ 'hl+':     ['fg', 'Statement'],
            \ 'info':    ['fg', 'PreProc'],
            \ 'border':  ['fg', 'Ignore'],
            \ 'prompt':  ['fg', 'Conditional'],
            \ 'pointer': ['fg', 'Exception'],
            \ 'marker':  ['fg', 'Keyword'],
            \ 'spinner': ['fg', 'Label'],
            \ 'header':  ['fg', 'Comment'] }

          "Get Files
          command! -bang -nargs=? -complete=dir Files
              \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)

          " Get text in files with Rg
          command! -bang -nargs=* Rg
            \ call fzf#vim#grep(
            \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
            \   fzf#vim#with_preview(), <bang>0)

          " Ripgrep advanced
          function! RipgrepFzf(query, fullscreen)
            let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
            let initial_command = printf(command_fmt, shellescape(a:query))
            let reload_command = printf(command_fmt, '{q}')
            let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
            call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
          endfunction

          command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

          " Git grep
          command! -bang -nargs=* GGrep
            \ call fzf#vim#grep(
            \   'git grep --line-number '.shellescape(<q-args>), 0,
            \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)
        ''
        else ""
      }"

        "${
        if cfg.format
        then ''
          augroup fmt
          autocmd!
          autocmd BufWritePre * undojoin | Neoformat
          augroup END
        ''
        else ""
      }

      map <C-f> :Files<CR>
      map <leader>b :Buffers<CR>
      nnoremap <leader>g :Rg<CR>
      nnoremap <leader>G :GGrep<CR>


      ${
        if cfg.indentGuide
        then ''
          let g:indentLine_enabled = 1
          set list lcs=tab:\|\
        ''
        else ""
      }
    '';
  };
}
