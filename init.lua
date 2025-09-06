--
-- options
--

vim.opt.mouse = ""

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.undofile = true
vim.opt.swapfile = false

vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- share clipboard
vim.opt.clipboard = "unnamedplus"

vim.opt.signcolumn = "yes"

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.scrolloff = 8

vim.opt.inccommand = "split"

vim.opt.winborder = "rounded"

vim.diagnostic.config({ virtual_text = true })

-- highlight on yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = "*",
})

--
-- keymaps
--

vim.g.mapleader = " "

-- vim.keymap.set("n", "<leader>o", ":update<CR> :source<CR> :nohlsearch<CR>")

vim.keymap.set("n", "<leader>w", ":write<CR>")
vim.keymap.set("n", "<leader>q", ":quit<CR>")

vim.keymap.set("n", "<Esc>", ":nohlsearch<CR>")

vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

vim.keymap.set("n", "<C-k>", "<C-w><C-k>")
vim.keymap.set("n", "<C-l>", "<C-w><C-l>")
vim.keymap.set("n", "<C-j>", "<C-w><C-j>")
vim.keymap.set("n", "<C-h>", "<C-w><C-h>")

--
-- plugins
--

vim.pack.add({
    -- colorscheme
    { src = "https://github.com/ellisonleao/gruvbox.nvim" },

    -- lsp
    { src = "https://github.com/neovim/nvim-lspconfig" },

    -- oil file explorer
    { src = "https://github.com/stevearc/oil.nvim" },

    -- dependency for telescope
    { src = "https://github.com/nvim-lua/plenary.nvim" },

    -- searching
    { src = "https://github.com/nvim-telescope/telescope.nvim" },

    -- gitsigns
    { src = "https://github.com/lewis6991/gitsigns.nvim" },

    -- lsps, linter, formatter
    { src = "https://github.com/mason-org/mason.nvim" },

    -- auto complete
    {
        src = "https://github.com/saghen/blink.cmp",
        version = vim.version.range("1.*")
    },

})

vim.cmd.colorscheme("gruvbox")

require("telescope").setup()
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>f", builtin.find_files)
vim.keymap.set("n", "<leader>g", builtin.live_grep)
vim.keymap.set("n", "gd", builtin.lsp_definitions)
vim.keymap.set("n", "<leader>d", builtin.diagnostics)
vim.keymap.set("n", "gr", builtin.lsp_references)
vim.keymap.set("n", "gi", builtin.lsp_implementations)

require("oil").setup()
vim.keymap.set("n", "<leader>o", ":Oil<CR>")

require("mason").setup()
vim.keymap.set("n", "cm", ":Mason<CR>")

vim.keymap.set("n", "gba", ":Gitsigns blame<CR>")
vim.keymap.set("n", "gbl", ":Gitsigns blame_line<CR>")

require("blink.cmp").setup({
    keymap = {
        preset = "default",
        ["<C-c>"] = { "select_and_accept", "fallback" },
    },
    appearance = {
        nerd_font_variant = "mono"
    },
    completion = {
        documentation = {
            auto_show = true
        },
        ghost_text = {
            enabled = true
        }
    },
    sources = {
        default = { "lsp", "path", "snippets", "buffer" }
    },
    fuzzy = {
        implementation = "lua"
    }
})

vim.lsp.enable({
    "lua_ls",
    "rust_analyzer",
    "omnisharp",
    "typescript-language-server"
})

vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
            }
        }
    }
})

vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format)
vim.keymap.set('n', 'gs', vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename)
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)
