--|
--| File    : ~/.config/nvim/init.lua
--| Author  : Fabien Cazenave
--| Source  : https://github.com/fabi1cazenave/dotFiles
--| Licence : WTFPL
--|

vim.cmd [[
  source ~/.config/nvim/settings.vim " generic Vim/NeoVim settings
  source ~/.config/nvim/mappings.vim " personal mappings, probably not worth sharing
]]
vim.api.nvim_create_augroup('NeovimConfig', {})
vim.api.nvim_create_autocmd('BufWritePost', {
  group = 'NeovimConfig',
  pattern = 'init.lua',
  command = "source %",
  desc = 'Auto-reload the configuration.',
})

-- best nvim GUI out there
if (vim.g.neovide) then
  -- vim.o.guifont = 'DejaVu Sans Mono:h9'
  vim.o.guifont = 'FantasqueSansMono Nerd Font Mono:h9'
  -- https://github.com/neovide/neovide/wiki/Configuration
  vim.g.neovide_floating_blur_amount_x  = 2.0
  vim.g.neovide_floating_blur_amount_y  = 2.0
  vim.g.neovide_scroll_animation_length = 0.3
  vim.g.neovide_cursor_animation_length = 0.13
  vim.g.neovide_cursor_vfx_mode         = 'wireframe'
end

-- see: https://github.com/nanotee/nvim-lua-guide

