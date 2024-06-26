return {

	-- This is currently broken. For some reason cmake could not find my C compiler (which I definitely have installed)
  -- {
  --     "nvim-telescope/telescope-fzf-native.nvim",
  --     build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
  -- },
	{
		"nvim-telescope/telescope-fzy-native.nvim",
	},
	{
		"nvim-telescope/telescope.nvim",
		name = "telescope",
		event = "VeryLazy",
		branch = "0.1.x",
		lazy = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			local telescope = require("telescope")
			local actions = require("telescope.actions")

			telescope.setup({
				defaults = {
					path_display = { "truncate" },
					mappings = {
						i = {
							["<C-k>"] = actions.move_selection_previous,
							["<C-j>"] = actions.move_selection_next,
							["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
						},
					},
				},
				extensions = {
					fzf = {
						fuzzy = true,
						override_generic_sorter = true,
						override_file_sorter = true,
						case_mode = "smart_case",
					},
					fzy_native = {
						override_generic_sorter = false,
						override_file_sorter = true,
					},
				},
			})

			telescope.load_extension("fzy_native")

			-- Configure keybinds here - configuring in other files doesn't seem to work right.
			-- Supposedly this is due to lazy loading, but I've disabled that.
			local keys = vim.keymap
			local builtin = require("telescope.builtin")
			keys.set("n", "<leader>ff", builtin.git_files, {})
			keys.set("n", "<leader>fg", builtin.find_files, {}) -- think "no git"
      keys.set("n", "<leader>ft", builtin.treesitter, {}) 
      keys.set("n", "<leader>fh", builtin.commands, {})
      keys.set("n", "<leader>fk", builtin.keymaps, {})
      keys.set("n", "<leader>fcc", builtin.command_history, {})
		end,
	},
}
