vim.g.mapleader = " "
local keymaps = {
	{ "n",          "J",         "mzJ'z" },
	{ "n",          "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]] },
	{ "n",          "<C-u>",     "<C-u>zz" },
	{ "n",          "<C-d>",     "<C-d>zz" },

	{ "n",          "<M-k>",     "<cmd>cprevious<CR>" },
	{ "n",          "<M-j>",     "<cmd>cnext<CR>" },
	{ "n",          "<M-c>",     "<cmd>cclose<CR>" },

	{ "v",          "<leader>p", [["_dP]] },
	{ { "n", "v" }, "<leader>d", "\"_d" },

	{ "v",          "K",         ":m '<-2<CR>gv=gv" },
	{ "v",          "J",         ":m '>+1<CR>gv=gv" },
	{ "v",          "<",         "<gv^" },
	{ "v",          ">",         ">gv^" },
}

for _, keymap in pairs(keymaps) do
	vim.keymap.set(keymap[1], keymap[2], keymap[3])
end