require('packer').startup(function()
  use 'wbthomason/packer.nvim' -- Packer can manage itself

  local function map(mode, key, action)
    vim.api.nvim_set_keymap(mode, key, action, { noremap=true, silent=true })
  end

  ------------------------------------------------------------------------------
  -- VimScript plugins
  ------------------------------------------------------------------------------

    -- in Tim Pope we trust
    use 'tpope/vim-sensible'     -- better default settings
    use 'tpope/vim-unimpaired'   -- better default mappings
    use 'tpope/vim-surround'     -- quoting/parenthesizing made simple
    use 'tpope/vim-repeat'       -- required to support `.` with some plugins
    use 'tpope/vim-characterize' -- `ga` gets the Unicode description of a char
    use 'tpope/vim-commentary'   -- toggle comments easily

    -- Git
    -- use 'tpope/vim-fugitive'

    -- start screen
    use 'mhinz/vim-startify'
    vim.g.startify_session_persistence = 1
    -- vim.api.nvim_create_autocmd("StartifyReady", {
    --   pattern = "*",
    --   callback = function(args)
    --     vim.api.nvim_win_set_config(0, { width=100, height=25, relative="editor", row=5, col=5 })
    --   end,
    --   desc = "Display Startify in a centered pop-up window.",
    -- })
    -- vim.cmd [[
    --   " let g:startify_padding_left = (winwidth(0) - 80) / 2
    --   autocmd! StartifyReady * 
    -- ]]

    -- all language packs, async’ed
    use 'sheerun/vim-polyglot'

    -- wmii/i3-like window management
    -- Alternative: 'jceb/vmux'
    -- use 'fabi1cazenave/suckless.vim'
    use '~/Documents/vimFiles/suckless.vim' -- local working directory
    vim.g.suckless_tmap = 1
    vim.g.suckless_show_tcd = 0
    -- not supported by Lua (invalid keys)
    -- vim.g.suckless_mappings = {
    --       '<M-[sdf]>'       =   'SetTilingMode("[sdf]")'     ,
    --       '<M-[hjkl]>'      =    'SelectWindow("[hjkl]")'    ,
    --       '<M-[HJKL]>'      =      'MoveWindow("[hjkl]")'    ,
    --     '<C-M-[hjkl]>'      =    'ResizeWindow("[hjkl]")'    ,
    --       '<M-[oO]>'        =    'CreateWindow("[sv]")'      ,
    --       '<M-w>'           =     'CloseWindow()'            ,
    --     '<C-M-w>'           =  'CollapseWindow()'            ,
    --       '<M-y>'           =       'CreateTab()'            ,
    --       '<M-[UI]>'        =         'MoveTab("[hl]")'      ,
    --       '<M-[ui]>'        =       'SelectTab("[hl]")'      ,
    --       '<M-[123456789]>' =       'SelectTab([123456789])' ,
    --     '<S-M-[123456789]>' = 'MoveWindowToTab([123456789])' ,
    -- }
    -- not loaded on time
    -- vim.g.suckless_mappings = {}
    -- vim.g.suckless_mappings[   '<M-[sdf]>'       ] =   'SetTilingMode("[sdf]")'
    -- vim.g.suckless_mappings[   '<M-[hjkl]>'      ] =    'SelectWindow("[hjkl]")'
    -- vim.g.suckless_mappings[   '<M-[HJKL]>'      ] =      'MoveWindow("[hjkl]")'
    -- vim.g.suckless_mappings[ '<C-M-[hjkl]>'      ] =    'ResizeWindow("[hjkl]")'
    -- vim.g.suckless_mappings[   '<M-[oO]>'        ] =    'CreateWindow("[sv]")'
    -- vim.g.suckless_mappings[   '<M-w>'           ] =     'CloseWindow()'
    -- vim.g.suckless_mappings[ '<C-M-w>'           ] =  'CollapseWindow()'
    -- vim.g.suckless_mappings[   '<M-y>'           ] =       'CreateTab()'
    -- vim.g.suckless_mappings[   '<M-[UI]>'        ] =         'MoveTab("[hl]")'
    -- vim.g.suckless_mappings[   '<M-[ui]>'        ] =       'SelectTab("[hl]")'
    -- vim.g.suckless_mappings[   '<M-[123456789]>' ] =       'SelectTab([123456789])'
    -- vim.g.suckless_mappings[   '<M-[!@#$%^&*«]>' ] = 'MoveWindowToTab([123456789])'
    -- vim.g.suckless_mappings[ '<S-M-[123456789]>' ] = 'MoveWindowToTab([123456789])'
    -- ugly but works
    vim.cmd [[
      let g:suckless_mappings = {
      \     '<M-[sdf]>'       :   'SetTilingMode("[sdf]")'     ,
      \     '<M-[hjkl]>'      :    'SelectWindow("[hjkl]")'    ,
      \     '<M-[HJKL]>'      :      'MoveWindow("[hjkl]")'    ,
      \   '<C-M-[hjkl]>'      :    'ResizeWindow("[hjkl]")'    ,
      \     '<M-[oO]>'        :    'CreateWindow("[sv]")'      ,
      \     '<M-w>'           :     'CloseWindow()'            ,
      \   '<C-M-w>'           :  'CollapseWindow()'            ,
      \     '<M-y>'           :       'CreateTab()'            ,
      \     '<M-[UI]>'        :         'MoveTab("[hl]")'      ,
      \     '<M-[ui]>'        :       'SelectTab("[hl]")'      ,
      \     '<M-[123456789]>' :       'SelectTab([123456789])' ,
      \     '<M-[!@#$%^&*«]>' : 'MoveWindowToTab([123456789])' ,
      \   '<S-M-[123456789]>' : 'MoveWindowToTab([123456789])' ,
      \}
    ]]
    vim.o.splitbelow = true -- consistency with most tiling WMs (wmii, i3…)
    vim.o.splitright = true

    -- lazy terminal management
    -- use 'fabi1cazenave/termopen.vim'
    use '~/Documents/vimFiles/termopen.vim' -- local working directory
    vim.g.termopen_mappings = 0
    map('n',   '<M-Return>',  ':call TermOpen("zsh")<CR>')
    map('n', '<S-M-Return>',  ':call TermOpen("zsh")<CR>')
    map('t',   '<M-Return>',  '<C-\\><C-n>')
    -- sometimes, M-Return does not work (e.g. Windows)
    map('n', '<Leader><Tab>', ':call TermOpen("zsh")<CR>')
    map('n', '<Leader> ',     ':call TermOpen("zsh", "f")<CR>')
    map('n', '<Leader>r',     ':call TermOpenRanger("lf")<CR>')
    map('n', '<Leader>T',     ':call TermOpen("tig status", "t")<CR>')
    map('n', '<Leader>H',     ':call TermOpen("tig --follow " . expand("%:p"), "f")<CR>')
    map('n', '<Leader>B',     ':call TermOpen("tig blame " . expand("%:p"), "f")<CR>')
    map('n', '<Leader>d',     ':call TermOpen("git diff", "f")<CR>')

    -- Authoring
    -- Plug 'vim-pandoc/vim-pandoc'
    -- Plug 'vim-pandoc/vim-pandoc-syntax'
    -- Plug 'suan/vim-instant-markdown'
    -- Plug 'jszakmeister/markdown2ctags'  " XXX to be tested
    -- Plug 'tpope/vim-markdown'
    use 'plasticboy/vim-markdown'
    vim.g.markdown_fenced_languages = { 'html', 'python', 'bash=sh' }
    -- vim.g.markdown_fenced_languages = {
    --   'css', 'erb=eruby', 'javascript', 'js=javascript', 'json=javascript', 'ruby', 'sass', 'xml', 'html'
    -- }

    -- highlight the yanked region
    use 'machakann/vim-highlightedyank'
    vim.g.highlightedyank_highlight_duration = 200

    -- skip folds when navigating with { and }
    use 'justinmk/vim-ipmotion'
    vim.g.ip_skipfold = 1

    -- Automatically clears search highlight when cursor is moved.
    -- Improved star-search (visual-mode, highlighting without moving).
    -- Alternative: 'romainl/vim-cool'
    use 'junegunn/vim-slash'

    -- Distraction-free writing
    use 'junegunn/goyo.vim'

    -- vertical alignment
    use 'junegunn/vim-easy-align'
    vim.api.nvim_set_keymap('x', '<Leader>a', '<Plug>(EasyAlign)', {})
    vim.api.nvim_set_keymap('n', '<Leader>a', '<Plug>(EasyAlign)', {})

  ------------------------------------------------------------------------------
  -- Lua plugins
  ------------------------------------------------------------------------------

    use 'nvim-lua/plenary.nvim'
    use 'nvim-lua/popup.nvim'

    use 'kyazdani42/nvim-web-devicons'

    -- TreeSitter
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use { 'nvim-treesitter/nvim-treesitter-context' }

    -- Language Server Protocol
    -- Alternative: 'kabouzeid/nvim-lspinstall'
    use 'neovim/nvim-lspconfig'

    -- LSP server for non-LSP sources
    -- use 'jose-elias-alvarez/null-ls.nvim'

    -- Linter that relies on vim.diagnostic
    use 'mfussenegger/nvim-lint'
    -- require('lint').linters_by_ft = { python = {'pylint'}, sh = {'shellcheck'} }
    vim.cmd('au BufWritePost * lua require("lint").try_lint()')
    -- vim.api.nvim_create_autocmd("BufWritePost", {
    --   pattern = "*",
    --   callback = function(args) require("lint").try_lint() end,
    --   desc = "Lint file when saved.",
    -- })

    -- Auto-Completion
    -- Alternative: 'ms-jpq/coq_nvim' (requires python 3.8.2+)
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'
    -- For vsnip users.
    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/vim-vsnip'

    -- Fancy List
    -- Alternative: 'glepnir/lspsaga.nvim'
    use 'nvim-telescope/telescope.nvim'
    -- map('n', '<Leader>r', ':Telescope file_browser<CR>')
    map('n', '<Leader>f', ':Telescope find_files<CR>')
    map('n', '<Leader>g', ':Telescope git_files<CR>')
    map('n', '<Leader>b', ':Telescope buffers<CR>')
    map('n', '<Leader>m', ':Telescope keymaps<CR>')

    -- use 'folke/trouble.nvim'
    -- nnoremap <Leader>xx <cmd>TroubleToggle<CR>
    -- nnoremap <Leader>xw <cmd>TroubleToggle workspace_diagnostics<CR>
    -- nnoremap <Leader>xd <cmd>TroubleToggle document_diagnostics<CR>
    -- nnoremap <Leader>xq <cmd>TroubleToggle quickfix<CR>
    -- nnoremap <Leader>xl <cmd>TroubleToggle loclist<CR>
    -- nnoremap <Leader>xr <cmd>TroubleToggle lsp_references<CR>

    -- Git
    use 'TimUntersberger/neogit'

    -- Git Markers
    -- Alternative: 'airblade/vim-gitgutter'
    -- Alternative: 'mhinz/vim-signify'
    -- Alternative: 'neoclide/coc-git'
    use 'lewis6991/gitsigns.nvim'

  ------------------------------------------------------------------------------
  -- Color Themes
  ------------------------------------------------------------------------------

    -- dark themes
    use 'nanotech/jellybeans.vim'
    use 'tomasr/molokai'
    use 'mhinz/vim-janah'
    use 'fcpg/vim-fahrenheit'
    use 'marfisc/vorange'
    use 'jacoborus/tender.vim'
    -- XXX not working with Neovim
    -- use 'zenorocha/dracula-theme'

    -- suitable themes for dark/light backgrounds, just set bg accordingly:
    --    :set background=[dark|light]
    use 'rakr/vim-one'
    use 'rakr/vim-two-firewatch'
    use 'junegunn/seoul256.vim'
    use 'noahfrederick/vim-hemisu'
    use 'freeo/vim-kalisi'
    use 'zanglg/nova.vim'
    use 'MvanDiemen/ghostbuster'
    use 'chmllr/elrodeo-vim-colorscheme' -- low-contrast `ghostbuster` variant
    use 'lifepillar/vim-solarized8'      -- working `solarized` variant for Neovim

    -- XXX not working with Neovim
    -- Plug 'altercation/vim-colors-solarized'
    -- Plug 'Slava/vim-colors-tomorrow'    " `solarized` variant
    -- Plug 'jsit/disco.vim'

    -- personal dark/light theme: kalahari ('desert' variant)
    -- use '~/Documents/vimFiles/kalahari.vim'
    use 'fabi1cazenave/kalahari.vim'
    vim.g.kalahari_groups = {
      { 'StatusLine', 16, 'Visual_bg', 'none' },
      { 'TabLineSel', 16, 'Visual_bg', 'none' },
      { 'fzf1',       16, 'Visual_bg', 'none' },
      { 'fzf2',       16, 'Visual_bg', 'none' },
      { 'fzf3',       16, 'Visual_bg', 'none' },
    }
    vim.cmd('colorscheme kalahari')

    -- terminal color hack -- only applied when a new terminal is open
    vim.g.terminal_color_0  = '#2e3436'
    vim.g.terminal_color_1  = '#cc0000'
    vim.g.terminal_color_2  = '#4e9a06'
    vim.g.terminal_color_3  = '#c4a000'
    vim.g.terminal_color_4  = '#3465a4'
    vim.g.terminal_color_5  = '#75507b'
    vim.g.terminal_color_6  = '#0b939b'
    vim.g.terminal_color_7  = '#d3d7cf'
    vim.g.terminal_color_8  = '#555753'
    vim.g.terminal_color_9  = '#ef2929'
    vim.g.terminal_color_10 = '#8ae234'
    vim.g.terminal_color_11 = '#fce94f'
    vim.g.terminal_color_12 = '#729fcf'
    vim.g.terminal_color_13 = '#ad7fa8'
    vim.g.terminal_color_14 = '#00f5e9'
    vim.g.terminal_color_15 = '#eeeeec'
end)

