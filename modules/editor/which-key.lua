local wk = require("which-key")

wk.register({
  w = {
    name = "window",
    c = { "Close Window"},
    h = { "Split Horizontal" },
    v = { "Split Vertical" },
  },
}, { prefix = "<leader>" })
