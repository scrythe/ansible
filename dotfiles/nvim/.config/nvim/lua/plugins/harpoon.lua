return {
  "ThePrimeagen/harpoon",
  config = function()
    local mark = require("harpoon.mark")
    local ui = require("harpoon.ui")

    vim.keymap.set("n", "<leader>a", mark.add_file, { desc = "Add to Harpoon List" })
    vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu, { desc = "Open Harpoon List" })

    vim.keymap.set("n", "<C-h>", function()
      ui.nav_file(1)
    end, { desc = "Goto 1 Harpoon Item" })
    vim.keymap.set("n", "<C-t>", function()
      ui.nav_file(2)
    end, { desc = "Goto 1 Harpoon Item" })
    vim.keymap.set("n", "<C-n>", function()
      ui.nav_file(3)
    end, { desc = "Goto 1 Harpoon Item" })
    vim.keymap.set("n", "<C-s>", function()
      ui.nav_file(4)
    end, { desc = "Goto 1 Harpoon Item" })
  end,
}