--
-- auto-completion (nvim-cmp)
--
local cmp = require('cmp')
local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end
local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end
cmp.setup({
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'buffer' },
  }),
  snippet = {
    expand = function(args) vim.fn["vsnip#anonymous"](args.body) end,
  },
  mapping = {
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif vim.fn["vsnip#available"](1) == 1 then
        feedkey("<Plug>(vsnip-expand-or-jump)", "")
      elseif has_words_before() then
        cmp.complete()
      else
        fallback() -- The fallback function sends an already mapped key (probably `<Tab>` here).
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_prev_item()
      elseif vim.fn["vsnip#jumpable"](-1) == 1 then
        feedkey("<Plug>(vsnip-jump-prev)", "")
      end
    end, { "i", "s" }),
    --   ['<C-f>']     = cmp.mapping(cmp.mapping.scroll_docs(4),  { 'i', 'c' }),
    --   ['<C-b>']     = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    --   ['<C-f>']     = cmp.mapping(cmp.mapping.scroll_docs(4),  { 'i', 'c' }),
    --   ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(),      { 'i', 'c' }),
    --   ['<C-y>']     = cmp.config.disable, --  remove the default `<C-y>` mapping
    --   ['<C-e>']     = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),
    --   ['<CR>']      = cmp.mapping.confirm({ select = true }),
  },
})
-- -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
-- cmp.setup.cmdline('/', {
--   sources = {
--     { name = 'buffer' }
--   }
-- })
-- -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
-- cmp.setup.cmdline(':', {
--   sources = cmp.config.sources({
--     { name = 'path' }
--   }, {
--     { name = 'cmdline' }
--   })
-- })

