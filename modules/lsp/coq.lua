vim.g.coq_settings = {
  xdg = true,
  auto_start = 'shut-up',
  keymap = {
    pre_select = true,
    jump_to_mark = "<C-Space>",
  },
  display = {
    icons = {
      mode = "short"
    },
    --ghost_text = {
    --  context = [" [", "] "]
    --},
  },
  clients = {
    snippets = {
      user_path = '~/.config/nvim/snippets',
    },
  },
}
