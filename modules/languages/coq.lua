vim.g.coq_settings = {
  xdg = true,
  auto_start = 'shut-up',
  keymap = {
    pre_select = true,
    jump_to_mark = "<C-Space>",
  },
  display = {
    pum = {
      fast_close = false,
      source_context = {":: ",""},
    },
    icons = {
      mode = "none"
    },
    ghost_text = {
      enabled = false
    },
    preview = {
      border  = "solid",
      positions = {north = 4, south = 2, west = 3, east = 1}
    }
  },
  clients = {
    snippets = {
      user_path = '~/.config/nvim/snippets',
    },
  },
}