--
-- LSP keymaps (builtin + Telescope)
--
local on_attach = function(client, bufnr)
  -- local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local opt = { noremap=true, silent=true }
  local function buf_set_keymap_lsp(mode, key_seq, lsp_cmd)
    vim.api.nvim_buf_set_keymap(bufnr, mode, key_seq, '<cmd>lua vim.'..lsp_cmd..'<CR>', opt)
  end
  local function buf_set_keymap_tel(mode, key_seq, tel_cmd)
    vim.api.nvim_buf_set_keymap(bufnr, mode, key_seq, '<cmd>Telescope '..tel_cmd..'<CR>', opt)
  end
  -- enable completion triggered by <c-x><c-o>
  -- buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
  vim.bo.omnifunc = 'v:lua.vim.lsp.omnifunc'
  -- mappings
  buf_set_keymap_lsp('n', 'K',        'lsp.buf.hover()')
  buf_set_keymap_lsp('n', '<C-k>',    'lsp.buf.signature_help()')
  buf_set_keymap_lsp('n', 'gR',       'lsp.buf.rename()')
  buf_set_keymap_lsp('n', 'g=',       'lsp.buf.formatting()')
  buf_set_keymap_lsp('v', 'g=',       'lsp.buf.range_formatting()') -- XXX buggy
  buf_set_keymap_lsp('n', 'gi',       'lsp.buf.implementation()')   -- XXX not supported by Clang 8
  buf_set_keymap_lsp('n', '[<Enter>', 'diagnostic.goto_prev()')
  buf_set_keymap_lsp('n', ']<Enter>', 'diagnostic.goto_next()')
  -- LSP references, definitions and diagnostics are handled by Telescope
  buf_set_keymap_tel('n', 'gr',       'lsp_references')
  buf_set_keymap_tel('n', 'gd',       'lsp_definitions')
  buf_set_keymap_tel('n', 'gD',       'diagnostics')
  -- this should be restricted to clangd
  buf_set_keymap('n', 'gh', ':ClangdSwitchSourceHeader<CR>', opt)
