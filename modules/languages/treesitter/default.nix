{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
with builtins; let
  cfg = config.vim.treesitter;
in {
  options.vim.treesitter = {
    enable = mkEnableOption "Enable Treesitter support";
  };
  config = {
    vim.startPlugins = with pkgs.neovimPlugins; [
      nvim-treesitter
      nvim-treesitter-context
      nvim-treesitter-refactor
      nvim-treesitter-textobjects
    ];
    vim.luaConfigRC = ''
      local parser_install_dir = vim.fn.stdpath("cache") .. "/treesitters"
      vim.fn.mkdir(parser_install_dir, "p")
       
        -- In your treesitter config,
      require'nvim-treesitter.configs'.setup {
        parser_install_dir = parser_install_dir,
        ensure_installed = { "lua", "vim", "haskell", "html" },
        --ensure_installed = "all",
      
        highlight = {
          -- `false` will disable the whole extension
          enable = true,
      
          -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
          -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
          -- the name of the parser)
          -- list of language that will be disabled
          -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
          disable = function(lang, buf)
              local max_filesize = 100 * 1024 -- 100 KB
              local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
              if ok and stats and stats.size > max_filesize then
                  return true
              end
          end,
      
          -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
          -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
          -- Using this option may slow down your editor, and you may see some duplicate highlights.
          -- Instead of true it can also be a list of languages
          additional_vim_regex_highlighting = false,
        },
      }'';
  };
}
