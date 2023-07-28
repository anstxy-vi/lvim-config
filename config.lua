-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Example configs: https://github.com/LunarVim/starter.lvim
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny
--

-- Enable powershell as your default shell
vim.opt.shell = "pwsh.exe"
vim.opt.shellcmdflag =
"-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
vim.cmd [[
        let &shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
        let &shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
        set shellquote= shellxquote=
        ]]

-- lvim telescope
lvim.builtin.telescope.on_config_done = function(telescope)
    pcall(telescope.load_extension, "frecency")
    pcall(telescope.load_extension, "neoclip")
    -- any other extensions loading
end

-- vim set
vim.wo.relativenumber = true
vim.opt.cmdwinheight = 2
vim.opt.autoindent = true
vim.opt.cindent = true
vim.opt.smartindent = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4

lvim.colorscheme = 'kanagawa'

lvim.format_on_save.enabled = true

lvim.builtin.which_key.mappings["S"]= {
    name = "Session",
    c = { "<cmd>lua require('persistence').load()<cr>", "Restore last session for current dir" },
    l = { "<cmd>lua require('persistence').load({ last = true })<cr>", "Restore last session" },
    Q = { "<cmd>lua require('persistence').stop()<cr>", "Quit without saving session" },
}

lvim.builtin.which_key.mappings["D"] = {
    name = "Dodument Generate",
    G = { "<cmd>DogeGenerate<cr>", "generate comment"}
}

--[[ lvim.builtin.lualine.sections = {
    lualine_a = {'branch'},
    lualine_b = {{'filename', file_status = true, newfile_status = true, path = 1}},
    lualine_c = {{'diff', colored = true}},
    lualine_x = {'diagnostics', 'encoding', 'fileformat', 'filetype', 'filesize'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
} ]]

-- Set a compatible clipboard manager
vim.g.clipboard = {
    copy = {
        ["+"] = "win32yank.exe -i --crlf",
        ["*"] = "win32yank.exe -i --crlf",
    },
    paste = {
        ["+"] = "win32yank.exe -o --lf",
        ["*"] = "win32yank.exe -o --lf",
    },
}

-- Plugins
lvim.plugins = {
    {
        "Pocco81/auto-save.nvim",
        config = function()
            require("auto-save").setup()
        end,
    },
    {
        "norcalli/nvim-colorizer.lua",
        config = function()
            require("colorizer").setup({ "css", "less", "typescript", "tsx", "scss", "html", "javascript" }, {
                RGB = true, -- #RGB hex codes
                RRGGBB = true, -- #RRGGBB hex codes
                RRGGBBAA = true, -- #RRGGBBAA hex codes
                rgb_fn = true, -- CSS rgb() and rgba() functions
                hsl_fn = true, -- CSS hsl() and hsla() functions
                css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
                css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
            })
        end,
    },
    {
        "ray-x/lsp_signature.nvim",
        event = "BufRead",
        config = function() require"lsp_signature".on_attach() end,
    },
    {
        "windwp/nvim-spectre",
        event = "BufRead",
        lazy = true,
        cmd = { "Spectre" }, 
        config = function()
            require("spectre").setup()
        end,
    },
    {
        "folke/persistence.nvim",
        event = "BufReadPre", -- this will only start session saving when an actual file was opened
        opts = {
            -- add any custom options here
        }
    },
    {
        "ethanholz/nvim-lastplace",
        event = "BufRead",
        config = function()
            require("nvim-lastplace").setup({
                lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
                lastplace_ignore_filetype = {
                    "gitcommit", "gitrebase", "svn", "hgcommit",
                },
                lastplace_open_folds = true,
            })
        end,
    },
    {
        "windwp/nvim-ts-autotag",
        config = function()
            require("nvim-ts-autotag").setup()
        end,
    },
    {
        "rmagatti/goto-preview",
        config = function()
            require('goto-preview').setup {
                width = 120; -- Width of the floating window
                height = 25; -- Height of the floating window
                default_mappings = true; -- Bind default mappings
                debug = false; -- Print debug information
                opacity = nil; -- 0-100 opacity level of the floating window where 100 is fully transparent.
                post_open_hook = nil; -- A function taking two arguments, a buffer and a window to be ran as a hook.
                -- You can use "default_mappings = true" setup option
                -- Or explicitly set keybindings
                -- vim.cmd("nnoremap gpd <cmd>lua require('goto-preview').goto_preview_definition()<CR>");
                -- vim.cmd("nnoremap gpi <cmd>lua require('goto-preview').goto_preview_implementation()<CR>");
                -- vim.cmd("nnoremap gP <cmd>lua require('goto-preview').close_all_win()<CR>");
            }
        end
    },
    {
        "danymat/neogen",
        dependencies = "nvim-treesitter/nvim-treesitter",
        config = true,
        -- Uncomment next line if you want to follow only stable versions
        -- version = "*" 

    },
    {
        "rebelot/kanagawa.nvim"
    },
    {
        "kkoomen/vim-doge",
    },
    {
        "tpope/vim-surround"
    }

}