end

-- require("trouble").setup {
--   -- your configuration comes here
--   -- or leave it empty to use the default settings
-- }

----
---- null.ls
----
--local null_ls = require("null-ls")
--local sources = {
--    -- null_ls.builtins.formatting.stylua,
--    -- null_ls.builtins.diagnostics.eslint,
--    null_ls.builtins.diagnostics.pylint,
--    null_ls.builtins.diagnostics.shellcheck,
--    null_ls.builtins.code_actions.shellcheck,
--    null_ls.builtins.completion.spell,
--}
--null_ls.setup({
--  sources = sources,
--  on_attach = on_attach,
--})
---- require("null-ls").setup({
----   sources = {
----     require("null-ls").builtins.formatting.stylua,
----     require("null-ls").builtins.diagnostics.eslint,
----     require("null-ls").builtins.diagnostics.shellcheck,
----     require("null-ls").builtins.completion.spell,
----   },
---- })

--
-- LSP activation: call 'setup' on multiple servers
-- and add local keybindings and snippet capabilities when the language server attaches
--
local lsp_servers = { 'clangd', 'pylsp' } -- see also: null-ls
local nvim_lsp = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
for _, lsp in ipairs(lsp_servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    },
    capabilities = capabilities,
  }
end

require('gitsigns').setup {
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns
    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']c', function()
      if vim.wo.diff then return ']c' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, {expr=true})
    map('n', '[c', function()
      if vim.wo.diff then return '[c' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    -- Actions
    map({'n', 'v'}, '<leader>hs', ':Gitsigns stage_hunk<CR>')
    map({'n', 'v'}, '<leader>hr', ':Gitsigns reset_hunk<CR>')
    map('n', '<leader>hS', gs.stage_buffer)
    map('n', '<leader>hu', gs.undo_stage_hunk)
    map('n', '<leader>hR', gs.reset_buffer)
    map('n', '<leader>hp', gs.preview_hunk)
    map('n', '<leader>hb', function() gs.blame_line{full=true} end)
    map('n', '<leader>tb', gs.toggle_current_line_blame)
    map('n', '<leader>hd', gs.diffthis)
    map('n', '<leader>hD', function() gs.diffthis('~') end)
    map('n', '<leader>td', gs.toggle_deleted)

    -- Text object
    map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end
}

require('lint').linters_by_ft = {
  python = {'pylint'},
  sh = {'shellcheck'},
  -- markdown = {'vale',}
}

-- TreeSitter
require('nvim-treesitter.configs').setup {
  -- A list of parser names, or "all"
  ensure_installed = { "c", "cpp", "jsonc", "lua", "python", "rust" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- List of parsers to ignore installing (for "all")
  ignore_install = { "javascript" },

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this
    -- is the name of the parser)
    -- list of language that will be disabled
    -- disable = { "c", "lua", "rust" },
    disable = { "lua" },

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

require('treesitter-context').setup {
  enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
  max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
  trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
  patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
    -- For all filetypes
    -- Note that setting an entry here replaces all other patterns for this entry.
    -- By setting the 'default' entry below, you can control which nodes you want to
    -- appear in the context window.
    default = {
      'class',
      'function',
      'method',
      -- 'for', -- These won't appear in the context
      -- 'while',
      -- 'if',
      -- 'switch',
      -- 'case',
    },
    -- Example for a specific filetype.
    -- If a pattern is missing, *open a PR* so everyone can benefit.
    --   rust = {
    --       'impl_item',
    --   },
  },
  exact_patterns = {
    -- Example for a specific filetype with Lua patterns
    -- Treat patterns.rust as a Lua pattern (i.e "^impl_item$" will
    -- exactly match "impl_item" only)
    -- rust = true,
  },
  -- [!] The options below are exposed but shouldn't require your attention,
  --     you can safely ignore them.
  zindex = 20,      -- The Z-index of the context window
  mode = 'cursor',  -- Line used to calculate context. Choices: 'cursor', 'topline'
}
